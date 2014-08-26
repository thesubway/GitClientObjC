//
//  User.h
//  GitClientObjC
//
//  Created by Dan Hoang on 8/25/14.
//  Copyright (c) 2014 Dan Hoang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

-(User *)initWithDict:(NSDictionary *)json;
@property NSString *login;
@property int ID;
@property NSString *url;

@end
