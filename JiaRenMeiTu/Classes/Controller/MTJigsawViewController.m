//
//  MTJigsawViewController.m
//  JiaRenMeiTu
//
//  Created by ALittleNasty on 2017/11/10.
//  Copyright © 2017年 ALittleNasty. All rights reserved.
//

#import "MTJigsawViewController.h"
#import "MTJigsawBottomView.h"

@interface MTJigsawViewController ()

/** 底部工具视图 */
@property (nonatomic, strong) MTJigsawBottomView *bottomView;

@end

@implementation MTJigsawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.navigationItem.title = @"拼图";
    
    [self initBottomView];
}

- (void)initBottomView
{
    _bottomView = [[MTJigsawBottomView alloc] initWithFrame:self.view.bounds withCount:_images.count];
    [self.view addSubview:_bottomView];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(@100);
    }];
}

@end
