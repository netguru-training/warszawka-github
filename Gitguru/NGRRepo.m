//
//  NGRRepo.m
//  Gitguru
//
//  Created by Adam Garstka on 29/11/14.
//  Copyright (c) 2014 Netguru Sp. z o.o. All rights reserved.
//

#import "NGRRepo.h"
#import <AFNetworking/AFNetworking.h>
@interface NGRRepo ()
@property NSString *ownerAvatarUrl;
@property UIImage *ownerAvatar;
@end

@implementation NGRRepo

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.name = dictionary[@"name"];
        self.owner = dictionary[@"owner"][@"login"];
        self.language = dictionary[@"language"];
        self.htmlURL = dictionary[@"html_url"];
        self.ownerAvatarUrl = dictionary[@"owner"][@"avatar_url"];
    }
    return self;
}

- (void)fetchOwnerAvatar:(void (^)(UIImage *, NSError *))block {
    if(self.ownerAvatar) {
        block(self.ownerAvatar, nil);
        return;
    }

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFImageResponseSerializer serializer];
    __weak typeof(self) weakSelf = self;
    [manager GET:self.ownerAvatarUrl parameters:nil success:^(AFHTTPRequestOperation *operation, UIImage *responseObject) {
        weakSelf.ownerAvatar = responseObject;
        block(responseObject, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil, error);
    }];
}

@end
