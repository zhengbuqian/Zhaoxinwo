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
#import "UIViewController+ShowPromptAlert.h"
#import "NSObject+TestNetwork.h"

static NSString *InfoCellReuseIdentifier = @"InfoCell";
static NSString *FooterViewIdentifier = @"FooterViewIdentifier";


@interface ZXWInfoTableViewController ()
@property (strong, nonatomic) UITableViewHeaderFooterView *footerView;
@property (strong, nonatomic) UILabel *footerViewLabel;

@property (strong, nonatomic) ZXWRetriveData *data;
@property (nonatomic, getter=isLoading) BOOL loading;
@property (nonatomic) BOOL shouldLoadData;
@property (strong, nonatomic) NSIndexPath *selectedIndexPath;
@property (copy) void (^reloadBlock)() ;

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
        UIAlertController *alert =
            [UIAlertController alertControllerWithTitle:@"点击信息标题可以跳转至该条租房信息的豆瓣贴子里"
                                                message:@"点击电话号码（如果有）可以进行拨号。长按电话号码可以复制。"
                                         preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"好，知道了"
                                                          style:UIAlertActionStyleDefault
                                                        handler:nil];
        [alert addAction:confirm];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.data.resultArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZXWInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:InfoCellReuseIdentifier
                                                            forIndexPath:indexPath];
    if (!cell) {
        cell = [[ZXWInfoCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:InfoCellReuseIdentifier];
    }
    if ([self.data.resultArray count] > 0) {
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
        if (![self connectedToNetwork]) {
            [self showAlert:@"好像没有网络连接哦"];
            return;
        }
        if (self.data.noMoreInfo) {
            [self showAlert:@"没有更多啦"];
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
    void (^blk)() = ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            self.loading = NO;
            self.footerViewLabel.text = @"上拉加载更多";
            self.tableView.userInteractionEnabled = YES;
        });
    };
    [self.data startWithBlock:blk];
}


@end
