//
//  ZXWInfoTableViewController.m
//  找新窝
//
//  Created by 卜千 郑 on 16/2/2.
//  Copyright © 2016年 卜千 郑. All rights reserved.
//

#import "ZXWInfoTableViewController.h"
#import "ZXWInfoCell.h"
#import "ZXWRetriveData.h"
#import "SystemConfiguration/SCNetworkReachability.h"
#import <netinet/in.h>

static NSString *InfoCellReuseIdentifier = @"InfoCell";
static NSString *FooterViewIdentifier = @"FooterViewIdentifier";

@interface ZXWInfoTableViewController ()
@property (strong, nonatomic) UITableViewHeaderFooterView *footerView;
@property (strong, nonatomic) UILabel *footerViewLabel;

@property (strong, nonatomic) ZXWRetriveData *data;
@property (nonatomic, getter=isLoading) BOOL loading;
@property (nonatomic) BOOL shouldLoadData;
@property (strong, nonatomic) NSIndexPath *selectedIndexPath;

@end

@implementation ZXWInfoTableViewController

- (instancetype)initWithSearchKeyword:(NSString *)searchKeyWord {
    self = [super init];
    
    if (self) {
        self.data = [[ZXWRetriveData alloc] init];
        self.pageNumber = 1;
        self.searchKeyWord = searchKeyWord;
        self.loading = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.estimatedRowHeight = 250;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    
    // 自定义一个footerView来加载更多
    
    
    self.footerView = [[UITableViewHeaderFooterView alloc]
                       initWithReuseIdentifier:FooterViewIdentifier];
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    CGFloat centerX = screenBounds.size.width / 2;
    CGFloat footerViewLabelWidth = 150;
    CGRect footerViewLabelRect = CGRectMake(centerX - footerViewLabelWidth / 2, 10, footerViewLabelWidth, 15);
    self.footerViewLabel = [[UILabel alloc] initWithFrame:footerViewLabelRect];
    
    self.footerViewLabel.text = @"正在加载中";
    self.footerViewLabel.textAlignment = NSTextAlignmentCenter;
    [self.footerView.contentView addSubview:self.footerViewLabel];

    self.tableView.tableFooterView = self.footerView;
    self.tableView.userInteractionEnabled = NO;
    
    UINib *nib = [UINib nibWithNibName:@"ZXWInfoCell" bundle:nil];
    [self.tableView registerNib:nib
         forCellReuseIdentifier:InfoCellReuseIdentifier];
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]) {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstLaunch"];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"点击信息标题可以跳转至该条租房信息的豆瓣贴子里"
                                                                       message:@"点击电话号码（如果有）可以进行拨号。长按电话号码可以复制。"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"好，知道了"
                                                          style:UIAlertActionStyleDefault
                                                        handler:nil];
        [alert addAction:confirm];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    unsigned long number = [self.data.resultArray count];
    //NSLog(@"numberOfRowsInSection: %d", number);
    return number;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZXWInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:InfoCellReuseIdentifier
                                                            forIndexPath:indexPath];
    //NSLog(@"cellForRowAtIndexPath");
    if (!cell) {
        cell = [[ZXWInfoCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:InfoCellReuseIdentifier];
              // row starts at 0
    }
    if ([self.data.resultArray count] > 0) {
        //NSLog(@"here %d", indexPath.row);
        cell.cellData = self.data.resultArray[indexPath.row];
    }
    if ([self.data.userHeadPortraitArray count] > indexPath.row) {
        cell.userHeadPortrait = self.data.userHeadPortraitArray[indexPath.row];
    }
    return cell;
}

- (NSIndexPath *)tableView:(UITableView *)tableView
      willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}
/*
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if ( scrollView.contentOffset.y + scrollView.frame.size.height - scrollView.contentSize.height > 100
        && !self.isLoading && [self.data.resultArray count] > 3) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"网络无连接"
                                                                       message:nil
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"好的:)"
                                                          style:UIAlertActionStyleDefault
                                                        handler:nil];
        [alert addAction:confirm];
        if (![self connectedToNetwork]) {
            [self presentViewController:alert animated:YES completion:nil];
            return;
        }
        if (self.data.noMoreInfo) {
            alert.title = @"没有更多了";
            [self presentViewController:alert animated:YES completion:nil];
            return;
        }
        
        self.loading = YES;
        self.footerViewLabel.text = @"正在加载中...";
        [self startRetriveData];
    }
}*/
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if ( scrollView.contentOffset.y + scrollView.frame.size.height - scrollView.contentSize.height > 100
        && !self.isLoading && [self.data.resultArray count] > 3) {
        self.footerViewLabel.text = @"松开即可刷新";
        self.shouldLoadData = YES;
    } else if ([self.data.resultArray count] > 3){
        self.footerViewLabel.text = @"上拉加载更多";
        self.shouldLoadData = NO;
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView
                  willDecelerate:(BOOL)decelerate {
    if (self.shouldLoadData) {
        
        self.footerViewLabel.text = @"正在加载中...";
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"网络无连接"
                                                                       message:nil
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"好的:)"
                                                          style:UIAlertActionStyleDefault
                                                        handler:nil];
        [alert addAction:confirm];
        if (![self connectedToNetwork]) {
            [self presentViewController:alert animated:YES completion:nil];
            return;
        }
        if (self.data.noMoreInfo) {
            alert.title = @"没有更多了";
            [self presentViewController:alert animated:YES completion:nil];
            return;
        }
        
        self.loading = YES;
        [self startRetriveData];
        self.shouldLoadData = NO;
    }
}

- (void)setPageNumber:(int)pageNumber {
    _pageNumber = pageNumber;
    self.data.pageNumber = _pageNumber;
}
- (void)setSearchKeyWord:(NSString *)searchKeyWord {
    _searchKeyWord = [searchKeyWord copy];
    self.data.searchKeyword = _searchKeyWord;
}



- (void)startRetriveData {
    int count = 0;
    //NSLog(@"startRetriveData %d", count);
    count++;
    void (^blk)() = ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            NSLog(@"Did reload data");
            // 使用footerView加载更多
            self.loading = NO;
            self.footerViewLabel.text = @"上拉加载更多";
            self.tableView.userInteractionEnabled = YES;

        });
    };
    
    [self.data startWithBlock:blk];

}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
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
