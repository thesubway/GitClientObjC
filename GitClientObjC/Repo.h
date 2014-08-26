//
//  Repo.h
//  GitClientObjC
//
//  Created by Dan Hoang on 8/25/14.
//  Copyright (c) 2014 Dan Hoang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Repo : NSObject

@property NSString *title;
@property NSDictionary *items;
@property int ID;
@property User *owner;

-(Repo *)initWithTitle:(NSDictionary *)json;

@end
