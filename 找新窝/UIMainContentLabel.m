//
//  UIMainContentLabel.m
//  找新窝
//
//  Created by 卜千 郑 on 16/2/18.
//  Copyright © 2016年 卜千 郑. All rights reserved.
//

#import "UIMainContentLabel.h"

@implementation UIMainContentLabel

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)tap:(UIGestureRecognizer *)gr {
    
    [self becomeFirstResponder];
    NSLog(@"main content label tapped");
    (self.numberOfLines == 0) ? [self setNumberOfLines:5]: [self setNumberOfLines:0];
    
}

@end
