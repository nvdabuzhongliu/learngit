//
//  JYMonsterCell.m
//  Label
//
//  Created by 吴冬 on 16/10/10.
//  Copyright © 2016年 北京金源互动科技有限公司. All rights reserved.
//

#import "JYMonsterCell.h"

@implementation JYMonsterCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    _Pic.layer.borderWidth = 4.f;
    _Pic.layer.borderColor = [UIColor colorWithRed:0.659 green:0.663 blue:0.651 alpha:1.000].CGColor;
    _Pic.layer.masksToBounds = YES;
    _Pic.layer.cornerRadius = 8.0;
    
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 5.0;
}

@end
