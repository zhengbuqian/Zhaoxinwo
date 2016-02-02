//
//  ZXWInfoCell.m
//  找新窝
//
//  Created by 卜千 郑 on 16/2/2.
//  Copyright © 2016年 卜千 郑. All rights reserved.
//

#import "ZXWInfoCell.h"

@interface ZXWInfoCell ()
@property (weak, nonatomic) IBOutlet UILabel *authorNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorPubTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *similarMessageLabel;
@property (weak, nonatomic) IBOutlet UILabel *mainContentLabel;
@property (weak, nonatomic) IBOutlet UILabel *metroLabel;
@property (weak, nonatomic) IBOutlet UILabel *adressLabel;
@property (weak, nonatomic) IBOutlet UILabel *jushiLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellLabel;

@end

@implementation ZXWInfoCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)setAuthorNameString:(NSString *)authorNameString {
    _authorNameString = [authorNameString copy];
    self.authorNameLabel.text = _authorNameString;
}
- (void)setAuthorPubTimeString:(NSString *)authorPubTimeString {
    _authorPubTimeString = [authorPubTimeString copy];
    self.authorPubTimeLabel.text = _authorPubTimeString;
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
    self.mainContentLabel.text = _mainContentString;
}
- (void)setMetroString:(NSString *)metroString {
    _metroString = [metroString copy];
    self.metroLabel.text = _metroString;
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
    self.cellLabel.text = _cellString;
}

@end
