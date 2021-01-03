//
//  WIGUIEventHandler.swift
//  WhereIGoPlayer
//
//  Created by Balázs Horváth on 2020. 12. 30..
//

class WIGUIEventHandler: NSObject, WIGUIProtocol {
    func refresh() {
        debugPrint("refresh")
    }

    func start() {
        debugPrint("start")
        showScreen(with: WIGUI.MAINSCREEN, with: nil)
    }

    func end() {
        debugPrint("end")
    }

    func showError(with message: String!) {
        debugPrint("showError with message: \(String(describing: message))")
    }

    func debugMsg(with message: String!) {
        debugPrint("debugMsg with message: \(String(describing: message))")
    }

    func setStatusTextWith(_ text: String!) {
        debugPrint("setStatusTextWith text: \(String(describing: text))")
    }

    func pushDialog(
        withNSStringArray texts: IOSObjectArray!,
        withWIGMediaArray media: IOSObjectArray!,
        with button1: String!,
        with button2: String!,
        with dismissCallback: WIGLuaClosure!
    ) {
        debugPrint("""
            pushDialog
                withNSStringArray texts: \(String(describing: texts)),
                withWIGMediaArray media: \(String(describing: media)),
                with button1: \(String(describing: button1)),
                with button2: \(String(describing: button2)),
                with callback: \(String(describing: dismissCallback))
        """)
    }

    func pushInput(with input: WIGEventTable!) {
        debugPrint("pushInput with input: \(String(describing: input))")
    }

    func showScreen(with screenId: Int32, with details: WIGEventTable!) {
        debugPrint("showScreen with screenId \(screenId), with details: \(String(describing: details))")
    }

    func playSound(with data: IOSByteArray!, with mimeType: String!) {
        debugPrint("playSound with data: \(String(describing: data)), with mimeType: \(String(describing: mimeType))")
    }

    func blockForSaving() {
        debugPrint("blockForSaving")
    }

    func unblock() {
        debugPrint("unblock")
    }

    func command(with cmd: String!) {
        debugPrint("command with cmd: \(String(describing: cmd))")
    }
}
