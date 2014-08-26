//
//  Repo.m
//  GitClientObjC
//
//  Created by Dan Hoang on 8/25/14.
//  Copyright (c) 2014 Dan Hoang. All rights reserved.
//

#import "Repo.h"

@implementation Repo

-(Repo *)initWithTitle:(NSDictionary *)json {
    self = [super init];
    //to ensure it's a full object:
    if (self) {
        
        //configure self
//        self.items = json[@"items"];
        self.title = json[@"name"];
        self.ID = (int)json[@"id"];
        //self.owner = User(json: json["owner"] as NSDictionary)
        self.owner = [[User alloc] initWithDict:json[@"owner"]]; //json[@"owner"];
    }
    
    return self;
}

@end
