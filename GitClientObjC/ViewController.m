//
//  ViewController.m
//  GitClientObjC
//
//  Created by Dan Hoang on 8/25/14.
//  Copyright (c) 2014 Dan Hoang. All rights reserved.
//

#import "ViewController.h"
#import "Repo.h"
#import "User.h"
#import "NetworkController.h"
#import "AppDelegate.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property NSData *jsonData;
@property NSDictionary *parsedJSON;
@property Repo *testRepo;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) AppDelegate *appDelegate;

@end

@implementation ViewController


-(ViewController *)init {
    self = [super init];
    if (self) {
    }
    return self;
}
- (IBAction)reloadPressed:(id)sender {
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.appDelegate = [[UIApplication sharedApplication] delegate];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"loaded");

    // each message on separate line
//    NSBundle *bundle = [NSBundle mainBundle];
//    NSString *jsonPath = [bundle pathForResource:@"SampleRepo" ofType:@"json"];
//    NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
//    self.jsonData = jsonData;
    
    // all on one line
    self.jsonData = [NSData dataWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"SampleRepo" ofType:@"json"]];
//    parsedJSON = NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
    
    id parsedJSON = [NSJSONSerialization JSONObjectWithData:self.jsonData options:NSJSONReadingMutableContainers error:nil];
    if ([parsedJSON isKindOfClass:[NSDictionary class]]) {
        self.parsedJSON = [NSJSONSerialization JSONObjectWithData:self.jsonData options:NSJSONReadingMutableContainers error:nil];
    }
    else {
        NSLog(@"PersonalError: Not a dictionary.");
    }
//    var repo = Repo(json: parsedJSON3)
//    self.testRepo = (Repo*)self.parsedJSON;
    //retrieves the array of all repos:
//    NSMutableArray *items = [[NSMutableArray alloc] initWithArray:self.parsedJSON[@"items"]];
    //takes the first repo (0 position is first):
//    Repo *curRepo = items[0];
//    self.testRepo = [[Repo alloc] initWithTitle:items[0]];
//    self.testRepo = [[Repo alloc] initWithTitle:[items objectAtIndex: 0]];
//    NSLog(@"Repo's title is %@",self.testRepo.title);
    NSLog(@"Repo done");
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSString *urlString = [NSString stringWithFormat:GITHUB_OAUTH_URL,GITHUB_CLIENT_ID,GITHUB_CALLBACK_URI,@"user,repo"];
    NSLog(@"%@",urlString);
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
    //this results in: https://github.com/thesubway
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Repo *curRepo = [self.appDelegate.userRepos objectAtIndex:indexPath.row];
    NSLog(@"%@",curRepo.title);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    self.appDelegate = [[AppDelegate alloc ] init];
    NSLog(@"self.userRepos count is: %lu",(unsigned long)[self.appDelegate.userRepos count]);
    return [self.appDelegate.userRepos count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mainViewCell" forIndexPath: indexPath];
//    self.appDelegate = [[AppDelegate alloc ] init];
    Repo *curRepo = [self.appDelegate.userRepos objectAtIndex:indexPath.row];
    cell.textLabel.text = curRepo.title;
    return cell;
}

@end
