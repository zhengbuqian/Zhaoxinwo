//
//  ZXWInfoCell.m
//  找新窝
//
//  Created by 卜千 郑 on 16/2/2.
//  Copyright © 2016年 卜千 郑. All rights reserved.
//

#import "ZXWInfoCell.h"
#import "UITitleLabel.h"
#import "UIMainContentLabel.h"

#define RGBColor(r, g, b) [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:1]


@interface ZXWInfoCell ()
@property (weak, nonatomic) IBOutlet UILabel *authorNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorPubTimeLabel;
@property (weak, nonatomic) IBOutlet UITitleLabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *similarMessageLabel;
//@property (weak, nonatomic) IBOutlet UIButton *mainContentButton;
@property (weak, nonatomic) IBOutlet UILabel *mainContentLabel;
@property (weak, nonatomic) IBOutlet UILabel *metroLabel;
@property (weak, nonatomic) IBOutlet UILabel *adressLabel;
@property (weak, nonatomic) IBOutlet UILabel *jushiLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UICellLabel *cellLabel;
//@property (weak) IBOutlet UIImage *userHeadPortrait;
@property (strong, nonatomic) IBOutlet UIImageView *userHeadPortraitImageView;
@property (weak, nonatomic) IBOutlet UIButton *cellButton;

@end

@implementation ZXWInfoCell


- (instancetype)init {
    self = [super init];
    if (self) {
        [self labelAttachTapHandler:self.mainContentLabel
                         withAction:@selector(mainContentLabelTapped)];
    }
    return self;
}
 
