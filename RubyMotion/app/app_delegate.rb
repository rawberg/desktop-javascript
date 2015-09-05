class AppDelegate
  attr_reader :window, :mainWindowController

  def initialize
    mask = NSTitledWindowMask|NSClosableWindowMask|NSMiniaturizableWindowMask|NSResizableWindowMask
    backing = NSBackingStoreBuffered
    rect = NSRect.new([240, 180], [540, 400])
    window = NSWindow.alloc.initWithContentRect(rect, styleMask: mask, backing: backing, defer: false)
    @mainWindowController = MainWindowController.new(window)
    @window = @mainWindowController.window
  end

  def applicationDidFinishLaunching(notification)
    buildMenu
  end
end
