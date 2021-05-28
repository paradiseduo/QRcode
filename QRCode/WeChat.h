//
//  WeChat.h
//  QRCode
//
//  Created by Paradiseduo on 2021/5/24.
//  Copyright © 2021 Paradiseduo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WeChat : NSObject
+ (NSArray<NSString *> *)scanQRCodeOnScreen;
+ (void)showScreenRecordingPrompt;
+ (BOOL)canRecordScreen;
@end

NS_ASSUME_NONNULL_END
