#import <JavaScriptCore/JavaScriptCore.h>
#import <Cocoa/Cocoa.h>

@protocol NativeBridgeJSExport <JSExport>
- (void)fetchMountedVolumes:(JSValue *)jsOptions;
@end

@interface NativeBridge : NSObject <NativeBridgeJSExport>
- (void)fetchMountedVolumes:(JSValue *)jsoptions;
@end