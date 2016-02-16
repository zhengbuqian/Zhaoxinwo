//
//  UIEmailLabel.m
//  找新窝
//
//  Created by 卜千 郑 on 16/2/16.
//  Copyright © 2016年 卜千 郑. All rights reserved.
//

#import "UIEmailLabel.h"

@implementation UIEmailLabel

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

//- (void)copyText {
//    UIPasteboard *pb = [[UIPasteboard alloc] init];
//    pb.string = self.text;
//}

- (void)tap:(UIGestureRecognizer *)gr {
    /*
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"是否复制邮箱地址到剪贴板？"
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirmYES = [UIAlertAction actionWithTitle:@"好的"
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction *action) {
                                                           UIPasteboard *pb = [[UIPasteboard alloc] init];
                                                           pb.string = self.text;
                                                       }];
    UIAlertAction *confirmNO = [UIAlertAction actionWithTitle:@"不用了"
                                                        style:UIAlertActionStyleDefault
                                                      handler:nil];
    [alert addAction:confirmYES];
    [alert addAction:confirmNO];
    //[self.superview present];
     */
}

@end
