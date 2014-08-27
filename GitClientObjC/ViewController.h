//
//  ViewController.h
//  GitClientObjC
//
//  Created by Dan Hoang on 8/25/14.
//  Copyright (c) 2014 Dan Hoang. All rights reserved.
//

#import <UIKit/UIKit.h>

#define GITHUB_CLIENT_ID @"41a46f67b3769c6525f3"
#define GITHUB_CLIENT_SECRET @"51492c2a617dcbe0a477c9b07fb47efc22573941"
#define GITHUB_CALLBACK_URI @"oauthdemo://git_callback"
#define GITHUB_OAUTH_URL @"https://github.com/login/oauth/authorize?client_id=%@&redirect_uri=%@&scope=%@"

@interface ViewController : UIViewController


@end

