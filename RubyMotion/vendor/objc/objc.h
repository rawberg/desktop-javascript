#import <WebKit/WebKit.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import <Cocoa/Cocoa.h>

@protocol MyNativeBridgeJSExport <JSExport>
- (void)fetchMountedVolumes:(JSValue *)jsOptions;
@end