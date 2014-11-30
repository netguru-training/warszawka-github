//
//  NGRUserDetailsController.m
//  Gitguru
//
//  Created by Adam Garstka on 30/11/14.
//  Copyright (c) 2014 Netguru Sp. z o.o. All rights reserved.
//

#import "NGRUserDetailsController.h"

@interface NGRUserDetailsController ()
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;

@end

@implementation NGRUserDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.user.name;
    __weak typeof(self) weak_self = self;
    
    [self.user fetchAvatar:^(UIImage *image, NSError *error) {
        if(!error){
            weak_self.avatarImageView.image = image;
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RepoCell" forIndexPath:indexPath];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
