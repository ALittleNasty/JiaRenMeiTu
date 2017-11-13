//
//  MTChoosePreview.m
//  JiaRenMeiTu
//
//  Created by ALittleNasty on 2017/11/13.
//  Copyright © 2017年 ALittleNasty. All rights reserved.
//

#import "MTChoosePreview.h"
#import <Masonry/Masonry.h>
#import "UIColor+HEX.h"

@interface MTChoosePreview()

/** 标题 */
@property (nonatomic, strong) UILabel *titleLabel;

/** 拼图按钮 */
@property (nonatomic, strong) UIButton *jigsawButton;

/** 图片控件数组 */
@property (nonatomic, strong) NSMutableArray *imageViews;

@end

@implementation MTChoosePreview

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews
{
    self.backgroundColor = [UIColor whiteColor];
    self.imageViews = [NSMutableArray array];
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    
    CGFloat imgWidth = (screenWidth - 30.0) * 0.25;
    
    // 创建标题提示文本
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont systemFontOfSize:14];
    _titleLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    _titleLabel.text = @"请选择2~4张图片";
    [self addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(5);
        make.left.equalTo(self.mas_left).offset(10);
        make.height.equalTo(@40);
    }];
    
    // 创建拼图按钮
    _jigsawButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _jigsawButton.layer.cornerRadius = 5.0;
    _jigsawButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [_jigsawButton setBackgroundColor:[UIColor colorWithHexString:@"#f2f2f2"]];
    [_jigsawButton setTitle:@"开视拼图" forState:UIControlStateNormal];
    [_jigsawButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_jigsawButton addTarget:self action:@selector(jigsawButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_jigsawButton];
    [_jigsawButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(5);
        make.height.equalTo(@40);
        make.right.equalTo(self.mas_right).offset(-10);
        make.width.equalTo(@80);
    }];
    
    // 循环创建imageView
    for (NSInteger i = 0; i < 4; i++) {
        
        UIImageView *imgView = [[UIImageView alloc] init];
        imgView.frame = CGRectMake((10.0 + imgWidth) * i, 50.0, imgWidth, imgWidth);
        imgView.backgroundColor = [UIColor whiteColor];
        imgView.clipsToBounds = YES;
        imgView.contentMode = UIViewContentModeScaleAspectFill;
        imgView.tag = i;
        [self addSubview:imgView];
        [self.imageViews addObject:imgView];
    }
}

#pragma mark - Action

- (void)jigsawButtonAction
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(startJigsawButtonClickWithImages:)]) {
        [self.delegate startJigsawButtonClickWithImages:_images];
    }
}

#pragma mark - Setter

- (void)setImages:(NSArray *)images
{
    _images = images;
    
    // 先清空所有图片
    [self.imageViews enumerateObjectsUsingBlock:^(UIImageView *  _Nonnull imageView, NSUInteger idx, BOOL * _Nonnull stop) {
        imageView.image = nil;
    }];
    
    // 如果没有图片按钮不可点击
    if (_images.count == 0) {
        [_jigsawButton setBackgroundColor:[UIColor colorWithHexString:@"#f2f2f2"]];
        return;
    }
    
    // 图片个数大于0, 按钮可以点击
    [_jigsawButton setBackgroundColor:[UIColor mt_blueColor]];
    
    // 显示图片
    for (NSInteger i = 0; i < _images.count; i++) {
        UIImage *img = _images[i];
        UIImageView *imgView = self.imageViews[i];
        imgView.image = img;
    }
}

@end
