//
//  NetworkController.m
//  GitClientObjC
//
//  Created by Dan Hoang on 8/25/14.
//  Copyright (c) 2014 Dan Hoang. All rights reserved.
//

#import "NetworkController.h"
#import "Repo.h"

@implementation NetworkController

-(NetworkController *)init {
    self = [super init];
    if (self) {
        self.apiDomain = @"https://developer.github.com/v3/";
    }
    
    return self;
}

-(NSMutableArray *)parseSuccessfulRepoResponse:(NSData *)responseData {
    //use the response data:
    //let responseDict = NSJSONSerialization.JSONObjectWithData(responseData, options: nil, error: nil) as? NSDictionary
    NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:nil];
    NSMutableArray *items = responseDict[@"items"];
    
    for (id eachItem in items) {
        NSDictionary *itemDict = eachItem;
        Repo *repo = [[Repo alloc] initWithTitle: itemDict];
        [self.repos insertObject:repo atIndex: items.count];
    }
    //return NSMutableArray of repo's.
    return items;
}

@end
