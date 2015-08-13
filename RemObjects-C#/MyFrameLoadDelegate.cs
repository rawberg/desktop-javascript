using Foundation;
using JavaScriptCore;
using WebKit;

namespace RemObjectsC {

	public class MyFrameLoadDelegate: NSObject {
	
		public void webView(WebView webView) didCreateJavaScriptContext(JSContextRef context) forFrame(WebFrame frame) {
			# error E44: No member "evaluateScript" on type "JSContextRef"
			context.evaluateScript("console.log('hello from native');");
			MyNativeBridge myNativeBridge = new MyNativeBridge();
			context["nativeBridge"] = myNativeBridge;
		}
	}
}
