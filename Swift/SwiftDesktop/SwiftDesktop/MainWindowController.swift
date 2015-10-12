//
//  MainWindowController.swift
//  SwiftDesktop
//
//  Copyright (c) 2015 DesktopJavaScript. All rights reserved.
//

import Cocoa
import Foundation
import WebKit

class MainWindowController: NSWindowController {
    var myWebView: WebKit.WebView?
    let myFrameLoadDelegate = MyFrameLoadDelegate()
    
    override var windowNibName: String? {
        return "MainWindowController"
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
        
        let webDevExtras: String = "WebKitDeveloperExtras"
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: webDevExtras)
        NSUserDefaults.standardUserDefaults().synchronize()
        
        self.myWebView = WebKit.WebView(frame: self.window!.contentView!.bounds, frameName: "MainWindowController", groupName: "")
        self.myWebView?.autoresizingMask = [NSAutoresizingMaskOptions.ViewWidthSizable, NSAutoresizingMaskOptions.ViewHeightSizable]
        self.window!.contentView!.addSubview(self.myWebView!)
        

        self.myWebView!.frameLoadDelegate = self.myFrameLoadDelegate
        self.myWebView?.mainFrame.loadRequest(NSURLRequest(URL: NSURL(string: "http://demo.desktopjavascript.com")!))
    }
}