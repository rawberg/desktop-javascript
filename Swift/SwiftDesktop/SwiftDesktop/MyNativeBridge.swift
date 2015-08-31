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
            println("JS Exception: \(exception)")
        }
    }
       
    func fetchMountedVolumes(jsOptions: JSValue) {
        let volumes = self.getMountedVolumes()
        let jsCallback: JSValue = jsOptions.objectForKeyedSubscript("callback")

        jsCallback.callWithArguments([volumes])
    }
    
    func getMountedVolumes() -> NSMutableArray {
        var volumesList = NSMutableArray()
        let fileManager = NSFileManager.defaultManager()
        let volumeResKeys = [NSURLVolumeLocalizedNameKey,
                             NSURLVolumeTotalCapacityKey,
                             NSURLVolumeAvailableCapacityKey,
                             NSURLVolumeIsBrowsableKey,
                             NSURLVolumeIdentifierKey,
                             NSURLVolumeURLKey]
        
        let volumeUrls = fileManager.mountedVolumeURLsIncludingResourceValuesForKeys(volumeResKeys, options: nil)
        
        for volUrl in volumeUrls! {
            var volKeyError: NSError?
            var volName: AnyObject?
            var volIdentifier: AnyObject?
            var volBrowsable: AnyObject?
            var volAvailableCapacity: AnyObject?
            var volTotalCapacity: AnyObject?
            
            volUrl.getResourceValue(&volName, forKey: NSURLVolumeLocalizedNameKey, error: &volKeyError)
            volUrl.getResourceValue(&volIdentifier, forKey: NSURLVolumeURLKey, error: &volKeyError)
            volUrl.getResourceValue(&volBrowsable, forKey: NSURLVolumeIsBrowsableKey, error: &volKeyError)
            volUrl.getResourceValue(&volAvailableCapacity, forKey: NSURLVolumeAvailableCapacityKey, error: &volKeyError)
            volUrl.getResourceValue(&volTotalCapacity, forKey: NSURLVolumeTotalCapacityKey, error: &volKeyError)
            
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
                volumesList.addObject(NSDictionary(objectsAndKeys:
                                        volIdentifier!, "id",
                                        volName!, "name",
                                        availableCapacityCount, "bytesAvailableCount",
                                        availableCapacityUnit, "bytesAvailableUnit",
                                        totalCapacityCount, "bytesTotalCount",
                                        totalCapacityUnit, "bytesTotalUnit")
                )
            }
            
        }
        return volumesList
    }
}