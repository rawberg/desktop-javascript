using AppKit;
using JavaScriptCore;
using WebKit;

namespace RemObjectsC {
	[IBObject]
	public class MainWindowController : NSWindowController {
		[IBOutlet]
		public WebView myWebView { get; set; }
		
		public override instancetype init() {
			this = base.initWithWindowNibName("MainWindowController");
			if (this != null) {
				// Custom initialization
			}
			return this;
		}

		public override void windowDidLoad() {
			base.windowDidLoad();
			
			myWebView.frameLoadDelegate = new MyFrameLoadDelegate();
			
			NSUserDefaults.standardUserDefaults.setBool(true) forKey("WebKitDeveloperExtras");
			NSUserDefaults.standardUserDefaults.synchronize();
			
			NSURLRequest req = new NSURLRequest withURL(new NSURL withString("http://demo.desktopjavascript.dev:8888/"));
			myWebView.mainFrame.loadRequest(req);
		}
	}
}
