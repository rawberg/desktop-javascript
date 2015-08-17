//
//  MainWindowController.m
//  Objective-C
//
//  Copyright (c) 2015 DesktopJavaScript. All rights reserved.
//

#import "MainWindowController.h"
#import "MyFrameLoadDelegate.h"
#import "WebKit/WebKit.h"
#import "JavaScriptCore/JavaScriptCore.h"

@interface MainWindowController ()

@end

@implementation MainWindowController
@synthesize myWebView;

- (NSString *)windowNibName {
    return @"MainWindowController";
}

- (void)windowDidLoad {
    [super windowDidLoad];
    
    NSString* const webDevExtras = @"WebKitDeveloperExtras";
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey: webDevExtras];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [myWebView setFrameLoadDelegate: [[MyFrameLoadDelegate alloc] init]];
    [[myWebView mainFrame] loadRequest: [NSURLRequest requestWithURL: [NSURL URLWithString:@"http://demo.desktopjavascript.com/index.html"]]];
}

@end
