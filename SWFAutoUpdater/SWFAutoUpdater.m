//
//  SWFAutoUpdater.m
//  SWFAutoUpdater
//
//  Created by Samuel Ford on 3/2/14.
//  Copyright (c) 2014 Samuel Ford. All rights reserved.
//

#import "SWFAutoUpdater.h"
#import <SWFSemanticVersion/SWFSemanticVersion.h>

@interface SWFSemanticVersion (SWFAutoUpdater)

+ (instancetype)swfau_appVersion;

- (BOOL)swfau_isLessThan:(SWFSemanticVersion *)version;

@end

@implementation SWFSemanticVersion (SWFAutoUpdater)

+ (instancetype)swfau_appVersion
{
    NSString *appVersionString = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"CFBundleVersion"];
    return [SWFSemanticVersion semanticVersionWithString:appVersionString];
}

- (BOOL)swfau_isLessThan:(SWFSemanticVersion *)version
{
    return [self compare:version] == NSOrderedAscending;
}

@end

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
                NSString *latestVersionString = [json valueForKeyPath:@"latest.version"];
                NSString *downloadURLString = [json valueForKeyPath:@"latest.url"];
                NSString *aboutURLString = [json valueForKeyPath:@"latest.about"];
                
                NSURL *downloadURL = [NSURL URLWithString:downloadURLString];
                NSURL *aboutURL = [NSURL URLWithString:aboutURLString];
                
                SWFSemanticVersion *latestVersion = [SWFSemanticVersion semanticVersionWithString:latestVersionString];
                
                if ([[SWFSemanticVersion swfau_appVersion] swfau_isLessThan:latestVersion]) {
                    [self presentUpdateWithDownloadURL:downloadURL aboutURL:aboutURL];
                }
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

- (void)presentUpdateWithDownloadURL:(NSURL *)downloadURL aboutURL:(NSURL *)aboutURL
{
    
}

@end
