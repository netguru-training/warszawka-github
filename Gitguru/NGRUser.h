//
//  NGRUser.h
//  Gitguru
//
//  Created by Adam Garstka on 30/11/14.
//  Copyright (c) 2014 Netguru Sp. z o.o. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NGRUser : NSObject

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@property NSString *name;
@property NSString *email;

@end
