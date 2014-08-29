//
//  NetworkController.m
//  GitClientObjC
//
//  Created by Dan Hoang on 8/25/14.
//  Copyright (c) 2014 Dan Hoang. All rights reserved.
//

#import "NetworkController.h"
#import "Repo.h"
#import "ViewController.h"
#import "AppDelegate.h"
#import "CreateRepoViewController.h"

@interface NetworkController ()

@property (strong,nonatomic) NSURLSession *session;
@property NSURLSessionConfiguration *configuration;

@property (strong,nonatomic) NSString *token;
@property (strong,nonatomic) AppDelegate *appDelegate;

@end

@implementation NetworkController

-(instancetype)init {
    self = [super init];
    if (self) {
        self.apiDomain = @"https://developer.github.com/v3/";
        //
        self.session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        self.appDelegate = [[UIApplication sharedApplication] delegate];
        self.configuration = [NSURLSessionConfiguration ephemeralSessionConfiguration];
        self.users = [[NSMutableArray alloc] init];
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
    return self.repos;
}

-(NSMutableArray *)parseSuccessfulUserResponse:(NSData *)responseData {
    NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:nil];
    NSMutableArray *items = responseDict[@"items"];
    NSLog(@"%lu", (unsigned long)items.count);
    
    for (id eachItem in items) {
        NSDictionary *itemDict = eachItem;
        User *user = [[User alloc] initWithDict:itemDict];
        [self.users addObject:user];
    }
    NSLog(@"%lu",(unsigned long)self.users.count);
    return self.users;
}

-(void)handleCallBackURL:(NSURL *)url {
    NSLog(@"The url is: %@",url);
    //the query string is past the question mark '?'
    NSString *query = url.query;
    //split everytime "code=" shows up. If never, then one whole string.
    NSArray *components = [query componentsSeparatedByString:@"code="];
    //our temp code.
    NSString *code = components.lastObject;
    
    //setting up our parameters for our POST,
    NSString *postString = [NSString stringWithFormat:@"client_id=%@&client_secret=%@&code=%@",GITHUB_CLIENT_ID,GITHUB_CLIENT_SECRET,code];
    //convert the parameters from postString, into data for sending
    NSData *data = [postString dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[data length]];
    //creating our request for our data task
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    //set a bunch properties on our request
    [request setURL:[NSURL URLWithString:@"https://github.com/login/oauth/access_token"]];
    [request setHTTPMethod:@"POST"];
    //we need the length of the data we are posting
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    //tell it the type of data
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:data];
    
    NSURLSessionDataTask *postDataTask = [self.session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        //log error
        if (error) {
            NSLog(@"error: %@",error.localizedDescription);
        } else {
            NSLog(@" %@", response);
            self.token = [self convertDataToToken:data];
            NSLog(@"%@",self.token);
            NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
            
            //once we set this field, all calls made with this session are authenticated
            [configuration setHTTPAdditionalHeaders:@{@"Authorization": [NSString stringWithFormat:@"token %@",self.token]}];
            
            self.session = [NSURLSession sessionWithConfiguration:configuration];
            
            [self fetchUsersRepos];
        }
        
    }];
    [postDataTask resume];
}

//request token, authentication token:
-(NSString *)convertDataToToken:(NSData *)data {
    
    //parsing the data we got back, turning it into a string first
    NSString *response = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    //cutting it in half at the &
    NSArray *tokenComponents = [response componentsSeparatedByString:@"&"];
    NSString *tokenWithCode = tokenComponents[0];
    //cutting it in half again at the =
    NSArray *tokenArray = [tokenWithCode componentsSeparatedByString:@"="];
    return tokenArray.lastObject;
    
}
//for creating repo.
-(void) postReposFor:(NSString*)userString {
    NSDictionary * post = @{@"name":userString};
    //NSLog(@"%@",post);
    NSData * JSONData = [NSJSONSerialization dataWithJSONObject:post options:kNilOptions error:nil];
    NSString * postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[JSONData length]];
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc] init];
    
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@user/repos",@"https://api.github.com/"]]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:[NSString stringWithFormat:@"token %@",self.token] forHTTPHeaderField:@"Authorization"];
    [request setValue:@"text/plain" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:JSONData];
    
    NSURLResponse * response;
    NSError * error;
    NSData * responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSLog(@"error: %@",error);
    
    [self.delegate didCreateRepo:[NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:nil]];
}
//(returnType (^)(parameterTypes))blockName
-(void) fetchUsersForSearchTerm:(NSString*)userString completionHandler: (void (^)(NSMutableArray* users, NSString* errorDescription))completionHandler {
    NSURL *url = [[NSURL alloc] initWithString:[ NSString stringWithFormat: @"https://api.github.com/search/users?q=%@",userString]];
    NSURLSession *urlSession = [NSURLSession sessionWithConfiguration:self.configuration];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"GET";
    NSURLSessionDataTask *repoDataTask = [urlSession dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (error != nil) {
            NSLog(@"error");
        }
        else {
            //normally this is an if-let, but oh well.
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            switch (httpResponse.statusCode) {
                case 200: {
                    NSLog(@"Life is great!");
//                    NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:nil error:nil];
                    NSMutableArray *users = [self parseSuccessfulUserResponse:data];
//                    NSLog(@"%@",data);
                    completionHandler(users,nil);
                    break;
                }
                case 404:
                    NSLog(@"error 404: not found");
                    break;
                default:
                    NSLog(@"error %ld",(long)httpResponse.statusCode);
                    break;
            }
        }
    }];
    [repoDataTask resume];
}

-(void)fetchUsersRepos {
    NSLog(@"fetchUserRepos");
    NSURL *repoURL = [[NSURL alloc] initWithString:@"https://api.github.com/user/repos"];
    [[self.session dataTaskWithURL:repoURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (error) {
            NSLog(@"%@",error.localizedDescription);
        } else {
            NSLog(@"%@",response);
        }
        NSArray *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        //create the json dictionary of each repo. use a for-each:
        for (int i = 0; i < JSON.count; i++ ) {
            NSDictionary *sampleDicti = [JSON objectAtIndex:i];
            Repo *newRepo = [[Repo alloc] initWithTitle:sampleDicti];
            NSLog(@"JSON name: %@", sampleDicti[@"name"]);
//            NSString *repoName = sampleDicti[@"name"];
            //retrieve the name of repo, and add repo to tableView.
            [self.appDelegate.userRepos addObject:newRepo];
            NSLog(@"Size of appDelegate: %d", [self.appDelegate.userRepos count]);
        }
    }] resume];
}

@end
