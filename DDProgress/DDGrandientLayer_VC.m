/*
 * DDProgressView https://github.com/SanLiangSan/DDProgressView
 *
 * Copyright (c) 2014 SanLiangSan
 *
 * This is a custom progressView which can layout the progress colorful
 *
 * This project is public for every one!
 *
 * If you have any question, please give me a email.
 * Author: SanLiangSan
 * Email: 254458886@qq.com
 *
 */

#import "DDGrandientLayer_VC.h"
#import "DDProgressView.h"

@interface DDGrandientLayer_VC ()

@end

@implementation DDGrandientLayer_VC {
    CAGradientLayer *layer;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        self.extendedLayoutIncludesOpaqueBars = YES;
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.navigationController.navigationBar.translucent = NO;
    }
     [[UINavigationBar appearance] setBarTintColor:[UIColor blackColor]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"首页";
    self.navigationController.view.backgroundColor = [UIColor blackColor];

    DDProgressView *progressView = [[DDProgressView alloc] initWithFrame:(CGRect){0,20,320,1} backGroundColor:[UIColor blackColor]];
    
    UIView *view = [[UIView alloc] initWithFrame:(CGRect){0,0,320,64}];
    view.backgroundColor = [UIColor blackColor];

    UINavigationController *nav = self.navigationController;
    [nav.view addSubview:progressView];
    
//    [view addSubview:progressView];
    
    [progressView setProgress:0.5 duation:2 animated:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [progressView setProgress:0.8 duation:2 animated:YES];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [progressView setProgress:1.0 duation:2 animated:YES];
    });
    //.....also you can test the colorful method
    //[progressView stopColorful];  or
    //[progressView startColorful];
    
    
    DDProgressView *progressView1 = [[DDProgressView alloc] initWithFrame:(CGRect){0,100,320,10} backGroundColor:[UIColor blackColor]];
    
    [self.view addSubview:progressView1];
    
    [progressView1 setProgress:0.5 duation:2 animated:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [progressView1 setProgress:0.8 duation:2 animated:YES];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [progressView1 setProgress:1.0 duation:2 animated:YES];
    });
    
}

@end
