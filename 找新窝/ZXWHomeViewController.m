//
//  ZXWHomeViewController.m
//  找新窝
//
//  Created by 卜千 郑 on 16/2/2.
//  Copyright © 2016年 卜千 郑. All rights reserved.
//

#import "ZXWHomeViewController.h"
#import "ZXWInfoTableViewController.h"
#import "ZXWAboutViewController.h"
#import "NSObject+TestNetwork.h"
#import "UIViewController+ShowPromptAlert.h"

@interface ZXWHomeViewController ()

@property (weak, nonatomic) IBOutlet UITextField *inputTextField;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (weak, nonatomic) IBOutlet UIButton *aboutButton;

@end

@implementation ZXWHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"找新窝";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (IBAction)searchButtonPressed:(id)sender {
    if (![self connectedToNetwork]) {
        [self showAlert:@"好像没有网络哦"];
        return;
    }
    
    if (self.inputTextField.text.length == 0) {
        [self showAlert:@"先输入一个地点吧"];
    } else {
        ZXWInfoTableViewController *infoVC = [[ZXWInfoTableViewController alloc]
                                              initWithSearchKeyword:self.inputTextField.text];
        infoVC.title = [NSString stringWithFormat:@"搜索结果: %@", self.inputTextField.text];
        [infoVC startRetriveData];
        [self.navigationController pushViewController:infoVC
                                             animated:YES];
    }
}
- (IBAction)touchOutside:(id)sender {
    [self.inputTextField resignFirstResponder];
}

- (IBAction)jumpToSite:(UIButton *)sender {
    [[UIApplication sharedApplication]
     openURL:[NSURL URLWithString:@"http://zhaoxinwo.com"]];
}
- (IBAction)aboutButtonPressed:(UIButton *)sender {
    ZXWAboutViewController *aboutVC = [[ZXWAboutViewController alloc] init];
    aboutVC.title = @"关于找新窝";
    [self.navigationController pushViewController:aboutVC
                                         animated:YES];
}



@end
