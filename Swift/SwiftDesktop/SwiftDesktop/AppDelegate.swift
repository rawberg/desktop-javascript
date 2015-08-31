//
//  AppDelegate.swift
//  SwiftDesktop
//
//  Copyright (c) 2015 DesktopJavaScript. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

//    @IBOutlet weak var window: NSWindow!
    var mainWindowController: MainWindowController?


    func applicationDidFinishLaunching(aNotification: NSNotification) {
        self.mainWindowController = MainWindowController()
        self.mainWindowController!.showWindow(self)
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }


}

