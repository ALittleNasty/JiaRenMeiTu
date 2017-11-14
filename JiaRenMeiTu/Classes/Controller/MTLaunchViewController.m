//
//  MTLaunchViewController.m
//  JiaRenMeiTu
//
//  Created by ALittleNasty on 2017/11/9.
//  Copyright © 2017年 ALittleNasty. All rights reserved.

// controller
#import "MTLaunchViewController.h" // 启动页
#import "MTHomeViewController.h"   // 主页

// appDelegate
#import "AppDelegate.h"



@interface MTLaunchViewController ()

/** 广告图 */
@property (nonatomic, strong) UIImageView  *adImageView;

@end

@implementation MTLaunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    _adImageView = [[UIImageView alloc] init];
    _adImageView.image = [UIImage imageNamed:@"bg_02.jpg"];
    [self.view addSubview:_adImageView];
    [_adImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self switchRootViewControllerAnimated];
    });
}

#pragma mark - 动画切换根视图

- (void)switchRootViewControllerAnimated
{
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        
        self.adImageView.alpha = 0.4;
    } completion:^(BOOL finished) {
        if (finished) {
            
            MTHomeViewController *homeVC = [[MTHomeViewController alloc] init];
            UINavigationController *naviVC = [[UINavigationController alloc] initWithRootViewController:homeVC];
            AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            [delegate.window setRootViewController:naviVC];
        }
    }];
}

@end
