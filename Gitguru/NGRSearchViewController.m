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
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;
@property NSMutableArray *repos;

@end

@implementation NGRSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerForKeyboardNotifications];
}

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
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"error" message:error.userInfo[NSLocalizedDescriptionKey] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
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

- (void)registerForKeyboardNotifications {
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillChangeFrame:)
                                                 name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWillChangeFrame:(NSNotification *)notification {
    NSValue *frame = notification.userInfo[@"UIKeyboardFrameEndUserInfoKey"];
    CGRect rect = [frame CGRectValue];
    CGFloat height = rect.size.height;
    
    self.bottomConstraint.constant = height;
}

- (void)keyboardWillHide:(NSNotification *)notification {
    self.bottomConstraint.constant = 0;
}

@end
