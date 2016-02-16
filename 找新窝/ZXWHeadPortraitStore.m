//
//  ZXWHeadPortraitStore.m
//  找新窝
//
//  Created by 卜千 郑 on 16/2/14.
//  Copyright © 2016年 卜千 郑. All rights reserved.
//

#import "ZXWHeadPortraitStore.h"

@interface ZXWHeadPortraitStore ()

@property (nonatomic, strong) NSMutableDictionary *dictionary;

@end


@implementation ZXWHeadPortraitStore

+ (instancetype)sharedStore {
    static ZXWHeadPortraitStore *sharedStore = nil;
    if (!sharedStore) {
        sharedStore = [[self alloc] initPrivate];
    }
    return sharedStore;
}

- (instancetype)init {
    @throw [NSException exceptionWithName:@"Singleton"
                                   reason:@"Use [ZXWHeadPortraitStrore sharedStore]"
                                 userInfo:nil];
    return nil;
}
- (instancetype)initPrivate {
    self = [super init];
    if (self) {
        _dictionary = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)setImage:(UIImage *)image forKey:(NSString *)key {
    [self.dictionary setObject:image forKey:key];
}

- (void)deleteImageForKey:(NSString *)key {
    if (!key) {
        return;
    }
    [self.dictionary removeObjectForKey:key];
}

- (UIImage *)imageForKey:(NSString *)key {
    return [self.dictionary objectForKey:key];
}

@end
