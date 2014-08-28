//
//  RtTblViewController.m
//  GitClientObjC
//
//  Created by Dan Hoang on 8/27/14.
//  Copyright (c) 2014 Dan Hoang. All rights reserved.
//

#import "RtTblViewController.h"
#import "UserSearchViewController.h"
#import "ViewController.h"

@interface RtTblViewController ()

@end

@implementation RtTblViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //use the ID as the string of that viewController.
    self.viewControlStrings = [[NSMutableArray alloc] init];
    self.viewControlObjects = [[NSMutableArray alloc] init];
    ViewController *vC = [self.storyboard instantiateViewControllerWithIdentifier:@"viewController"];
    UserSearchViewController *userSearchVC = [self.storyboard instantiateViewControllerWithIdentifier:@"userSearchViewController"];
    [self.viewControlStrings addObject:@"viewController"], [self.viewControlObjects addObject:vC];
    [self.viewControlStrings addObject:@"userSearchViewController"],[self.viewControlObjects addObject:userSearchVC];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    NSLog(@"%lu",(unsigned long)self.viewControlStrings.count);
    [self.tableView reloadData];
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
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.viewControlStrings.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%@",self.viewControlStrings[indexPath.row]);
    [self showDetailViewController:self.viewControlObjects[indexPath.row] sender:self];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"vcCell" forIndexPath:indexPath];
    NSString *curString = self.viewControlStrings[indexPath.row];
    // Configure the cell...
    cell.textLabel.text = curString;
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
