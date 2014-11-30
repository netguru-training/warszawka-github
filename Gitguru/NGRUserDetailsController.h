//
//  NGRUserDetailsController.h
//  Gitguru
//
//  Created by Adam Garstka on 30/11/14.
//  Copyright (c) 2014 Netguru Sp. z o.o. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NGRUser.h"

@interface NGRUserDetailsController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NGRUser *user;

@end
