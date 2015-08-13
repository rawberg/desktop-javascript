using Foundation;
using WebKit;
using JavaScriptCore;

namespace RemObjectsC {
	# error E28: Unknown type "JSExport"
	interface MyNativeBridgeJSExport: JSExport {
		void FetchMountedVolumes(JSValueRef jsOptions);
	}
	
	# error E48: There are no overloads that have 1 generic parameters
	public class MyNativeBridge: NSObject <MyNativeBridgeJSExport> {
		JSContextRef jsContext { get; set; }
		
		public void FetchMountedVolumes(JSValueRef jsOptions) {
		
		}
	}
}
