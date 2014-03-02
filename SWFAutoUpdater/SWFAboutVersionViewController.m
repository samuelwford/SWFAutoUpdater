//
//  SWFAboutVersionViewController.m
//  SWFAutoUpdater
//
//  Created by Samuel Ford on 3/2/14.
//  Copyright (c) 2014 Samuel Ford. All rights reserved.
//

#import "SWFAboutVersionViewController.h"

@interface SWFAboutVersionViewController ()

@end

@implementation SWFAboutVersionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.title = @"Update Available";
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    UIImage *appIconImage = [self appIconImage];
    
	UIWebView *aboutPageWebView = [[UIWebView alloc] init];
    
    UIImageView *appIconImageView = [[UIImageView alloc] initWithImage:appIconImage];
    appIconImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    UILabel *appNameLabel = [[UILabel alloc] init];
    appNameLabel.text = [self appName];
    
    UILabel *appVersionLabel = [[UILabel alloc] init];
    appVersionLabel.text = @"1.0"; // [self appVersion];
    
    UILabel *updatedVersionLabel = [[UILabel alloc] init];
    updatedVersionLabel.text = @"1.1"; //[self.updatedVersion description];
    
    UIButton *downloadButton = [[UIButton alloc] init];
    [downloadButton setTitle:@"Install" forState:UIControlStateNormal];
    [downloadButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [downloadButton addTarget:self action:@selector(download:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *remindButton = [[UIButton alloc] init];
    [remindButton setTitle:@"Later" forState:UIControlStateNormal];
    [remindButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [remindButton addTarget:self action:@selector(remind:) forControlEvents:UIControlEventTouchUpInside];

    UIButton *skipButton = [[UIButton alloc] init];
    [skipButton setTitle:@"Skip" forState:UIControlStateNormal];
    [skipButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [skipButton addTarget:self action:@selector(skip:) forControlEvents:UIControlEventTouchUpInside];
    
    // this seems unnecessary, but ...
    
    appIconImageView.translatesAutoresizingMaskIntoConstraints = NO;
    appNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    appVersionLabel.translatesAutoresizingMaskIntoConstraints = NO;
    updatedVersionLabel.translatesAutoresizingMaskIntoConstraints = NO;
    aboutPageWebView.translatesAutoresizingMaskIntoConstraints = NO;
    downloadButton.translatesAutoresizingMaskIntoConstraints = NO;
    remindButton.translatesAutoresizingMaskIntoConstraints = NO;
    skipButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    // add them into their container
    
    [self.view addSubview:appIconImageView];
    [self.view addSubview:appNameLabel];
    [self.view addSubview:appVersionLabel];
    [self.view addSubview:updatedVersionLabel];
    [self.view addSubview:aboutPageWebView];
    [self.view addSubview:downloadButton];
    [self.view addSubview:remindButton];
    [self.view addSubview:skipButton];
    
    // constraint time!
    
    NSDictionary *views =
        @{
        @"app_icon_imageview": appIconImageView,
        @"app_name_label": appNameLabel,
        @"app_version_label": appVersionLabel,
        @"updated_version_label": updatedVersionLabel,
        @"about_page_webview": aboutPageWebView,
        @"download_button": downloadButton,
        @"remind_button": remindButton,
        @"skip_button": skipButton
        };
    
    NSArray *rules =
        @[
          @"V:|-(5)-[app_icon_imageview]",
          @[@"|-(5)-[app_icon_imageview]-[app_name_label]", @(NSLayoutFormatAlignAllTop)],
          @[@"[app_name_label(==app_version_label)]", @(NSLayoutFormatAlignAllLeft)],
          @[@"[app_name_label(==updated_version_label)]", @(NSLayoutFormatAlignAllLeft)],
          @"V:|-(5)-[app_name_label]-[app_version_label]-[updated_version_label]-[download_button][about_page_webview]|",
          @[@"|[skip_button(==remind_button)][remind_button(==download_button)][download_button]|", @(NSLayoutFormatAlignAllBaseline)],
          @"|[about_page_webview]|"
        ];
    
    [rules enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *rule = nil;
        NSLayoutFormatOptions options = 0;
        
        if ([obj isKindOfClass:[NSString class]]) {
            rule = obj;
        }
        
        if ([obj isKindOfClass:[NSArray class]]) {
            rule = obj[0];
            options = [obj[1] integerValue];
        }
        
        NSLog(@"Adding Constraint Rule: %@", rule);
        NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:rule
                                                                       options:options
                                                                       metrics:nil
                                                                         views:views];
        [self.view addConstraints:constraints];
    }];
    
    // show the about page
    
    NSURLRequest *request = [NSURLRequest requestWithURL:self.aboutURL];
    [aboutPageWebView loadRequest:request];
}

- (UIImage *)appIconImage
{
    return [UIImage imageNamed:@"60pt - iPhone"];
}

- (NSString *)appName
{
    return [[[NSBundle mainBundle] infoDictionary] valueForKey:@"CFBundleDisplayName"];
}

- (NSString *)appVersion
{
    return [[[NSBundle mainBundle] infoDictionary] valueForKey:@"CFBundleVersion"];
}

- (void)download:(id)sender
{
    
}

- (void)remind:(id)sender
{
    
}

- (void)skip:(id)sender
{
    
}

@end
