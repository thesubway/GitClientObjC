//
//  AppDelegate.h
//  GitClientObjC
//
//  Created by Dan Hoang on 8/25/14.
//  Copyright (c) 2014 Dan Hoang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "NetworkController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property NSMutableArray *userRepos;

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (strong, nonatomic) NetworkController *networkController;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

