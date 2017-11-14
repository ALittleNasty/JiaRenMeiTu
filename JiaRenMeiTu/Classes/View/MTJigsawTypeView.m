//
//  MTJigsawTypeView.m
//  JiaRenMeiTu
//
//  Created by ALittleNasty on 2017/11/14.
//  Copyright © 2017年 ALittleNasty. All rights reserved.
//

#import "MTJigsawTypeView.h"

#define JTStrokeColor [UIColor colorWithHexString:@"#7f8784"]
#define JTFillColor   [UIColor whiteColor]
#define JTLineWidth   4.0

@implementation MTJigsawTypeView


- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    [super drawRect:rect];
    self.backgroundColor = [UIColor whiteColor];
    //1、创建画布
    CGContextRef context = UIGraphicsGetCurrentContext();
    //2、设置内容
    CGContextAddRect(context, self.bounds);
    //2.1设置画笔颜色
    [JTStrokeColor setStroke];
    [JTFillColor setFill];
    //2.2 设置画笔宽度;
    CGContextSetLineWidth(context, JTLineWidth);
    //3、渲染内容到画板
    CGContextDrawPath(context, kCGPathFillStroke);
    
    // 画分割线
    [self drawViewWithType:_type];
}

#pragma mark - Set Type


- (void)setType:(ImageJigsawType)type
{
    _type = type;
    
    [self setNeedsDisplay];
}

- (void)drawViewWithType:(ImageJigsawType)type
{
    switch (type) {
        case ImageJigsawTypeTwoVertical: {
            [self drawTypeTwoWithIsVerticalFlag:YES];
        }
            break;
        case ImageJigsawTypeTwoHorizontal: {
            [self drawTypeTwoWithIsVerticalFlag:NO];
        }
            break;
        case ImageJigsawTypeThreeVertical: {
            [self drawTypeThreeWithIsVerticalFlag:YES];
        }
            break;
        case ImageJigsawTypeThreeHorizontal: {
            [self drawTypeThreeWithIsVerticalFlag:NO];
        }
            break;
        case ImageJigsawTypeThreeTopBig: {
            [self drawTypeThreeTopBig];
        }
            break;
        case ImageJigsawTypeThreeBottomBig: {
            [self drawTypeThreeBottomBig];
        }
            break;
        case ImageJigsawTypeThreeLeftBig: {
            [self drawTypeThreeLeftBig];
        }
            break;
        case ImageJigsawTypeThreeRightBig: {
            [self drawTypeThreeRightBig];
        }
            break;
        case ImageJigsawTypeFourVertical: {
            [self drawTypeFourWithIsVerticalFlag:YES];
        }
            break;
        case ImageJigsawTypeFourHorizontal: {
            [self drawTypeFourWithIsVerticalFlag:NO];
        }
            break;
        case ImageJigsawTypeFourSquare: {
            [self drawTypeFourSquare];
        }
            break;
        default:
            break;
    }
}

#pragma mark - 两张拼图的分割线

/** 根据标记画一条 "纵向" 或者 "横向" 分割线 */
- (void)drawTypeTwoWithIsVerticalFlag:(BOOL)flag
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, JTLineWidth * 0.5);
    
    // 判断画纵向还是横向分割线
    if (flag == YES) { // 纵向
        
        CGContextMoveToPoint(context, 0.0f, self.bounds.size.height * 0.5); //start at this point
        CGContextAddLineToPoint(context, self.bounds.size.width, self.bounds.size.height * 0.5); //draw to this point
    } else {           // 横向
        
        CGContextMoveToPoint(context, self.bounds.size.width * 0.5, 0.0); //start at this point
        CGContextAddLineToPoint(context, self.bounds.size.width * 0.5, self.bounds.size.height); //draw to this point
    }
    
    // and now draw the Path!
    CGContextStrokePath(context);
}

#pragma mark - 三张拼图的分割线

/** 根据标记画两条 "纵向" 或者 "横向" 分割线 */
- (void)drawTypeThreeWithIsVerticalFlag:(BOOL)flag
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, JTLineWidth * 0.5);
    
    if (flag == YES) { // 纵向
        
        CGContextMoveToPoint(context, 0.0f, self.bounds.size.height/3);
        CGContextAddLineToPoint(context, self.bounds.size.width, self.bounds.size.height/3);
        CGContextStrokePath(context);
        
        CGContextMoveToPoint(context, 0.0f, self.bounds.size.height/3*2);
        CGContextAddLineToPoint(context, self.bounds.size.width, self.bounds.size.height/3*2);
        CGContextStrokePath(context);
        
    } else {          // 横向
        
        CGContextMoveToPoint(context, self.bounds.size.width/3, 0.0);
        CGContextAddLineToPoint(context, self.bounds.size.width/3, self.bounds.size.height);
        CGContextStrokePath(context);
        
        CGContextMoveToPoint(context, self.bounds.size.width/3*2, 0.0);
        CGContextAddLineToPoint(context, self.bounds.size.width/3*2, self.bounds.size.height);
        CGContextStrokePath(context);
    }
}

