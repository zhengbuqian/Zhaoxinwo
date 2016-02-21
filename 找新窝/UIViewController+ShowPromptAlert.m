//
//  UIViewController+ShowPromptAlert.m
//  找新窝
//
//  Created by 卜千 郑 on 16/2/21.
//  Copyright © 2016年 卜千 郑. All rights reserved.
//

#import "UIViewController+ShowPromptAlert.h"

@implementation UIViewController (ShowPromptAlert)
- (void)timerFireMethod:(NSTimer*)theTimer//弹出框
{
    UIAlertView *promptAlert = (UIAlertView*)[theTimer userInfo];
    [promptAlert dismissWithClickedButtonIndex:0 animated:NO];
    promptAlert =NULL;
}

- (void)showAlert:(NSString *) message{//时间
    [self showAlertTitle:nil message:message timeInterval:1.5f];
}
- (void)showAlert:(NSString *)message withTimeInterval:(CGFloat)timeInterval {
    [self showAlertTitle:nil message:message timeInterval:timeInterval];
}
- (void)showAlertTitle:(NSString *)title
               message:(NSString *)message
          timeInterval:(CGFloat)timeInterval {
    UIAlertView *promptAlert = [[UIAlertView alloc] initWithTitle:title
                                                          message:message
                                                         delegate:nil
                                                cancelButtonTitle:nil
                                                otherButtonTitles:nil];
    
    [NSTimer scheduledTimerWithTimeInterval:timeInterval
                                     target:self
                                   selector:@selector(timerFireMethod:)
                                   userInfo:promptAlert
                                    repeats:YES];
    [promptAlert show];

}
@end
