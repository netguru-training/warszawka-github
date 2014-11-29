//
//  NGRRepoDetailsController.m
//  Gitguru
//
//  Created by Adam Garstka on 29/11/14.
//  Copyright (c) 2014 Netguru Sp. z o.o. All rights reserved.
//

#import "NGRRepoDetailsController.h"

@interface NGRRepoDetailsController ()
@property (weak, nonatomic) IBOutlet UITableView *propertiesTableView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (strong, nonatomic) NSDictionary *properties;
@end

@implementation NGRRepoDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = self.repo.name;
    self.title = self.repo.name;
    __weak typeof(self) weak_self = self;

    [self.repo fetchOwnerAvatar:^(UIImage *image, NSError *error) {
        if(!error){
            weak_self.avatarImageView.image = image;
        }
    }];
    
    self.properties = @{
                        @"Language": ((id)(self.repo.language) != [NSNull null]) ? self.repo.language : @"Unknown",
                        @"Stars": [ NSString stringWithFormat:@"%lu", self.repo.starsCount ],
                        @"Forks": [ NSString stringWithFormat:@"%lu", self.repo.forksCount ]
                        };
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.properties.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ParamCell" forIndexPath:indexPath];
    NSString *label = self.properties.allKeys[indexPath.row];
    NSString *detail = self.properties[label];
    cell.textLabel.text = label;
    cell.detailTextLabel.text = detail;
    return cell;
}


@end
