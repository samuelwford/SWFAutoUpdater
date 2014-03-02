//
//  SWFAboutVersionViewController.h
//  SWFAutoUpdater
//
//  Created by Samuel Ford on 3/2/14.
//  Copyright (c) 2014 Samuel Ford. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SWFSemanticVersion/SWFSemanticVersion.h>

@interface SWFAboutVersionViewController : UIViewController

@property (nonatomic, strong) SWFSemanticVersion *updatedVersion;
@property (nonatomic, strong) NSURL *aboutURL;

@end
