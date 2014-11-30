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
@property (weak, nonatomic) IBOutlet UISearchBar *itemsSearchBar;
@property NSArray *itemSearchResults;

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

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    
    NSPredicate *resultPredicate = [NSPredicate
                                    predicateWithFormat:@"name CONTAINS[cd] %@", searchText];
    
    self.itemSearchResults = [self.items filteredArrayUsingPredicate:resultPredicate];

}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller
shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    
    return YES;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [self.itemSearchResults count];
    } else {
        return [self.items count];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"RepoCell" forIndexPath:indexPath];
//    NGRRepo *repo = self.items[indexPath.row];
//    cell.textLabel.text = repo.name;
//    cell.detailTextLabel.text = repo.owner;
//    
//    return cell;
    
    NGRRepo *repo = nil;
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        repo = self.itemSearchResults[indexPath.row];
        cell.textLabel.text = repo.name;
        cell.detailTextLabel.text = repo.owner;
    } else {
        repo = self.items[indexPath.row];
        cell.textLabel.text = repo.name;
        cell.detailTextLabel.text = repo.owner;
    }
    
    return cell;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"showRepoDetails"]) {
        UITableViewCell *cell = sender;
        
        NGRRepoDetailsController *repoViewController = segue.destinationViewController;
        
        if ([self.tableView indexPathForCell:cell] != nil) {
            NSInteger cellIndex = [[self.tableView indexPathForCell:cell] row];
            repoViewController.repo = self.items[cellIndex];
        } else {
            NSInteger cellIndex = [[self.searchDisplayController.searchResultsTableView indexPathForCell:cell] row];
            repoViewController.repo = self.itemSearchResults[cellIndex];
        }
    }
}

@end
