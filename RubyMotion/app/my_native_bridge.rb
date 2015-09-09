class MyNativeBridgeJSExport < NSObject

end

class MyNativeBridge < MyNativeBridgeJSExport
  def fetchMountedVolumes(jsOptions)
    jsCallback = jsOptions["callback"]
    jsCallback.callWithArguments([])
  end
end