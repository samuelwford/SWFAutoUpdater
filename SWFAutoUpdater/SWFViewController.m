//
//  SWFViewController.m
//  SWFAutoUpdater
//
//  Created by Samuel Ford on 3/2/14.
//  Copyright (c) 2014 Samuel Ford. All rights reserved.
//

#import "SWFViewController.h"
#import "SWFAboutVersionViewController.h"

@interface SWFViewController ()

@end

@implementation SWFViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)presentUpdate:(id)sender
{
    SWFAboutVersionViewController *vc = [[SWFAboutVersionViewController alloc] init];
    
    vc.aboutURL = [NSURL URLWithString:@"http://samuelwford.com/gamefriends"];
    vc.updatedVersion = [SWFSemanticVersion semanticVersionWithString:@"1.2.3"];
    
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:vc];
    nc.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentViewController:nc animated:YES completion:nil];
}

@end
