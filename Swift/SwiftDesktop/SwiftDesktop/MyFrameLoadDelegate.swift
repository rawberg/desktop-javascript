//
//  MyFrameLoadDelegate.swift
//  SwiftDesktop
//
//  Copyright (c) 2015 DesktopJavaScript. All rights reserved.
//

import Cocoa
import WebKit
import JavaScriptCore

class MyFrameLoadDelegate: NSObject {
    
    override func webView(sender: WebView!, didCreateJavaScriptContext context: JSContext!, forFrame: WebFrame!) {
        let myNativeBridge = MyNativeBridge(newContext: context)
        context.setObject(myNativeBridge, forKeyedSubscript: "nativeBridge")
    }
}
