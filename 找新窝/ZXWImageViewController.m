//
//  ZXWImageViewController.m
//  找新窝
//
//  Created by 卜千 郑 on 16/2/21.
//  Copyright © 2016年 卜千 郑. All rights reserved.
//

#import "ZXWImageViewController.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "UIViewController+ShowPromptAlert.h"

@interface ZXWImageViewController ()
@property (strong, nonatomic) NSArray *imageAdressArray;
@property (strong, nonatomic) NSMutableArray *imageViewArray;
@property int imageIndex;
@end

@implementation ZXWImageViewController

- (instancetype)initWithAdreddArray:(NSArray *)adressArray {
    self = [super init];
    if (self) {
        self.imageAdressArray = adressArray;
        self.imageViewArray = [[NSMutableArray alloc] init];
        [self attachSwipeHandler];
        self.imageIndex = 0;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat navBarHeight = self.navigationController.navigationBar.frame.size.height;
    CGFloat statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    CGRect screenRect = [UIScreen mainScreen].bounds;
    screenRect.size.height -= (navBarHeight + statusBarHeight);
    screenRect.origin.y += (navBarHeight + statusBarHeight);
    NSString *ipAdress = @"http://182.92.159.73";
    for (NSArray *imageAdress in self.imageAdressArray) {
        NSString *imageActualAdress = [ipAdress stringByAppendingString:[imageAdress objectAtIndex:0]];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:screenRect];
        [imageView sd_setImageWithURL:[NSURL URLWithString:imageActualAdress]
                     placeholderImage:[UIImage imageNamed:@"找不到"]];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.imageViewArray addObject:imageView];
    }
    [self.view addSubview:[self.imageViewArray objectAtIndex:self.imageIndex]];
    self.title = [NSString stringWithFormat:@"%d/%d", self.imageIndex + 1, [self.imageViewArray count]];
}
- (void)attachSwipeHandler {
    self.view.userInteractionEnabled = YES;
    UISwipeGestureRecognizer *swipeGRToRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                  action:@selector(swipeToLastImage)];
    [swipeGRToRight setDirection:UISwipeGestureRecognizerDirectionRight];   // 向右滑，上一张
    UISwipeGestureRecognizer *swipeGRToLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                        action:@selector(swipeToNextImage)];
    [swipeGRToLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.view addGestureRecognizer:swipeGRToRight];
    [self.view addGestureRecognizer:swipeGRToLeft];
}
- (void)swipeToLastImage {
    if (self.imageIndex == 0) {
        [self showAlert:@"这已经是第一张啦"];
        return;
    }
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionPush;
    [self.view.layer addAnimation:transition forKey:nil];
    [[self.imageViewArray objectAtIndex:self.imageIndex] removeFromSuperview];
    self.imageIndex -= 1;
    [self.view addSubview:self.imageViewArray[self.imageIndex]];
    self.title = [NSString stringWithFormat:@"%d/%d", self.imageIndex + 1, [self.imageViewArray count]];
}
- (void)swipeToNextImage {
    if (self.imageIndex == [self.imageAdressArray count] - 1) {
        [self showAlert:@"这已经是最后一张啦"];
        return;
    }
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromRight;
    [self.view.layer addAnimation:transition forKey:nil];
    [[self.imageViewArray objectAtIndex:self.imageIndex] removeFromSuperview];
    self.imageIndex += 1;
    [self.view addSubview:self.imageViewArray[self.imageIndex]];
    self.title = [NSString stringWithFormat:@"%d/%d", self.imageIndex + 1, [self.imageViewArray count]];
}



/*
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    CGFloat navBarHeight = self.navigationController.navigationBar.frame.size.height;
    CGFloat statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    //self.navigationController.navigationBar.backgroundColor = [UIColor blueColor];
    CGRect screenRect = [self.navigationController.view frame];
    screenRect.size.height -= (navBarHeight + statusBarHeight);
    screenRect.origin.y += (navBarHeight + statusBarHeight);
    
    CGRect scrollViewRect = screenRect;
    scrollViewRect.origin = CGPointMake(0, 0);
    scrollViewRect.size.height -= (navBarHeight + statusBarHeight);
    scrollViewRect.size.width *= [self.imageAdressArray count];
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:screenRect];
    [scrollView setPagingEnabled:YES];
    
    CGRect imageViewRect = screenRect;
    imageViewRect.origin = CGPointMake(0, 0);
    imageViewRect.origin.y -= (navBarHeight + statusBarHeight);
    NSString *ipAdress = @"http://182.92.159.73";
    for (NSArray *imageAdress in self.imageAdressArray) {
        NSString *imageActualAdress = [ipAdress stringByAppendingString:[imageAdress objectAtIndex:0]];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:imageViewRect];
        imageViewRect.origin.x += imageViewRect.size.width;
        [imageView sd_setImageWithURL:[NSURL URLWithString:imageActualAdress] placeholderImage:[UIImage imageNamed:@"找不到"]];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [scrollView addSubview:imageView];
    }
    scrollView.contentSize = scrollViewRect.size;
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    self.title = [NSString stringWithFormat:@"1/%d", [self.imageAdressArray count]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
*/
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*//*
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    int page = (scrollView.contentOffset.x / scrollView.bounds.size.width) + 1;
    self.title = [NSString stringWithFormat:@"%d/%d", page, [self.imageAdressArray count]];
}*/


@end
