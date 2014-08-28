//
//  User.m
//  GitClientObjC
//
//  Created by Dan Hoang on 8/25/14.
//  Copyright (c) 2014 Dan Hoang. All rights reserved.
//

#import "User.h"

@implementation User

-(User *)initWithDict:(NSDictionary *)json {
    if (self) {
        self.login = json[@"login"];
        self.ID = (int)json[@"id"];
        self.url = json[@"url"];
        self.name = json[@"name"];
        self.avatarURL = json[@"avatar_url"];
    }
    return self;
}

@end