/** 下边竖直分割, 上边大图 */
- (void)drawTypeThreeTopBig
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, JTLineWidth * 0.5);
    
    // 中间的横线
    CGContextMoveToPoint(context,  0.0, self.bounds.size.height * 0.5);
    CGContextAddLineToPoint(context, self.bounds.size.width, self.bounds.size.height * 0.5);
    CGContextStrokePath(context);
    
    // 下半部分竖直分割线
    CGContextMoveToPoint(context, self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
    CGContextAddLineToPoint(context, self.bounds.size.width * 0.5, self.bounds.size.height);
    CGContextStrokePath(context);
}

/** 上边水平分割, 下边大图 */
- (void)drawTypeThreeBottomBig
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, JTLineWidth * 0.5);
    
    // 中间的横线
    CGContextMoveToPoint(context,  0.0, self.bounds.size.height * 0.5);
    CGContextAddLineToPoint(context, self.bounds.size.width, self.bounds.size.height * 0.5);
    CGContextStrokePath(context);
    
    // 上半部分竖直分割线
    CGContextMoveToPoint(context, self.bounds.size.width * 0.5, 0.0);
    CGContextAddLineToPoint(context, self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
    CGContextStrokePath(context);
}

/** 右边水平分割, 左边大图 */
- (void)drawTypeThreeLeftBig
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, JTLineWidth * 0.5);
    
    // 中间的竖直分割线
    CGContextMoveToPoint(context, self.bounds.size.width * 0.5, 0.0);
    CGContextAddLineToPoint(context, self.bounds.size.width * 0.5, self.bounds.size.height);
    CGContextStrokePath(context);
    
    // 右边水平分割线
    CGContextMoveToPoint(context,  self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
    CGContextAddLineToPoint(context, self.bounds.size.width, self.bounds.size.height * 0.5);
    CGContextStrokePath(context);
}

/** 左边水平分割, 右边大图 */
- (void)drawTypeThreeRightBig
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, JTLineWidth * 0.5);
    
    // 中间的竖直分割线
    CGContextMoveToPoint(context, self.bounds.size.width * 0.5, 0.0);
    CGContextAddLineToPoint(context, self.bounds.size.width * 0.5, self.bounds.size.height);
    CGContextStrokePath(context);
    
    // 左边水平分割线
    CGContextMoveToPoint(context, 0.0, self.bounds.size.height * 0.5);
    CGContextAddLineToPoint(context, self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
    CGContextStrokePath(context);
}

#pragma mark - 四张拼图的分割线

/** 根据标记画三条 "纵向" 或者 "横向" 分割线 */
- (void)drawTypeFourWithIsVerticalFlag:(BOOL)flag
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, JTLineWidth * 0.5);
    
    if (flag == YES) { // 纵向
        
        CGContextMoveToPoint(context, 0.0f, self.bounds.size.height * 0.25);
        CGContextAddLineToPoint(context, self.bounds.size.width, self.bounds.size.height * 0.25);
        CGContextStrokePath(context);
        
        CGContextMoveToPoint(context, 0.0f, self.bounds.size.height * 0.5);
        CGContextAddLineToPoint(context, self.bounds.size.width, self.bounds.size.height * 0.5);
        CGContextStrokePath(context);
        
        CGContextMoveToPoint(context, 0.0f, self.bounds.size.height * 0.75);
        CGContextAddLineToPoint(context, self.bounds.size.width, self.bounds.size.height * 0.75);
        CGContextStrokePath(context);
        
    } else {        // 横向
        
        CGContextMoveToPoint(context, self.bounds.size.width * 0.25, 0.0);
        CGContextAddLineToPoint(context, self.bounds.size.width * 0.25, self.bounds.size.height);
        CGContextStrokePath(context);
        
        CGContextMoveToPoint(context, self.bounds.size.width * 0.5, 0.0);
        CGContextAddLineToPoint(context, self.bounds.size.width * 0.5, self.bounds.size.height);
        CGContextStrokePath(context);
        
        CGContextMoveToPoint(context, self.bounds.size.width * 0.75, 0.0);
        CGContextAddLineToPoint(context, self.bounds.size.width * 0.75, self.bounds.size.height);
        CGContextStrokePath(context);
    }
}

/** "十" 字分割线 */
- (void)drawTypeFourSquare
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, JTLineWidth * 0.5);
    
    // 横线
    CGContextMoveToPoint(context, 0.0f, self.bounds.size.height * 0.5);
    CGContextAddLineToPoint(context, self.bounds.size.width, self.bounds.size.height * 0.5);
    CGContextStrokePath(context);
    
    // 竖线
    CGContextMoveToPoint(context, self.bounds.size.width * 0.5, 0.0);
    CGContextAddLineToPoint(context, self.bounds.size.width * 0.5, self.bounds.size.height);
    CGContextStrokePath(context);
}

@end
