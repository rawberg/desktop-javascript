//
//  MainWindowController.h
//  Objective-C
//
//  Copyright (c) 2015 DesktopJavaScript. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>

@interface MainWindowController : NSWindowController
@property (strong) IBOutlet WebView *myWebView;
@end