- (void)awakeFromNib {
    [self labelAttachTapHandler:self.mainContentLabel
                     withAction:@selector(mainContentLabelTapped)];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setAuthorNameString:(NSString *)authorNameString {
    _authorNameString = [authorNameString copy];
    self.authorNameLabel.text = _authorNameString;
}
- (void)setAuthorPubTimeString:(NSString *)authorPubTimeString {
    _authorPubTimeString = [authorPubTimeString copy];
    self.authorPubTimeLabel.text = _authorPubTimeString;
}
- (void)setPostLinkString:(NSString *)postLinkString {
    _postLinkString = [postLinkString copy];
    self.titleLabel.postLink = _postLinkString;
}
- (void)setTitleString:(NSString *)titleString {
    _titleString = [titleString copy];
    self.titleLabel.text = _titleString;
}
- (void)setSimilarMessageString:(NSString *)similarMessageString {
    _similarMessageString = [similarMessageString copy];
    self.similarMessageLabel.text = _similarMessageString;
}
- (void)setMainContentString:(NSString *)mainContentString {
    _mainContentString = [mainContentString copy];
    /*[self.mainContentButton setTitle:_mainContentString
                            forState:UIControlStateNormal];
    [self.mainContentButton layoutIfNeeded];*/
    self.mainContentLabel.text = _mainContentString;
}
- (void)setMetroString:(NSString *)metroString {
    _metroString = [metroString copy];
    
    if ([_metroString length] > 1) {
        NSArray *allMetroArray = @[@"1号线", @"2号线", @"大兴线", @"4号线", @"5号线", @"6号线", @"7号线", @"8号线", @"9号线", @"10号线", @"13号线", @"14号线", @"15号线", @"房山线", @"昌平线", @"亦庄线", @"机场线", @"八通线"];
        NSArray *metroColorArray = @[RGBColor(0xff, 0x66, 0x66),
                                     RGBColor(0x00, 0x99, 0xcc),
                                     RGBColor(0x66, 0x33, 0x66),
                                     RGBColor(0xff, 0x69, 0xb4),
                                     RGBColor(0xcc, 0xcc, 0x33),
                                     RGBColor(0x99, 0xcc, 0x33),
                                     RGBColor(0xff, 0xff, 0x66),
                                     RGBColor(0x33, 0xcc, 0x33),
                                     RGBColor(0x33, 0x33, 0x66),
                                     RGBColor(0x66, 0x33, 0x99),
                                     RGBColor(0x00, 0x66, 0x33),
                                     RGBColor(0xff, 0x99, 0xcc),
                                     RGBColor(0x00, 0x80, 0x80),
                                     RGBColor(0xff, 0xb6, 0xc1),
                                     RGBColor(0xff, 0x7f, 0x50),
                                     RGBColor(0x80, 0x80, 0x00),
                                     RGBColor(0xda, 0xa5, 0x20),
                                     RGBColor(0xff, 0x00, 0xff)];
        
        NSDictionary *attribs = @{
                                  NSForegroundColorAttributeName: self.metroLabel.textColor,
                                  NSFontAttributeName: self.metroLabel.font
                                  };
        NSMutableAttributedString *metroAttributedString =
            [[NSMutableAttributedString alloc] initWithString:_metroString
                                                   attributes:attribs];
        int colorIndex = 0;
        for (NSString *metro in allMetroArray) {
            
            NSRange range = [metroString rangeOfString:metro];
            if (range.location != NSNotFound) {
                [metroAttributedString setAttributes:
                    @{NSForegroundColorAttributeName:[metroColorArray objectAtIndex:colorIndex]}
                                               range:range];
            }
            
            colorIndex++;
        }
        self.metroLabel.attributedText = metroAttributedString;
        self.metroLabel.hidden = NO;
    } else {
        self.metroLabel.hidden = YES;
    }
    
    
}
- (void)setAdressString:(NSString *)adressString {
    _adressString = [adressString copy];
    self.adressLabel.text = _adressString;
}
- (void)setJushiString:(NSString *)jushiString {
    _jushiString = [jushiString copy];
    self.jushiLabel.text = _jushiString;
}
- (void)setPriceString:(NSString *)priceString {
    _priceString = [priceString copy];
    self.priceLabel.text = _priceString;
}
- (void)setCellString:(NSString *)cellString {
    
    
    _cellString = [cellString copy];
    
    if ([_cellString length] > 2) {
        NSDictionary *attribs = @{
                                  NSForegroundColorAttributeName: self.cellLabel.textColor,
                                  NSFontAttributeName: self.cellLabel.font
                                  };
        NSAttributedString *cellAttributedString =
                [[NSAttributedString alloc] initWithString:_cellString
                                                attributes:attribs];
        self.cellLabel.attributedText = cellAttributedString;
        self.cellLabel.hidden = NO;
    } else {
        self.cellLabel.hidden = YES;
    }
    
    //self.cellLabel.text = _cellString;
}
- (void)setUserHeadPortrait:(UIImage *)userHeadPortrait {
    _userHeadPortrait = [userHeadPortrait copy];
    self.userHeadPortraitImageView.image = _userHeadPortrait;
}
- (void)setCellData:(NSDictionary *)cellData {
    _cellData = [cellData copy];
    NSDictionary *authorInfoDic = _cellData[@"author"];
    self.authorNameString = authorInfoDic[@"name"];
    self.authorPubTimeString = _cellData[@"pub_time"];
    self.titleString = _cellData[@"title"];
    self.mainContentString = _cellData[@"text"];
    self.postLinkString = _cellData[@"url"];
    
    // 重复发帖
    NSArray *simMessages = _cellData[@"sim"];
    NSUInteger simMessageCount = [simMessages count];
    if (simMessageCount > 0) {
        self.similarMessageString = [NSString stringWithFormat:@"重复发帖%lu次", (unsigned long)simMessageCount];
    } else {
        self.similarMessageString = @"";
    }
    
    // 地铁
    NSArray *metroArray = _cellData[@"ditie"];
    NSMutableString *metroLabelString = [NSMutableString stringWithCapacity:80];
    for(NSString *metro in metroArray) {
        [metroLabelString appendString:metro];
        [metroLabelString appendString:@" "];
    }
    self.metroString = metroLabelString;
    
    // 地址
    NSArray *adressArray = _cellData[@"dizhi"];
    NSMutableString *adressLabelString = [NSMutableString stringWithCapacity:200];
    for (NSString *adress in adressArray) {
        [adressLabelString appendString:adress];
        [adressLabelString appendString:@" "];
    }
    self.adressString = adressLabelString;
    
    // 居室
    NSString *jushiLabelString = _cellData[@"jushi"];
    self.jushiString = jushiLabelString;
    
    // 价格
    NSString *priceLabelString = _cellData[@"zujin"];
    self.priceString = priceLabelString;
    
    // 手机
    NSString *cellLabelString = _cellData[@"shouji"];
    self.cellString = cellLabelString;
    if ([cellLabelString length] < 5) {
        self.cellLabel.hidden = YES;
        self.cellButton.hidden = YES;
    }
    
    
}

- (void)mainContentLabelTapped {
    NSLog(@"main content label tapped");
    (self.mainContentLabel.numberOfLines == 0) ?
            [self.mainContentLabel setNumberOfLines:5]:
            [self.mainContentLabel setNumberOfLines:0];
    //[self.superview reloadData];
}

- (void)labelAttachTapHandler:(UILabel *)inputLabel withAction:(nullable SEL)action{
    inputLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                            action:action];
    [inputLabel addGestureRecognizer:tapGR];
}

@end
