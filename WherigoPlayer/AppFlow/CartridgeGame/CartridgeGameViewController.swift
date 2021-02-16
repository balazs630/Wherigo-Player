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
    var cartridgeFile: WIGCartridgeFile!

    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        startGame()
    }

    deinit {
        enginePollingTimer?.invalidate()
        WIGEngine.kill()
    }

    // MARK: Actions
    private func startGame() {
        Log.debug("startGame")

        let logOutputStream = CartridgeService.createLogOutputStream(for: cartridgeFile)
        let uiEventHandler = WIGUIEventHandler()
        let locationEventHandler = WIGLocationEventHandler()

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

    private func cartridgeDidLoad() {
        Log.debug("cartridgeDidLoad()")
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
}
