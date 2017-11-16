//
//  MTJigsawBoxView.m
//  JiaRenMeiTu
//
//  Created by ALittleNasty on 2017/11/14.
//  Copyright © 2017年 ALittleNasty. All rights reserved.
//

#import "MTJigsawBoxView.h"
#import "VIPhotoView.h"

static CGFloat JBorderPadding = 5.f;

@interface MTJigsawBoxView ()

/** 图片 */
@property (nonatomic, copy) NSArray *images;

/** 拼图样式 */
@property (nonatomic, assign) ImageJigsawType type;

@end

@implementation MTJigsawBoxView

- (instancetype)initWithFrame:(CGRect)frame WithImages:(NSArray *)images jigsawType:(ImageJigsawType)type
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _images = images;
        _type = type;
        
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews
{
    UIImage *img = _images.firstObject;
    
    VIPhotoView *photoView = [[VIPhotoView alloc] initWithFrame:self.bounds andImage:img];
    [self addSubview:photoView]; 
}

@end
