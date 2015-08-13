//
//  MyNativeBridge.m
//  Objective-C
//
//  Copyright (c) 2015 DesktopJavaScript. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyNativeBridge.h"

@implementation MyNativeBridge

- (void)fetchMountedVolumes:(JSValue *)jsOptions {
    NSMutableArray *volumes = [self getMountedVolumes];
    
    JSValue *jsCallback = [jsOptions valueForProperty: @"callback"];
    [jsCallback callWithArguments:@[volumes]];
}

- (NSMutableArray *)getMountedVolumes {
    NSMutableArray *volumesList = [[NSMutableArray alloc] init];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *volumeResKeys = [NSArray arrayWithObjects:
                              NSURLVolumeLocalizedNameKey,
                              NSURLVolumeTotalCapacityKey,
                              NSURLVolumeAvailableCapacityKey,
                              NSURLVolumeIsBrowsableKey,
                              NSURLVolumeIdentifierKey,
                              NSURLVolumeURLKey,
                              nil];
    
    NSArray *volumeUrls = [fileManager mountedVolumeURLsIncludingResourceValuesForKeys: volumeResKeys options:0];
    for (NSURL *volUrl in volumeUrls) {
        NSError *volKeyError;
        NSString *volName;
        NSString *volIdentifer;
        NSNumber *volBrowsable;
        NSNumber *volAvailableCapacity;
        NSNumber *volTotalCapacity;
        
        
        [volUrl getResourceValue:&volName forKey:NSURLVolumeLocalizedNameKey error:&volKeyError];
        [volUrl getResourceValue:&volIdentifer forKey:NSURLVolumeURLKey error:&volKeyError];
        [volUrl getResourceValue:&volTotalCapacity forKey: NSURLVolumeTotalCapacityKey error:&volKeyError];
        [volUrl getResourceValue:&volAvailableCapacity forKey: NSURLVolumeAvailableCapacityKey error:&volKeyError];
        [volUrl getResourceValue:&volBrowsable forKey:NSURLVolumeIsBrowsableKey error:&volKeyError];
        
        NSByteCountFormatter *byteFormatter = [[NSByteCountFormatter alloc] init];
        byteFormatter.allowsNonnumericFormatting = NO;
        
        byteFormatter.includesUnit = NO;
        byteFormatter.includesCount = YES;
        NSString *availableCapacityCount = [byteFormatter stringFromByteCount:volAvailableCapacity.longLongValue];
        NSString *totalCapacityCount = [byteFormatter stringFromByteCount:volTotalCapacity.longLongValue];
        
        byteFormatter.includesUnit = YES;
        byteFormatter.includesCount = NO;
        NSString *availableCapacityUnit = [byteFormatter stringFromByteCount:volAvailableCapacity.longLongValue];
        NSString *totalCapacityUnit = [byteFormatter stringFromByteCount:volTotalCapacity.longLongValue];
        
        if ([volBrowsable boolValue]) {
            [volumesList addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                                    volIdentifer, @"id",
                                    volName, @"name",
                                    availableCapacityCount, @"bytesAvailableCount",
                                    availableCapacityUnit, @"bytesAvailableUnit",
                                    totalCapacityCount, @"bytesTotalCount",
                                    totalCapacityUnit, @"bytesTotalUnit",
                                    nil]
             ];
        }
    }
    return volumesList;
}

@end