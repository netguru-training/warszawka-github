//
//  NGRRepoDetailsController.h
//  Gitguru
//
//  Created by Adam Garstka on 29/11/14.
//  Copyright (c) 2014 Netguru Sp. z o.o. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NGRRepo.h"

@interface NGRRepoDetailsController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) NGRRepo *repo;
@end
