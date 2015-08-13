using System;
using Foundation;
using ObjCRuntime;
using WebKit;
using JavaScriptCore;

namespace XamarinMac {
    partial class MyFrameLoadDelegate : WebFrameLoadDelegate {
        JSContext jsContext { get; set; }
        MyNativeBridge nativeBridge { get; set; }

        [Export("webView:didCreateJavaScriptContext:forFrame:")]
        public void DidCreateJavascriptContext(WebView view, JSContext context, WebFrame frame) {
            jsContext = context;
            jsContext.ExceptionHandler = (JSContext contextException, JSValue exception) => {
                Console.WriteLine("JavaScript Exception: {0}", exception);
            };

            nativeBridge = new MyNativeBridge(jsContext);
            jsContext[(NSString)"nativeBridge"] = JSValue.From(nativeBridge, jsContext);
        }
    }
}

