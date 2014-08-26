//
//  NetworkController.h
//  GitClientObjC
//
//  Created by Dan Hoang on 8/25/14.
//  Copyright (c) 2014 Dan Hoang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkController : NSObject

-(NSMutableArray *)parseSuccessfulRepoResponse:(NSData *)responseData;

@property NSString *apiDomain;
@property NSMutableArray *repos;

@end
