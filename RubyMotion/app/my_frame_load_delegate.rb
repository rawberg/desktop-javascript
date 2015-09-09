class MyFrameLoadDelegate
  def webView(sender, didFinishLoadForFrame: frame)
    NSLog("MyFrameLoadDelegate - finished loading")
  end

  def webView(sender, didCreateJavaScriptContext: context, forFrame: frame)
    NSLog("MyFrameLoadDelegate - did create javascript context")
    nativeBridge = MyNativeBridge.alloc.init
    context["nativeBridge"] = nativeBridge
    # context.evaluateScript('console.log("hello from ruby motion")')
  end
end