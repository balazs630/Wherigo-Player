//
//  WIGUIEventHandler.swift
//  WhereIGoPlayer
//
//  Created by Balázs Horváth on 2020. 12. 30..
//

class WIGUIEventHandler: NSObject {
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
        showScreen(with: WIGUI.MAINSCREEN, with: nil)
    }

    func end() {
        Log.debug("end")
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
        Log.debug("showScreen")
    }

    func playSound(with data: IOSByteArray, with mimeType: String) {
        Log.debug("playSound")
    }

    func blockForSaving() {
        Log.debug("blockForSaving")
    }

    func unblock() {
        Log.debug("unblock")
    }

    func command(with cmd: String) {
        Log.debug("command")
    }
}
