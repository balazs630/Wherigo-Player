//
//  WIGUIEventHandler.swift
//  WhereIGoPlayer
//
//  Created by Balázs Horváth on 2020. 12. 30..
//

class WIGUIEventHandler: NSObject, WIGUIProtocol {
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

    func showError(with message: String!) {
        Log.debug("showError with message: \(String(describing: message))")
    }

    func debugMsg(with message: String!) {
        Log.debug("debugMsg with message: \(String(describing: message))")
    }

    func setStatusTextWith(_ text: String!) {
        Log.debug("setStatusTextWith text: \(String(describing: text))")
    }

    func pushDialog(
        withNSStringArray texts: IOSObjectArray!,
        withWIGMediaArray media: IOSObjectArray!,
        with button1: String!,
        with button2: String!,
        with dismissCallback: WIGLuaClosure!
    ) {
        Log.debug("""
            pushDialog
                withNSStringArray texts: \(String(describing: texts)),
                withWIGMediaArray media: \(String(describing: media)),
                with button1: \(String(describing: button1)),
                with button2: \(String(describing: button2)),
                with callback: \(String(describing: dismissCallback))
        """)
    }

    func pushInput(with eventTable: WIGEventTable!) {
        Log.debug("pushInput with input: \(QuestionInputDisplayItem(eventTable: eventTable)))")
    }

    func showScreen(with screenId: Int32, with details: WIGEventTable!) {
        Log.debug("showScreen with screenId \(screenId), with details: \(String(describing: details))")
    }

    func playSound(with data: IOSByteArray!, with mimeType: String!) {
        Log.debug("playSound with data: \(String(describing: data)), with mimeType: \(String(describing: mimeType))")
    }

    func blockForSaving() {
        Log.debug("blockForSaving")
    }

    func unblock() {
        Log.debug("unblock")
    }

    func command(with cmd: String!) {
        Log.debug("command with cmd: \(String(describing: cmd))")
    }
}
