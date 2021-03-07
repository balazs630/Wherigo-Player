//
//  WIGUIEventHandler.swift
//  WhereIGoPlayer
//
//  Created by Balázs Horváth on 2020. 12. 30..
//

// swiftlint:disable cyclomatic_complexity

class WIGUIEventHandler: NSObject {
    // MARK: Constants
    enum ScreenID: Int32 {
        case main = 0
        case detail = 1
        case inventory = 2
        case item = 3
        case location = 4
        case task = 5
        case root = 10
        case cartDetail = 11
        case actions = 12
        case targets = 13
        case map = 14
    }

    // MARK: Closures
    var didPushQuestion: ((QuestionInputDisplayItem) -> Void)?
    var didPushDialog: ((QuestionDialogDisplayItem) -> Void)?
}

// MARK: WIGUIProtocol methods
extension WIGUIEventHandler: WIGUIProtocol {
    func refresh() {
        Log.debug("refresh")
    }

    func start() {
        Log.debug("start")
        showScreen(with: ScreenID.main.rawValue, with: nil)
    }

    func end() {
        Log.debug("end")
        CartridgeService.stopWIGEngine()
        showScreen(with: ScreenID.root.rawValue, with: nil)
    }

    func showError(with message: String) {
        Log.debug("showError with message: \(String(describing: message))")
    }

    func debugMsg(with message: String) {
        Log.debug("debugMsg with message: \(String(describing: message))")
    }

    func setStatusTextWith(_ text: String) {
        Log.debug("setStatusTextWith")
    }

    func pushDialog(
        withNSStringArray texts: IOSObjectArray,
        withWIGMediaArray media: IOSObjectArray,
        with primaryButtonTitle: String,
        with secondaryButtonTitle: String,
        with callback: WIGLuaClosure
    ) {
        Log.debug("pushDialog")
        let displayItem = QuestionDialogDisplayItem(
            texts: texts,
            media: media,
            primaryButtonTitle: primaryButtonTitle,
            secondaryButtonTitle: secondaryButtonTitle,
            callback: callback
        )
        didPushDialog?(displayItem)
    }

    func pushInput(with eventTable: WIGEventTable) {
        Log.debug("pushInput")
        let displayItem = QuestionInputDisplayItem(eventTable: eventTable)
        didPushQuestion?(displayItem)
    }

    func showScreen(with screenId: Int32, with details: WIGEventTable?) {
        switch screenId {
        case ScreenID.main.rawValue:
            Log.debug("showScreen: main")
        case ScreenID.cartDetail.rawValue:
            Log.debug("showScreen: cartDetail")
        case ScreenID.detail.rawValue:
            Log.debug("showScreen: detail")
        case ScreenID.inventory.rawValue:
            Log.debug("showScreen: inventory")
        case ScreenID.item.rawValue:
            Log.debug("showScreen: item")
        case ScreenID.location.rawValue:
            Log.debug("showScreen: location")
        case ScreenID.task.rawValue:
            Log.debug("showScreen: task")
        case ScreenID.actions.rawValue:
            Log.debug("showScreen: actions")
        case ScreenID.targets.rawValue:
            Log.debug("showScreen: targets")
        case ScreenID.map.rawValue:
            Log.debug("showScreen: map")
        default:
            Log.debug("showScreen: undefined")
        }
    }

    func playSound(with sound: IOSByteArray, with mimeType: String) {
        Log.debug("playSound")
        AudioService.play(sound, with: mimeType)
    }

    func blockForSaving() {
        Log.debug("blockForSaving")
    }

    func unblock() {
        Log.debug("unblock")
    }

    func command(with command: String) {
        Log.debug("command")
        if command == "StopSound" {
            AudioService.stop()
        } else if command == "Alert" {
            AudioService.playBeep()
        }
    }
}
