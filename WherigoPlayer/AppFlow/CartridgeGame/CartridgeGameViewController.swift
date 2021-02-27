//
//  CartridgeGameViewController.swift
//  WherigoPlayer
//
//  Created by Balázs Horváth on 2021. 01. 23..
//

import UIKit

class CartridgeGameViewController: UIViewController {
    // MARK: Properties
    private weak var enginePollingTimer: Timer?
    private lazy var uiEventHandler = WIGUIEventHandler()
    private lazy var locationEventHandler = WIGLocationEventHandler()

    var cartridgeFile: WIGCartridgeFile!

    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        startGameEngine()
        setupUIEventHandlers()
    }

    deinit {
        enginePollingTimer?.invalidate()
        WIGEngine.kill()
    }

    // MARK: Setup Game
    private func startGameEngine() {
        Log.debug("startGame")

        let logOutputStream = CartridgeService.createLogOutputStream(for: cartridgeFile)

        guard let engine = WIGEngine.newInstance(
            with: cartridgeFile,
            with: logOutputStream,
            with: uiEventHandler,
            with: locationEventHandler
        ) else {
            return
        }

        engine.start()
        observeCartridgeLoading()
    }

    private func observeCartridgeLoading() {
        enginePollingTimer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { [unowned self] _ in
            // Starting engine takes time, we're polling when it's ready for use
            guard WIGEngine.instance.value(forKey: "cartridge_") as? WIGCartridge != nil,
                  LocationService.shared.location != nil
            else { return }

            self.enginePollingTimer?.invalidate()
            self.cartridgeDidLoad()
        }
    }

    private func cartridgeDidLoad() {
        Log.debug("cartridgeDidLoad()")

        guard let cartridge = WIGEngine.instance.value(forKey: "cartridge_") as? WIGCartridge,
              let zones = cartridge.value(forKey: "zones_") as? WIGVector,
              let tasks = cartridge.value(forKey: "tasks_") as? WIGVector,
              let timers = cartridge.value(forKey: "timers_") as? WIGVector,
              let actions = cartridge.value(forKey: "universalActions_") as? WIGVector,
              let things = cartridge.value(forKey: "things_") as? WIGVector,
              let firstZone = zones.getWith(0) as? WIGZone,
              let firstZoneDistance = firstZone.value(forKey: "distance_") as? Double
        else { return }

        Log.debug("Zones: \(zones)")
        Log.debug("Visible zone count: \(cartridge.visibleZones())")
        Log.debug("First zone name: \(firstZone)")
        Log.debug("First zone distance: \(firstZoneDistance)")

        Log.debug("Tasks: \(tasks)")
        Log.debug("Timers: \(timers)")
        Log.debug("Actions: \(actions)")
        Log.debug("Things: \(things)")

        Log.debug("Done")
    }
}

// MARK: Wherigo UI Event Handlers
extension CartridgeGameViewController {
    private func setupUIEventHandlers() {
        setupDidPushQuestion()
    }

    private func setupDidPushQuestion() {
        uiEventHandler.didPushQuestion = { [weak self] question in
            switch question.inputType {
            case .freeText:
                DispatchQueue.main.async {
                    let freeTextScreen = UIStoryboard.cartridgeGame
                        .instantiateViewController(FreeTextQuestionViewController.self)
                    freeTextScreen.displayItem = question

                    self?.present(freeTextScreen, animated: true)
                }
            case .multipleChoice:
                DispatchQueue.main.async {
                    let multipleChoiceScreen = UIStoryboard.cartridgeGame
                        .instantiateViewController(MultipleChoiceQuestionViewController.self)
                    multipleChoiceScreen.displayItem = question

                    self?.present(multipleChoiceScreen, animated: true)
                }
            case .none:
                break
            }
        }
    }
}
