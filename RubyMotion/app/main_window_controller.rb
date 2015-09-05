class MainWindowController < NSWindowController
  def initialize(window)
    initWithWindow(window)
    self.loadWindow
  end

  def loadWindow
    # windowWillLoad
    super
    windowDidLoad
  end

  def windowNibName
    "MainWindowController"
  end

  def windowDidLoad
    super
    self.window.title = NSBundle.mainBundle.infoDictionary['CFBundleName']
    NSUserDefaults.standardUserDefaults.setBool(true, forKey: "WebKitDeveloperExtras")
    NSUserDefaults.standardUserDefaults.synchronize
    @myWebView = WebView.alloc.initWithFrame(NSMakeRect(0, 0, 540, 400))
    @myWebView.setAutoresizingMask(NSViewMinXMargin|NSViewMaxXMargin|NSViewMinYMargin|NSViewMaxYMargin|NSViewWidthSizable|NSViewHeightSizable)

    @myWebView.frameLoadDelegate = MyFrameLoadDelegate.new
    @myWebView.mainFrame.loadRequest(NSURLRequest.requestWithURL(NSURL.URLWithString("http://demo.desktopjavascript.com")))

    self.window.contentView.addSubview(@myWebView)
    self.window.orderFrontRegardless
  end
end