//
//  ZXWInfoTableViewController.h
//  找新窝
//
//  Created by 卜千 郑 on 16/2/2.
//  Copyright © 2016年 卜千 郑. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZXWInfoTableViewController : UITableViewController <UITableViewDelegate>

@property (strong, nonatomic) NSString *searchKeyWord;
@property (nonatomic) int pageNumber;

- (instancetype)initWithSearchKeyword:(NSString *)searchKeyWord;
- (void)startRetriveData;
@end
