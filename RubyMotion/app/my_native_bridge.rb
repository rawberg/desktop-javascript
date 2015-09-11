class MyNativeBridge < NativeBridge
  def fetchMountedVolumes(jsOptions)
    volumes = self.getMountedVolumes
    jsCallback = jsOptions["callback"]
    jsCallback.callWithArguments([volumes])
  end

  def getMountedVolumes
    volumesList = []
    fileManager = NSFileManager.defaultManager

    propertyKeys = [NSURLVolumeLocalizedNameKey,
                    NSURLVolumeTotalCapacityKey,
                    NSURLVolumeAvailableCapacityKey,
                    NSURLVolumeIsBrowsableKey,
                    NSURLVolumeIdentifierKey,
                    NSURLVolumeURLKey]
    volumeUrls = fileManager.mountedVolumeURLsIncludingResourceValuesForKeys(propertyKeys, options: 0)
    volumeUrls.each do |volumeUrl|
      volKeyError = Pointer.new(:object)
      volName = Pointer.new(:object)
      volIdentifier = Pointer.new(:object)
      volBrowsable = Pointer.new(:object)
      volAvailableCapacity = Pointer.new(:object)
      volTotalCapacity = Pointer.new(:object)

      volumeUrl.getResourceValue(volName, forKey: NSURLLocalizedNameKey, error: volKeyError)
      volumeUrl.getResourceValue(volIdentifier, forKey: NSURLVolumeIdentifierKey, error: volKeyError)
      volumeUrl.getResourceValue(volTotalCapacity, forKey: NSURLVolumeTotalCapacityKey, error: volKeyError)
      volumeUrl.getResourceValue(volAvailableCapacity, forKey: NSURLVolumeAvailableCapacityKey, error: volKeyError)
      volumeUrl.getResourceValue(volBrowsable, forKey: NSURLVolumeIsBrowsableKey, error: volKeyError)

      byteFormatter = NSByteCountFormatter.alloc.init
      byteFormatter.allowsNonnumericFormatting = false

      byteFormatter.includesUnit = false
      byteFormatter.includesCount = true
      availableCapacityCount = byteFormatter.stringFromByteCount(volAvailableCapacity[0])
      totalCapacityCount = byteFormatter.stringFromByteCount(volTotalCapacity[0])

      byteFormatter.includesUnit = true
      byteFormatter.includesCount = false
      availableCapacityUnit = byteFormatter.stringFromByteCount(volAvailableCapacity[0])
      totalCapacityUnit = byteFormatter.stringFromByteCount(volTotalCapacity[0])


      volumesList << {
        :id => volIdentifier[0],
        :name => volName[0],
        :bytesAvailableCount => availableCapacityCount,
        :bytesAvailableUnit  => availableCapacityUnit,
        :bytesTotalCount     => totalCapacityCount,
        :bytesTotalUnit      => totalCapacityUnit
      } if volBrowsable[0]
    end

    return volumesList
  end
end