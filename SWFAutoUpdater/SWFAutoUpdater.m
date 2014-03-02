//
//  SWFAutoUpdater.m
//  SWFAutoUpdater
//
//  Created by Samuel Ford on 3/2/14.
//  Copyright (c) 2014 Samuel Ford. All rights reserved.
//

#import "SWFAutoUpdater.h"

@implementation SWFAutoUpdater

+ (instancetype)sharedAutoUpdater
{
    static SWFAutoUpdater *_updater = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _updater = [[SWFAutoUpdater alloc] init];
    });
    
    return _updater;
}

- (void)checkForUpdate
{
    if (self.updateURL) {
        [self downloadLatestVersionInfoFromURL:self.updateURL completionHandler:^(NSDictionary *json) {
            if (json) {
                
            }
        }];
    }
}

- (void)downloadLatestVersionInfoFromURL:(NSURL *)url completionHandler:(void (^)(NSDictionary *json))handler
{
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration ephemeralSessionConfiguration]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSDictionary *json = nil;
        if (data) {
            NSError *error;
            json = [NSJSONSerialization
                              JSONObjectWithData:data options:0 error:&error];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            handler(json);
        });
    }];
    
    [task resume];
}

@end
