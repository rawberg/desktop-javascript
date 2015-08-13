//
//  MyNativeBridge.h
//  Objective-C
//
//  Copyright (c) 2015 DesktopJavaScript. All rights reserved.
//

#ifndef Objective_C_MyNativeBridge_h
#define Objective_C_MyNativeBridge_h

#import <WebKit/WebKit.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import <Cocoa/Cocoa.h>

@class MyNativeBridge;

@protocol MyNativeBridgeJSExport <JSExport>
- (void)fetchMountedVolumes:(JSValue *)jsOptions;
@end

@interface MyNativeBridge : NSObject <MyNativeBridgeJSExport>
- (NSMutableArray *)getMountedVolumes;
@end

#endif