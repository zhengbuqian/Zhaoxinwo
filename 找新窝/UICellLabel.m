//
//  UICopyLabel.m
//  找新窝
//
//  Created by 卜千 郑 on 16/2/16.
//  Copyright © 2016年 卜千 郑. All rights reserved.
//

#import "UICellLabel.h"

@implementation UICellLabel

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    return (action == @selector(copy:));
}

-(void)copy:(id)sender {
    UIPasteboard *pboard = [UIPasteboard generalPasteboard];
    pboard.string = self.text;
}


- (void)attachTapHandler {
    self.userInteractionEnabled = YES;
    UILongPressGestureRecognizer *longPressGR =
        [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                      action:@selector(longPress:)];
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                            action:@selector(tap:)];
    [self addGestureRecognizer:longPressGR];
    [self addGestureRecognizer:tapGR];
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self attachTapHandler];
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    [self attachTapHandler];
}
- (void)longPress:(UIGestureRecognizer *)gr {
    [self becomeFirstResponder];
    //UIMenuItem *copyLink = [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(copy:)];
    //[[UIMenuController sharedMenuController] setMenuItems:[NSArray arrayWithObjects: nil]];
    [[UIMenuController sharedMenuController] setTargetRect:self.frame inView:self.superview];
    [[UIMenuController sharedMenuController] setMenuVisible:YES animated: YES];
    //NSLog(@"longPress");
}
- (void)tap:(UIGestureRecognizer *)gr {
    [self becomeFirstResponder];
    //NSLog(@"tap");
    NSString *telString = @"tel://";
    NSString *urlString = [telString stringByAppendingString:self.text];
    //NSLog(@"%@", urlString);
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
}

@end
