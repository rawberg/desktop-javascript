class MyNativeBridge < VendorNativeBridge
  def fetchMountedVolumes(jsOptions)
    jsCallback = jsOptions["callback"]
    jsCallback.callWithArguments([[
                                   {:id => "uniqua",
                                    :name => "Mac HD",
                                    :bytesAvailableCount => 100,
                                    :bytesAvailableUnit => "GB",
                                    :bytesTotalCount => 500,
                                    :bytesTotalUnit => "GB",
                                   }
                                 ]])
  end
end