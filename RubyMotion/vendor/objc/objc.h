#import <JavaScriptCore/JavaScriptCore.h>
#import <Cocoa/Cocoa.h>

@protocol VendorNativeBridgeJSExport <JSExport>
- (void)fetchMountedVolumes:(JSValue *)jsOptions;
@end

@interface VendorNativeBridge : NSObject <VendorNativeBridgeJSExport>
- (void)fetchMountedVolumes:(JSValue *)jsoptions;
@end