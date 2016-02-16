//
//  ZXWRetrivedData.h
//  找新窝
//
//  Created by 卜千 郑 on 16/2/2.
//  Copyright © 2016年 卜千 郑. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ZXWRetriveData : NSObject
@property (strong, nonatomic) NSMutableArray *resultArray;
@property (nonatomic) int pageNumber;
@property (strong, nonatomic) NSString *searchKeyword;
@property (strong) NSMutableArray *userHeadPortraitArray;

- (void)startWithBlock:(void (^)())block;
//- (void)endInput      :(void (^)())completion;
//- (instancetype)initWithSearchKeyWord:(NSString *)searchKeyWord andPageNumber:(int)pageNumber;
@end
