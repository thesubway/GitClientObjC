//
//  NetworkController.h
//  GitClientObjC
//
//  Created by Dan Hoang on 8/25/14.
//  Copyright (c) 2014 Dan Hoang. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NetworkControllerDelegate <NSObject>

//- (void) didAuthenticate;
- (void) didCreateRepo: (NSDictionary *) JSONDict;

@end

@interface NetworkController : NSObject

-(NSMutableArray *)parseSuccessfulRepoResponse:(NSData *)responseData;
-(NSMutableArray *)parseSuccessfulUserResponse:(NSData *)responseData;

-(void)handleCallBackURL:(NSURL *)url;

@property NSString *apiDomain;
@property NSMutableArray *repos;
@property NSMutableArray *users;
//for the delegate:
@property (unsafe_unretained) id <NetworkControllerDelegate> delegate;
-(void) fetchUsersForSearchTerm:(NSString*)userString completionHandler: (void (^)(NSMutableArray*, NSString*))completionHandler;
-(void) postReposFor:(NSString*)userString;

@end
