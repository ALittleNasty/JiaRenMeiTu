//
//  MTHomeViewController.m
//  JiaRenMeiTu
//
//  Created by ALittleNasty on 2017/11/9.
//  Copyright © 2017年 ALittleNasty. All rights reserved.
//

#import "MTHomeViewController.h"

#import "MTHomeCollectionCell.h"

#import <Masonry/Masonry.h>
#import "UIColor+HEX.h"

@interface MTHomeViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

/** backgroundImage */
@property (nonatomic, strong) UIImageView *backgroundImageView;

/** collectionView */
@property (nonatomic, strong) UICollectionView *collectionView;

/** colors */
@property (nonatomic, strong) NSArray *colors;

/** titles */
@property (nonatomic, strong) NSArray *titles;

@end

@implementation MTHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addBlurImageView];
    [self addCollectionView];
}

#pragma mark - UI Confifure

/** 添加高斯模糊背景图片 */
- (void)addBlurImageView
{
    UIImage * image = [UIImage imageNamed:@"bg_01.jpg"];
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.image = image;
    [self.view addSubview:imageView];
    UIBlurEffect * blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    //创建模糊view
    UIVisualEffectView * effectView = [[UIVisualEffectView alloc] initWithEffect:blur];
    effectView.frame = imageView.frame;
    [imageView addSubview:effectView];
    
    UIImage *logo = [UIImage imageNamed:@"camera_watermark"];
    UIImageView *logoImage = [[UIImageView alloc] init];
    logoImage.image = logo;
    [imageView addSubview:logoImage];
    [logoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(imageView.mas_centerX);
        make.top.equalTo(imageView.mas_top).offset(20);
        make.size.mas_offset(logo.size);
    }];
}

/** 添加CollectionView */
- (void)addCollectionView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumLineSpacing = 10.0;
    layout.minimumInteritemSpacing = 10.0;
    layout.sectionInset = UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0);
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    layout.itemSize = CGSizeMake((screenWidth - 30.0)*0.5, (screenWidth - 30.0)*0.5);
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_collectionView];
    [_collectionView registerNib:[MTHomeCollectionCell nib] forCellWithReuseIdentifier:HomeCollectionCellID];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.centerY.equalTo(self.view);
        make.height.equalTo(@(screenWidth));
    }];
}

#pragma mark - UICollectionViewDelegate & UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 4;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MTHomeCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:HomeCollectionCellID forIndexPath:indexPath];
    
    cell.descLabel.text = self.titles[indexPath.item];
    cell.contentView.backgroundColor = self.colors[indexPath.item];
    
    return cell;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%s", __func__);
}

#pragma mark - Lazy Load

- (NSArray *)colors
{
    if (!_colors) {
        
        _colors = @[[UIColor mt_blueColor], [UIColor mt_yellowColor], [UIColor mt_greenColor], [UIColor mt_purpleColor]];
    }
    
    return _colors;
}

- (NSArray *)titles
{
    if (!_titles) {
        
        _titles = @[@"美化图片", @"人像美容", @"美拍", @"拼图"];
    }
    
    return _titles;
}

@end
