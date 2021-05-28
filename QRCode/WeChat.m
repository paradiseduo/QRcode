//
//  WeChat.m
//  QRCode
//
//  Created by Paradiseduo on 2021/5/24.
//  Copyright © 2021 Paradiseduo. All rights reserved.
//

#import "WeChat.h"
#import <opencv2/WeChatQRCode.h>


@implementation WeChat
+ (void)showScreenRecordingPrompt {
  
  /* macos 10.14 and lower do not require screen recording permission to get window titles */
    if(@available(macos 10.15, *)) {
    /*
     To minimize the intrusion just make a 1px image of the upper left corner
     This way there is no real possibilty to access any private data
     */
        CGImageRef c = CGWindowListCreateImage(CGRectMake(0, 0, 1, 1), kCGWindowListOptionOnScreenOnly, kCGNullWindowID, kCGWindowImageDefault);
        CFRelease(c);
    }
}

+ (NSArray<NSString *> *)scanQRCodeOnScreen {
    NSMutableArray* foundStrings = [NSMutableArray array];
    
    /* displays[] Quartz display ID's */
    CGDirectDisplayID   *displays = nil;

    CGError             err = CGDisplayNoErr;
    CGDisplayCount      dspCount = 0;

    /* How many active displays do we have? */
    err = CGGetActiveDisplayList(0, NULL, &dspCount);

    /* If we are getting an error here then their won't be much to display. */
    if (err != CGDisplayNoErr) {
        [foundStrings addObject:[[NSString alloc] initWithFormat:@"Could not get active display count (%d)\n", err]];
        return foundStrings;
    }

    /* Allocate enough memory to hold all the display IDs we have. */
    displays = calloc((size_t)dspCount, sizeof(CGDirectDisplayID));

    // Get the list of active displays
    err = CGGetActiveDisplayList(dspCount, displays, &dspCount);

    /* More error-checking here. */
    if (err != CGDisplayNoErr) {
        [foundStrings addObject:[[NSString alloc] initWithFormat:@"Could not get active display list (%d)\n", err]];
        return foundStrings;
    }


    for (unsigned int displaysIndex = 0; displaysIndex < dspCount; displaysIndex++) {
        /* Make a snapshot image of the current display. */
        CGImageRef image = CGDisplayCreateImage(displays[displaysIndex]);
        Mat * m = [[Mat alloc] initWithCGImage:image];
        WeChatQRCode * w = [[WeChatQRCode alloc] init];
        NSArray * arr = [w detectAndDecode:m];
        [foundStrings addObjectsFromArray:arr];
        CGImageRelease(image);
    }

    free(displays);
    return foundStrings;
}
@end
