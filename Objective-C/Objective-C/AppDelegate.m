//
//  AppDelegate.m
//  Objective-C
//
//  Copyright (c) 2015 DesktopJavaScript. All rights reserved.
//

#import "AppDelegate.h"
#import "MainWindowController.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@property NSWindowController *mainWindowController;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    self.mainWindowController = [[MainWindowController alloc] init];
    [self.mainWindowController showWindow: self.window];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end
