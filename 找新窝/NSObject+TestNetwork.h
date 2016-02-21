//
//  NSObject+TestNetwork.h
//  找新窝
//
//  Created by 卜千 郑 on 16/2/21.
//  Copyright © 2016年 卜千 郑. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SystemConfiguration/SCNetworkReachability.h"
#import <netinet/in.h>

@interface NSObject (TestNetwork)
- (BOOL) connectedToNetwork;
@end
