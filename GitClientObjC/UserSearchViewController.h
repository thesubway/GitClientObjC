//
//  UserSearchViewController.h
//  GitClientObjC
//
//  Created by Dan Hoang on 8/27/14.
//  Copyright (c) 2014 Dan Hoang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserSearchViewController : UIViewController

@property NSMutableArray *users;
- (IBAction)reloadPressed:(id)sender;

@end
