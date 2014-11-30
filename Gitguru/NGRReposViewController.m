//
//  NGRReposViewController.m
//  Gitguru
//
//  Created by Adam Garstka on 29/11/14.
//  Copyright (c) 2014 Netguru Sp. z o.o. All rights reserved.
//

#import "NGRReposViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "NGRRepo.h"
#import "NGRRepoDetailsController.h"

@interface NGRReposViewController ()

@end

@implementation NGRReposViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.repos count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RepoCell" forIndexPath:indexPath];
    NGRRepo *repo = self.repos[indexPath.row];
    cell.textLabel.text = repo.name;
    cell.detailTextLabel.text = repo.owner;
    
    return cell;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"showRepoDetails"]) {
        UITableViewCell *cell = sender;
        NSInteger cellIndex = [[self.tableView indexPathForCell:cell] row];
        NGRRepoDetailsController *repoViewController = segue.destinationViewController;
        repoViewController.repo = self.repos[cellIndex];
    }
}

@end
