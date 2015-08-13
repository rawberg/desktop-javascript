using System;
using Foundation;
using JavaScriptCore;

namespace XamarinMac {
    [Protocol()]
    interface IJsExporter: IJSExport {
        [Export("fetchMountedVolumes:")]
        void FetchMountedVolumes(JSValue jsOptions);
    }

    public class MyNativeBridge: NSObject, IJsExporter {
        JSContext jsContext { get; set; }

        public MyNativeBridge(JSContext newContext) : base() {
            jsContext = newContext;
        }

        public void FetchMountedVolumes(JSValue jsOptions) {
            NSMutableArray volumes = GetMountedVolumes();
            JSValue[] args = new JSValue[] {JSValue.From(volumes, jsContext)};

            // not callable see Bug #17550
            // https://bugzilla.xamarin.com/show_bug.cgi?id=17550
            JSValue jsValueCallback = jsOptions.GetProperty("callback");

            // work-around for #17550
            JSValue workAroundCallback = jsContext[(NSString)"render"];
            workAroundCallback.Call(args);
        }

        public NSMutableArray GetMountedVolumes() {
            NSMutableArray volumeList = new NSMutableArray();
            NSArray volKeys = NSArray.FromNSObjects(
                NSUrl.VolumeLocalizedNameKey,
                NSUrl.VolumeTotalCapacityKey,
                NSUrl.VolumeAvailableCapacityKey,
                NSUrl.VolumeIsBrowsableKey,
                NSUrl.VolumeURLKey,
                NSUrl.VolumeUUIDStringKey
            );

            NSFileManager fileManager = new NSFileManager();
            NSUrl[] volumeUrls = fileManager.GetMountedVolumes(volKeys, NSVolumeEnumerationOptions.None);
            NSByteCountFormatter byteFormatter = new NSByteCountFormatter();
            byteFormatter.CountStyle = NSByteCountFormatterCountStyle.File;

            foreach(NSUrl volumeUrl in volumeUrls) {
                NSError volUrlError;
                NSObject volName;
                NSObject volIdentifer;
                NSObject volBrowsable;
                NSObject volBytesAvailable;
                NSObject volBytesTotal;

                volumeUrl.TryGetResource(NSUrl.VolumeLocalizedNameKey, out volName, out volUrlError);
                volumeUrl.TryGetResource(NSUrl.VolumeURLKey, out volIdentifer, out volUrlError);
                volumeUrl.TryGetResource(NSUrl.VolumeIsBrowsableKey, out volBrowsable, out volUrlError);
                volumeUrl.TryGetResource(NSUrl.VolumeAvailableCapacityKey, out volBytesAvailable, out volUrlError);
                volumeUrl.TryGetResource(NSUrl.VolumeTotalCapacityKey, out volBytesTotal, out volUrlError);

                NSNumber volBytesAvailableNum = (NSNumber)volBytesAvailable;
                NSNumber volBytesTotalNum = (NSNumber)volBytesTotal;

                byteFormatter.IncludesUnit = false;
                byteFormatter.IncludesCount = true;

                var volBytesAvailableCount = byteFormatter.Format(volBytesAvailableNum.LongValue);
                var volBytesTotalCount = byteFormatter.Format(volBytesTotalNum.LongValue);

                byteFormatter.IncludesUnit = true;
                byteFormatter.IncludesCount = false;
                var volBytesAvailableUnit = byteFormatter.Format(volBytesAvailableNum.LongValue);
                var volBytesTotalUnit = byteFormatter.Format(volBytesTotalNum.LongValue);

                NSNumber browsable = (NSNumber)volBrowsable;
                if (browsable.BoolValue) {
                    volumeList.Add(new NSDictionary(
                        "name", volName,
                        "id", volIdentifer,
                        "bytesAvailableCount", volBytesAvailableCount,
                        "bytesAvailableUnit", volBytesAvailableUnit,
                        "bytesTotalCount", volBytesTotalCount,
                        "bytesTotalUnit", volBytesTotalUnit
                    ));
                }
            }

            return volumeList;
        }
    }
}

