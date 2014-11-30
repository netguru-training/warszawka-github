//
//  NGRUser.m
//  Gitguru
//
//  Created by Adam Garstka on 30/11/14.
//  Copyright (c) 2014 Netguru Sp. z o.o. All rights reserved.
//

#import "NGRUser.h"
#import <AFNetworking/AFNetworking.h>

@interface NGRUser ()
@property NSString *avatarUrl;
@property UIImage *avatar;
@end

@implementation NGRUser


- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.name = dictionary[@"login"];
        self.email = dictionary[@"email"];
        self.avatarUrl = dictionary[@"avatar_url"];
    }
    return self;
}

- (void)fetchAvatar:(void (^)(UIImage *, NSError *))block {
    if(self.avatar) {
        block(self.avatar, nil);
        return;
    }
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFImageResponseSerializer serializer];
    __weak typeof(self) weakSelf = self;
    [manager GET:self.avatarUrl parameters:nil success:^(AFHTTPRequestOperation *operation, UIImage *responseObject) {
        weakSelf.avatar = responseObject;
        block(responseObject, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil, error);
    }];
}

@end
