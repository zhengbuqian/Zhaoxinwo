//
//  UITitleLabel.m
//  找新窝
//
//  Created by 卜千 郑 on 16/2/16.
//  Copyright © 2016年 卜千 郑. All rights reserved.
//

#import "UITitleLabel.h"

@implementation UITitleLabel

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)tap:(UIGestureRecognizer *)gr {
    NSLog(@"title taped, test override method");
    NSURL *postURL = [NSURL URLWithString:self.postLink];
    [[UIApplication sharedApplication] openURL:postURL];
}

@end
