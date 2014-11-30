//
//  NGRSearchViewController.m
//  Gitguru
//
//  Created by Adam Garstka on 30/11/14.
//  Copyright (c) 2014 Netguru Sp. z o.o. All rights reserved.
//

#import "NGRSearchViewController.h"
#import "NGRReposViewController.h"
#import "NGRUsersViewController.h"
#import "NGRRepo.h"
#import "NGRUser.h"
#import <AFNetworking/AFNetworking.h>

@interface NGRSearchViewController ()

@property (weak, nonatomic) IBOutlet UITextField *reposSearchTextField;
@property (weak, nonatomic) IBOutlet UITextField *usersSearchTextField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;
@property NSMutableArray *items;

@end

@implementation NGRSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerForKeyboardNotifications];
}

- (void)executeSearchRequestWithPath:(NSString *)path query:(NSString *)query modelClass:(Class)aClass segueIdentifier: (NSString *)segueIdentifier {
    NSDictionary *params = @{ @"q": query };
    NSString *url = [ NSString stringWithFormat:@"https://api.github.com/search/%@", path ];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:url parameters:params success:^
    (AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        NSArray *items = responseObject[@"items"];
        self.items = [[NSMutableArray alloc] initWithCapacity:items.count];
        for (NSDictionary *dictionary in items) {
            id item = [[aClass alloc] initWithDictionary:dictionary];
            [self.items addObject:item];
        }
        [self performSegueWithIdentifier:segueIdentifier sender:self];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"error" message:error.userInfo[NSLocalizedDescriptionKey] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }];

}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    Class aClass = Nil;
    NSString *path = @"";
    NSString *segueIdentifier = @"";
    
    if (textField == self.reposSearchTextField) {
        aClass = [NGRRepo class];
        path = @"repositories";
        segueIdentifier = @"showRepoSearchResults";
    }
    else {
        aClass = [NGRUser class];
        path = @"users";
        segueIdentifier = @"showUserSearchResults";
    }
    [self executeSearchRequestWithPath:path query: textField.text modelClass:aClass segueIdentifier:segueIdentifier];

    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UIViewController *destinationController = [segue destinationViewController];
    if([segue.identifier isEqualToString:@"showRepoSearchResults"]) {
        NGRReposViewController *reposController = (NGRReposViewController *)destinationController;
        reposController.repos = self.items;
    }
    else if ([segue.identifier isEqualToString:@"showUserSearchResults"]) {
        NGRUsersViewController *usersController = (NGRUsersViewController*)destinationController;
        usersController.users = self.items;
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
