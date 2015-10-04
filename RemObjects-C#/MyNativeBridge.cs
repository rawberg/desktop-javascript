using Foundation;
using WebKit;
using JavaScriptCore;

namespace RemObjectsC {
	public interface MyNativeBridgeJSExport: IJSExport {
		void fetchMountedVolumes(JSValue jsOptions);
	}
	
	class MyNativeBridge: MyNativeBridgeJSExport {
		JSContext jsContext { get; set; }
		
		public MyNativeBridge(JSContext newContext) {
			this.jsContext = newContext;
		}
		
		public void fetchMountedVolumes(JSValue jsOptions) {
			NSMutableArray volumes = this.getMountedVolumes();
			JSValue jsCallback = jsOptions.valueForProperty("callback");
			jsCallback.callWithArguments(volumes);
		}
		
		public NSMutableArray getMountedVolumes() {
			NSMutableArray emptyArray = new NSMutableArray();
			return emptyArray;
		}
	}
}
