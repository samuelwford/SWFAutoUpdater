//
//  SWFAutoUpdater.h
//  SWFAutoUpdater
//
//  Created by Samuel Ford on 3/2/14.
//  Copyright (c) 2014 Samuel Ford. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Simple application update check for directly distributed apps (not in the AppStore).
 */
@interface SWFAutoUpdater : NSObject

/**
 URL with latest versio information.
 */
@property (nonatomic, strong) NSURL *updateURL;

/**
 Shared updater instance.
 @return shared instance
 */
+ (instancetype)sharedAutoUpdater;

- (void)checkForUpdate;

@end
