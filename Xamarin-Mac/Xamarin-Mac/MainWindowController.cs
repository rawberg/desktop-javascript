using System;

using Foundation;
using AppKit;
using WebKit;

namespace XamarinMac {
    public partial class MainWindowController : NSWindowController {
        [Outlet]
        WebKit.WebView myWebView { get; set; }

        public MainWindowController(IntPtr handle)
            : base(handle) {
        }

        [Export("initWithCoder:")]
        public MainWindowController(NSCoder coder)
            : base(coder) {
        }

        public MainWindowController()
            : base("MainWindow") {
        }

        public override void AwakeFromNib() {
            base.AwakeFromNib();

            NSUserDefaults.StandardUserDefaults.SetBool(true, "WebKitDeveloperExtras");
            NSUserDefaults.StandardUserDefaults.Synchronize();

            myWebView = new WebKit.WebView(Window.ContentView.Bounds, "MainWindow", "");
            myWebView.AutoresizingMask = NSViewResizingMask.WidthSizable | NSViewResizingMask.HeightSizable;
            Window.ContentView.AddSubview(myWebView);

            myWebView.FrameLoadDelegate = new MyFrameLoadDelegate();
            myWebView.MainFrame.LoadRequest(new NSUrlRequest(new NSUrl("http://demo.desktopjavascript.dev:8888")));
        }

        public new MainWindow Window {
            get { return (MainWindow)base.Window; }
        }

        [Export("windowNibName")]
        public override string WindowNibName { get { return "MainWindow"; } }
    }
}
