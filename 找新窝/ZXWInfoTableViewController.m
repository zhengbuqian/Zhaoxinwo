//
//  ZXWInfoTableViewController.m
//  找新窝
//
//  Created by 卜千 郑 on 16/2/2.
//  Copyright © 2016年 卜千 郑. All rights reserved.
//

#import "ZXWInfoTableViewController.h"
#import "ZXWInfoCell.h"
static NSString *InfoCellReuseIdentifier = @"InfoCell";
static NSString *FooterViewIdentifier = @"FooterViewIdentifier";

@interface ZXWInfoTableViewController ()
@property (strong, nonatomic) UITableViewHeaderFooterView *footerView;
@end

@implementation ZXWInfoTableViewController

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.pageNumber = 1;
        
        
        
        
        
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.estimatedRowHeight = 200;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.footerView = [[UITableViewHeaderFooterView alloc]
                       initWithReuseIdentifier:FooterViewIdentifier];
    CGRect footerViewLabelRect = CGRectMake(84, 10, 150, 15);
    UILabel *footerViewLabel = [[UILabel alloc] initWithFrame:footerViewLabelRect];
    footerViewLabel.text = @"上拉加载更多";
    footerViewLabel.textAlignment = NSTextAlignmentCenter;
    [self.footerView.contentView addSubview:footerViewLabel];
    self.tableView.tableFooterView = self.footerView;
    
    UINib *nib = [UINib nibWithNibName:@"ZXWInfoCell" bundle:nil];
    [self.tableView registerNib:nib
         forCellReuseIdentifier:InfoCellReuseIdentifier];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZXWInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:InfoCellReuseIdentifier
                                                            forIndexPath:indexPath];
    if (!cell) {
        cell = [[ZXWInfoCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:InfoCellReuseIdentifier];
        
        
        
        
        
        
    }
    //cell.textLabel.text = [NSString stringWithFormat:@"%d", indexPath.row];
    // Configure the cell...
    
    return cell;
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

@end
