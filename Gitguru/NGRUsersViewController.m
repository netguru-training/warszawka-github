//
//  NGRUsersViewController.m
//  Gitguru
//
//  Created by Adam Garstka on 30/11/14.
//  Copyright (c) 2014 Netguru Sp. z o.o. All rights reserved.
//

#import "NGRUsersViewController.h"
#import "NGRUserDetailsController.h"
#import "NGRUser.h"

@interface NGRUsersViewController ()

@end

@implementation NGRUsersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.users count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserCell" forIndexPath:indexPath];
    NGRUser *user = self.users[indexPath.row];
    cell.textLabel.text = user.name;
    
    cell.detailTextLabel.text = user.email;
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"showUserDetails"]) {
        UITableViewCell *cell = sender;
        NSInteger cellIndex = [[self.tableView indexPathForCell:cell] row];
        NGRUserDetailsController *userDetailsController = segue.destinationViewController;
        userDetailsController.user = self.users[cellIndex];
    }
}

@end
