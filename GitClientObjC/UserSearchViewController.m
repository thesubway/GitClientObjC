//
//  UserSearchViewController.m
//  GitClientObjC
//
//  Created by Dan Hoang on 8/27/14.
//  Copyright (c) 2014 Dan Hoang. All rights reserved.
//

#import "UserSearchViewController.h"
#import "NetworkController.h"
#import "UserCell.h"
#import "User.h"

@interface UserSearchViewController () <UISearchBarDelegate, UICollectionViewDataSource,UICollectionViewDelegate>

@property NSString *searchUrl;
@property (strong, nonatomic) NetworkController *networkController;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation UserSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.networkController = [[NetworkController alloc] init];
    self.searchUrl = @"https://api.github.com/search/users?q=tom";
    self.searchBar.delegate = self;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.users = [[NSMutableArray alloc] init];
    //cell id is: @"searchedUserCell"
    // Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [self.networkController fetchUsersForSearchTerm:searchText completionHandler:^(NSMutableArray *users, NSString *errorDescription) {
        if (errorDescription != nil) {
            //alert of error.
            NSLog(@"error: %@",errorDescription);
        }
        else {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                self.users = users;
                NSLog(@"%lu",(unsigned long)users.count);
                [self.collectionView reloadData];
            }];
        }
    }];
}

-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSLog(@"%lu",(unsigned long)self.users.count);
    return self.users.count;
}
-(void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"%ld",(long)indexPath.item);
    User *currentUser = self.users[indexPath.item];
    NSLog(@"%@",currentUser.avatarURL);
    NSLog(@"hi.");
}
-(UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UserCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"searchedUserCell" forIndexPath:indexPath];
    User *curUser = self.users[indexPath.item];
    NSURL *curURL = [[NSURL alloc] initWithString: curUser.avatarURL];
    NSOperationQueue *myQueue = [[NSOperationQueue alloc] init];
    myQueue.maxConcurrentOperationCount = 1;
    [myQueue addOperationWithBlock:^{
        NSData *data = [[NSData alloc] initWithContentsOfURL:curURL];
        [NSOperationQueue.mainQueue addOperationWithBlock:^{
            UIImage *myImage = [[UIImage alloc] initWithData:data];
            cell.imageView.image = myImage;
        }];
    }];
    
    cell.imageView.layer.borderColor = [[UIColor greenColor] CGColor];
    cell.imageView.layer.borderWidth = 1;
    return cell;
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)reloadPressed:(id)sender {
    [self.collectionView reloadData];
}
@end
