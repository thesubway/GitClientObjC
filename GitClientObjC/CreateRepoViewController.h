//
//  CreateRepoViewController.h
//  GitClientObjC
//
//  Created by Dan Hoang on 8/28/14.
//  Copyright (c) 2014 Dan Hoang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetworkController.h"

@interface CreateRepoViewController : UIViewController <NetworkControllerDelegate>
- (IBAction)addRepoPressed:(id)sender;
@property NetworkController *networkController;
@property (strong, nonatomic) NSManagedObjectContext * managedObjectContext;

@end
