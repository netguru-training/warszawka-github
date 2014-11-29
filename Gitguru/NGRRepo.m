//
//  NGRRepo.m
//  Gitguru
//
//  Created by Adam Garstka on 29/11/14.
//  Copyright (c) 2014 Netguru Sp. z o.o. All rights reserved.
//

#import "NGRRepo.h"

@implementation NGRRepo

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.name = dictionary[@"name"];
        self.owner = dictionary[@"owner"][@"login"];
    }
    return self;
}

@end
