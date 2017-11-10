//
//  MTHomeCollectionCell.m
//  JiaRenMeiTu
//
//  Created by ALittleNasty on 2017/11/10.
//  Copyright © 2017年 ALittleNasty. All rights reserved.
//

#import "MTHomeCollectionCell.h"

NSString *HomeCollectionCellID = @"HomeCollectionCellIdentifier";

@implementation MTHomeCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.contentView.layer.cornerRadius = 5.0;
}

+ (UINib *)nib
{
    return [UINib nibWithNibName:@"MTHomeCollectionCell" bundle:nil];
}

@end
