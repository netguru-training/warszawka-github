//
//  NGRRepoDetailsController.m
//  Gitguru
//
//  Created by Adam Garstka on 29/11/14.
//  Copyright (c) 2014 Netguru Sp. z o.o. All rights reserved.
//

#import "NGRRepoDetailsController.h"

@interface NGRRepoDetailsController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
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
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ParamCell" forIndexPath:indexPath];
    return cell;
}


@end
