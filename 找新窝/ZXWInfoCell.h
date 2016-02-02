//
//  ZXWInfoCell.h
//  找新窝
//
//  Created by 卜千 郑 on 16/2/2.
//  Copyright © 2016年 卜千 郑. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZXWInfoCell : UITableViewCell
@property (copy, nonatomic) NSString *authorNameString;
@property (copy, nonatomic) NSString *authorPubTimeString;
@property (copy, nonatomic) NSString *titleString;
@property (copy, nonatomic) NSString *similarMessageString;
@property (copy, nonatomic) NSString *mainContentString;
@property (copy, nonatomic) NSString *metroString;
@property (copy, nonatomic) NSString *adressString;
@property (copy, nonatomic) NSString *jushiString;
@property (copy, nonatomic) NSString *priceString;
@property (copy, nonatomic) NSString *cellString;

@property (copy, nonatomic) NSDictionary *cellData;
@end
