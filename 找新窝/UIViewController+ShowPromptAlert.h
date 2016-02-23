//
//  UIViewController+ShowPromptAlert.h
//  找新窝
//
//  Created by 卜千 郑 on 16/2/21.
//  Copyright © 2016年 卜千 郑. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (ShowPromptAlert)
- (void)showPromptAlert:(NSString *) _message;

- (void)showPromptAlert:(NSString *)message
 withTimeInterval:(CGFloat)timeInterval;

- (void)showPromptAlertTitle:(NSString *)title
               message:(NSString *)message
          timeInterval:(CGFloat)timeInterval;

- (void)showAlertTitle:(NSString *)title
               message:(NSString *)message
     andConfirmMessage:(NSString *)confirm;
@end
