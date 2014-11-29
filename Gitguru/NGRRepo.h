//
//  NGRRepo.h
//  Gitguru
//
//  Created by Adam Garstka on 29/11/14.
//  Copyright (c) 2014 Netguru Sp. z o.o. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NGRRepo : NSObject

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@property NSString *owner;
@property NSURL *htmlURL;
@property NSString *name;

@end
