//
//  MTJigsawViewController.m
//  JiaRenMeiTu
//
//  Created by ALittleNasty on 2017/11/10.
//  Copyright © 2017年 ALittleNasty. All rights reserved.
//

#import "MTJigsawViewController.h"
#import "MTJigsawBottomView.h"

@interface MTJigsawViewController ()<JigsawBottomViewDelegate>

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
    [self setNavigationItem];
}

#pragma mark - UI Configure

- (void)setNavigationItem
{
    UIBarButtonItem *saveItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveItemAction)];
    self.navigationItem.rightBarButtonItem = saveItem;
}

- (void)initBottomView
{
    _bottomView = [[MTJigsawBottomView alloc] initWithFrame:self.view.bounds withCount:_images.count];
    _bottomView.delegate = self;
    [self.view addSubview:_bottomView];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(@100);
    }];
}

#pragma mark - JigsawBottomViewDelegate

- (void)jigsawTypeChanged:(ImageJigsawType)type
{
    DLog(@"%zd", type);
}

- (void)changeJigsawBorderStyle:(BOOL)hasBorder
{
    DLog(@"%@", hasBorder ? @"无边框" : @"有边框");
}

#pragma mark - Action

- (void)saveItemAction
{
    
}

@end
