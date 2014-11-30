//
//  NGRUser.h
//  Gitguru
//
//  Created by Adam Garstka on 30/11/14.
//  Copyright (c) 2014 Netguru Sp. z o.o. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NGRUser : NSObject

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
- (void)fetchAvatar:(void (^)(UIImage *, NSError *))block;

@property NSString *name;
@property NSString *email;
@property NSMutableArray *repos;

@end