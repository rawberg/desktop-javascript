//
//  MyNativeBridge.swift
//  SwiftDesktop
//
//  Copyright (c) 2015 DesktopJavaScript. All rights reserved.
//

import Cocoa
import Foundation
import JavaScriptCore

@objc protocol MyNativeBridgeJSExport: JSExport {
    func fetchMountedVolumes(jsOptions: JSValue)
}

class MyNativeBridge: NSObject, MyNativeBridgeJSExport {
    let jsContext: JSContext
    
    init(newContext: JSContext) {
        self.jsContext = newContext
        
        self.jsContext.exceptionHandler = { context, exception in
            print("JS Exception: \(exception)")
        }
    }
       
    func fetchMountedVolumes(jsOptions: JSValue) {
        let volumes = self.getMountedVolumes()
        let jsCallback: JSValue = jsOptions.objectForKeyedSubscript("callback")

        jsCallback.callWithArguments([volumes])
    }
    
    func getMountedVolumes() -> NSMutableArray {
        let volumesList = NSMutableArray()
        let fileManager = NSFileManager.defaultManager()
        let volumeResKeys = [NSURLVolumeLocalizedNameKey,
                             NSURLVolumeTotalCapacityKey,
                             NSURLVolumeAvailableCapacityKey,
                             NSURLVolumeIsBrowsableKey,
                             NSURLVolumeIdentifierKey,
                             NSURLVolumeURLKey]
        
        let volumeUrls = fileManager.mountedVolumeURLsIncludingResourceValuesForKeys(volumeResKeys, options: [NSVolumeEnumerationOptions.SkipHiddenVolumes])
        for volUrl in volumeUrls! {
            var volName: AnyObject?
            var volIdentifier: AnyObject?
            var volBrowsable: AnyObject?
            var volAvailableCapacity: AnyObject?
            var volTotalCapacity: AnyObject?
            
            do {
                try volUrl.getResourceValue(&volName, forKey: NSURLVolumeLocalizedNameKey)
                try volUrl.getResourceValue(&volIdentifier, forKey: NSURLVolumeURLKey)
                try volUrl.getResourceValue(&volBrowsable, forKey: NSURLVolumeIsBrowsableKey)
                try volUrl.getResourceValue(&volAvailableCapacity, forKey: NSURLVolumeAvailableCapacityKey)
                try volUrl.getResourceValue(&volTotalCapacity, forKey: NSURLVolumeTotalCapacityKey)
            } catch {
                NSLog("Error reading volumes.")
            }
            
            let byteFormatter: NSByteCountFormatter = NSByteCountFormatter()
            byteFormatter.allowsNonnumericFormatting = false
            
            byteFormatter.includesUnit = false
            byteFormatter.includesCount = true
            let availableCapacityCount = byteFormatter.stringFromByteCount(volAvailableCapacity!.longLongValue)
            let totalCapacityCount = byteFormatter.stringFromByteCount(volTotalCapacity!.longLongValue)
            
            byteFormatter.includesUnit = true
            byteFormatter.includesCount = false
            let availableCapacityUnit = byteFormatter.stringFromByteCount(volAvailableCapacity!.longLongValue)
            let totalCapacityUnit = byteFormatter.stringFromByteCount(volTotalCapacity!.longLongValue)
            
            if (volBrowsable!.boolValue == true) {
                volumesList.addObject(["id": volIdentifier!,
                                     "name": volName!,
                      "bytesAvailableCount": availableCapacityCount,
                       "bytesAvailableUnit": availableCapacityUnit,
                          "bytesTotalCount": totalCapacityCount,
                           "bytesTotalUnit": totalCapacityUnit])
            }
            
        }
        return volumesList
    }
}