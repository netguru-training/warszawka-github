//
//  NGRUser.m
//  Gitguru
//
//  Created by Adam Garstka on 30/11/14.
//  Copyright (c) 2014 Netguru Sp. z o.o. All rights reserved.
//

#import "NGRUser.h"

@implementation NGRUser

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.name = dictionary[@"login"];
        self.email = dictionary[@"email"];
    }
    return self;
}

@end
