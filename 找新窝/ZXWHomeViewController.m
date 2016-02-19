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
#import "SystemConfiguration/SCNetworkReachability.h"
#import <netinet/in.h>

@interface ZXWHomeViewController ()
@property (weak, nonatomic) IBOutlet UITextField *inputTextField;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (weak, nonatomic) IBOutlet UIButton *aboutButton;


@end

@implementation ZXWHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"找新窝";
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)searchButtonPressed:(id)sender {
    
    //NSLog(@"%@", self.inputTextField.text);
    //NSLog(@" ");
    if (![self connectedToNetwork]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"无法连接网络"
                                                                       message:nil
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"好的:)"
                                                          style:UIAlertActionStyleCancel
                                                        handler:nil];
        [alert addAction:confirm];
        [self presentViewController:alert
                           animated:YES
                         completion:nil];
        return;
    }
    
    
    if (self.inputTextField.text.length == 0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"你需要输入一个地点"
                                                                       message:nil
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"好的:)"
                                                          style:UIAlertActionStyleCancel
                                                        handler:nil];
        [alert addAction:confirm];
        [self presentViewController:alert
                           animated:YES
                         completion:nil];
    } else {
        
        
        
        ZXWInfoTableViewController *infoVC = [[ZXWInfoTableViewController alloc]
                                              initWithSearchKeyword:self.inputTextField.text];
        infoVC.title = [NSString stringWithFormat:@"搜索结果: %@", self.inputTextField.text];
        //infoVC.searchKeyWord = self.inputTextField.text;
        [infoVC startRetriveData];
        [self.navigationController pushViewController:infoVC
                                             animated:YES];
    }
}
- (IBAction)touchOutside:(id)sender {
    [self.inputTextField resignFirstResponder];
}






/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)jumpToSite:(UIButton *)sender {
    [[UIApplication sharedApplication]
     openURL:[NSURL URLWithString:@"http://zhaoxinwo.com"]];
}
- (IBAction)aboutButtonPressed:(UIButton *)sender {
    ZXWAboutViewController *aboutVC = [[ZXWAboutViewController alloc] init];
    aboutVC.title = @"关于找新窝";
    [self.navigationController pushViewController:aboutVC
                                         animated:YES];
    //[self presentViewController:aboutVC
    //                  animated:YES
    //                 completion:nil];
}

- (BOOL) connectedToNetwork
{
    //创建零地址，0.0.0.0的地址表示查询本机的网络连接状态
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    //获得连接的标志
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    //如果不能获取连接标志，则不能连接网络，直接返回
    if (!didRetrieveFlags)
    {
        return NO;
    }
    //根据获得的连接标志进行判断
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    return (isReachable && !needsConnection) ? YES : NO;
}

@end
