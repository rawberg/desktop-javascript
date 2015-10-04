using Foundation;
using JavaScriptCore;
using WebKit;

namespace RemObjectsC {

	public class MyFrameLoadDelegate: IWebFrameLoadDelegate {
	
		public void webView(WebView webView) didCreateJavaScriptContext(JSContext context) forFrame(WebFrame frame) {
			MyNativeBridge myNativeBridge = new MyNativeBridge();
			context["nativeBridge"] = myNativeBridge;
		}
	}
}
