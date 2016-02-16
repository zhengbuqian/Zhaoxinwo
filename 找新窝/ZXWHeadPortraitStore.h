//
//  ZXWHeadPortraitStore.h
//  找新窝
//
//  Created by 卜千 郑 on 16/2/14.
//  Copyright © 2016年 卜千 郑. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ZXWHeadPortraitStore : NSObject

+ (instancetype)sharedStore;
- (void)setImage:(UIImage *)image forKey:(NSString *)key;
- (UIImage *)imageForKey:(NSString *)key;
- (void)deleteImageForKey:(NSString *)key;
@end
