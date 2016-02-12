//
//  ZXWRetrivedData.m
//  找新窝
//
//  Created by 卜千 郑 on 16/2/2.
//  Copyright © 2016年 卜千 郑. All rights reserved.
//

#import "ZXWRetriveData.h"

@interface ZXWRetriveData ()



@end


@implementation ZXWRetriveData

- (instancetype)init {
//WithSearchKeyWord:(NSString *)searchKeyWord
//                        andPageNumber:(int)pageNumber {
    self = [super init];
    if (self) {
        self.resultArray = [[NSMutableArray alloc] initWithCapacity:200];
        //self.searchKeyword = searchKeyWord;
        //self.pageNumber = pageNumber;
    }
    return self;
}
- (void)startWithBlock:(void (^)())block {
    NSString *urlString = [NSString stringWithFormat:@"http://182.92.159.73/apis/search/%@/%d/", self.searchKeyword, self.pageNumber];
    NSCharacterSet *set = [NSCharacterSet URLQueryAllowedCharacterSet];
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:set];
    //NSLog(@"start outside");
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    NSURLSessionDataTask *dataTask =
    [[NSURLSession sharedSession]
     dataTaskWithRequest:req
     completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
         NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
         //NSLog(@"%@", dataDic);
         NSArray *result = dataDic[@"result"];
         for (id obj in result) {
             id objCopy = [obj copy];
             [self.resultArray addObject:objCopy];
         }
         NSLog(@"pageNumber: %d", self.pageNumber);
         block();
         /*dispatch_async(dispatch_get_main_queue(),^{
             
             [self.tableView reloadData];
         });*/
     }];
    [dataTask resume];
    self.pageNumber++;
}

@end
