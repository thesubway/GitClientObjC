//
//  UserCell.m
//  GitClientObjC
//
//  Created by Dan Hoang on 8/27/14.
//  Copyright (c) 2014 Dan Hoang. All rights reserved.
//

#import "UserCell.h"

@implementation UserCell

-(instancetype)init {
    self = [super init];
    if (self) {
        self.imageView = [[UIImageView alloc] init];
    }
    return self;
}

@end
