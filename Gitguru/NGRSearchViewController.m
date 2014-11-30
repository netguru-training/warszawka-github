//
//  NGRSearchViewController.m
//  Gitguru
//
//  Created by Adam Garstka on 30/11/14.
//  Copyright (c) 2014 Netguru Sp. z o.o. All rights reserved.
//

#import "NGRSearchViewController.h"
#import "NGRReposViewController.h"
#import "NGRRepo.h"
#import <AFNetworking/AFNetworking.h>

@interface NGRSearchViewController ()

@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property NSMutableArray *repos;

@end

@implementation NGRSearchViewController

- (void)buildRequest {
    NSDictionary *params = @{ @"q" : self.searchTextField.text };
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"https://api.github.com/search/repositories" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        NSArray *items = responseObject[@"items"];
        self.repos = [[NSMutableArray alloc] initWithCapacity:items.count];
        for (NSDictionary *dictionary in items) {
            NGRRepo *repo = [[NGRRepo alloc] initWithDictionary:dictionary];
            [self.repos addObject:repo];
        }
        [self performSegueWithIdentifier:@"showRepoSearchResults" sender:self.searchTextField];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self buildRequest];
    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UIViewController *destinationController = [segue destinationViewController];
    if([segue.identifier isEqualToString:@"showRepoSearchResults"]) {
        NGRReposViewController *reposController = (NGRReposViewController *)destinationController;
        reposController.repos = self.repos;
    }
}



@end
