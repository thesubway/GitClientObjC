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

@interface ViewController ()

@property NSData *jsonData;
@property NSDictionary *parsedJSON;
@property Repo *testRepo;

@end

@implementation ViewController
-(ViewController *)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
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
    NSMutableArray *items = [[NSMutableArray alloc] initWithArray:self.parsedJSON[@"items"]];
    //takes the first repo (0 position is first):
//    Repo *curRepo = items[0];
//    self.testRepo = [[Repo alloc] initWithTitle:items[0]];
    self.testRepo = [[Repo alloc] initWithTitle:[items objectAtIndex: 0]];
    NSLog(@"Repo's title is %@",self.testRepo.title);
    NSLog(@"Repo done");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
