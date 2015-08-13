//
//  MyFrameLoadDelegate.m
//  Objective-C
//
//  Copyright (c) 2015 DesktopJavaScript. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyFrameLoadDelegate.h"
#import "MyNativeBridge.h"

@interface MyFrameLoadDelegate ()

@end

@implementation MyFrameLoadDelegate

-(void)webView:(WebView *)sender didCreateJavaScriptContext:(JSContext *)context forFrame:(WebFrame *)frame {
    MyNativeBridge *myNativeBridge = [[MyNativeBridge alloc] init];
    context[@"nativeBridge"] = myNativeBridge;
}

@end
