//
//  CreateRepoViewController.m
//  GitClientObjC
//
//  Created by Dan Hoang on 8/28/14.
//  Copyright (c) 2014 Dan Hoang. All rights reserved.
//

#import "CreateRepoViewController.h"
#import "NetworkController.h"
#import "Repo.h"
#import "AppDelegate.h"

@interface CreateRepoViewController ()

@property (strong,nonatomic) AppDelegate *appDelegate;

@end

@implementation CreateRepoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.networkController = [[NetworkController alloc] init];
    self.networkController.delegate = self;
    self.appDelegate = [[UIApplication sharedApplication] delegate];
    self.managedObjectContext = self.appDelegate.managedObjectContext;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 0 ) {
        
        if (buttonIndex == 1 ) {
            UITextField *repoName = [alertView textFieldAtIndex:0];
            [self.networkController postReposFor:repoName.text];
        }
    }
}

- (void) didCreateRepo:(NSDictionary *)JSONDict
{
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Repo" inManagedObjectContext:self.managedObjectContext];
    Repo * repo = [[Repo alloc] initWithTitle:JSONDict];
//    [self.fetchedResultsController performFetch:nil];
//    [self.tableView reloadData];
}

- (IBAction)addRepoPressed:(id)sender {
    NSLog(@"Adding repo");
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"New Repo"
                                                     message:@"Enter the name of your new repo:"
                                                    delegate:self
                                           cancelButtonTitle:@"Cancel"
                                           otherButtonTitles:@"Create",nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    alert.tag = 0;
    [alert show];
}
@end
