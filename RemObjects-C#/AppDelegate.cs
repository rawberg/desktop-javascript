﻿using AppKit;

namespace RemObjectsC {
	[NSApplicationMain, IBObject]
	class AppDelegate : INSApplicationDelegate {
		public MainWindowController mainWindowController { get; set; }

		public void applicationDidFinishLaunching(NSNotification notification) {
			mainWindowController = new MainWindowController();
			mainWindowController.showWindow(null);
		}

	}
}
