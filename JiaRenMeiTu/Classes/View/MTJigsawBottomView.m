//
//  MTJigsawBottomView.m
//  JiaRenMeiTu
//
//  Created by ALittleNasty on 2017/11/13.
//  Copyright © 2017年 ALittleNasty. All rights reserved.
//

#import "MTJigsawBottomView.h"
#import "MTJigsawTypeView.h"


#pragma mark - ************************************* Define Cell Start *************************************

@interface MTJigsawBottomCell : UICollectionViewCell

/** 类型 */
@property (nonatomic, assign) ImageJigsawType type;

@end

@implementation MTJigsawBottomCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)setType:(ImageJigsawType)type
{
    MTJigsawTypeView *typeView = [[MTJigsawTypeView alloc] initWithFrame:CGRectInset(self.bounds, 5.0, 5.0)];
    typeView.type = type;
    [self.contentView addSubview:typeView];
}

@end


#pragma mark - ************************************* Define Cell End *************************************

static NSString *cellID = @"MTJigsawBottomCellIdentifier";

@interface MTJigsawBottomView()<UICollectionViewDelegate, UICollectionViewDataSource>

/** 边框按钮 */
@property (nonatomic, strong) UIButton *boxButton;

/** 横向列表 */
@property (nonatomic, strong) UICollectionView *collectionView;

/** 提示文案 */
@property (nonatomic, strong) UILabel *alertLabel;

/** 数量 */
@property (nonatomic, assign) NSInteger count;

/** 类型 */
@property (nonatomic, copy) NSArray *types;

@end

@implementation MTJigsawBottomView

- (instancetype)initWithFrame:(CGRect)frame withCount:(NSInteger)count
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _count = count;
        [self typesForCount:_count];
        [self initSubviews];
    }
    return self;
}

/** 显示的类型 */
- (void)typesForCount:(NSInteger)count
{
    if (count == 2) {
        _types = @[@(ImageJigsawTypeTwoVertical), @(ImageJigsawTypeTwoHorizontal)];
    } else if (count == 3) {
        _types = @[@(ImageJigsawTypeThreeVertical), @(ImageJigsawTypeThreeHorizontal), @(ImageJigsawTypeThreeTopBig),
                   @(ImageJigsawTypeThreeBottomBig), @(ImageJigsawTypeThreeLeftBig), @(ImageJigsawTypeThreeRightBig)];
    } else if (count == 4) {
        _types = @[@(ImageJigsawTypeFourVertical), @(ImageJigsawTypeFourHorizontal), @(ImageJigsawTypeFourSquare)];
    }
}

#pragma mark - UI Configure

- (void)initSubviews
{
    self.backgroundColor = [UIColor whiteColor];
    
    _boxButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_boxButton setTitle:@"无边框" forState:UIControlStateNormal];
    [_boxButton setTitle:@"有边框" forState:UIControlStateSelected];
    [_boxButton setSelected:NO];
    [_boxButton setBackgroundColor:[UIColor colorWithHexString:@"#42a7f4"]];
    [_boxButton addTarget:self action:@selector(boxButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    _boxButton.layer.cornerRadius = 5.0;
    [self addSubview:_boxButton];
    [_boxButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(10.0);
        make.top.equalTo(self.mas_top).offset(20.0);
        make.size.mas_equalTo(CGSizeMake(80, 40));
    }];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor colorWithHexString:@"#f48342"];
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_boxButton.mas_right).offset(7);
        make.top.equalTo(self.mas_top).offset(20.0);
        make.size.mas_equalTo(CGSizeMake(1, 40));
    }];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(60.0, 60.0);
    layout.minimumLineSpacing = 10.0;
    layout.minimumInteritemSpacing = 10.0;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_collectionView];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.right.equalTo(self.mas_right);
        make.left.equalTo(_boxButton.mas_right).offset(10);
        make.height.equalTo(@80);
    }];
    
    [_collectionView registerClass:[MTJigsawBottomCell class] forCellWithReuseIdentifier:cellID];
    
    _alertLabel = [[UILabel alloc] init];
    _alertLabel.text = @"请选择拼图的样式~";
    _alertLabel.textAlignment = NSTextAlignmentCenter;
    _alertLabel.textColor = [UIColor colorWithHexString:@"#ff6666"];
    _alertLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:_alertLabel];
    [_alertLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.equalTo(@20);
    }];
}

#pragma mark - Action

- (void)boxButtonAction:(UIButton *)btn
{
    
}

#pragma mark - UICollectionViewDelegate & UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _types.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MTJigsawBottomCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    
    cell.type = (ImageJigsawType)[_types[indexPath.item] integerValue];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
