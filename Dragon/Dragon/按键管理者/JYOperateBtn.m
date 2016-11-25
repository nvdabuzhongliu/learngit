//
//  JYOperateBtn.m
//  ddd
//
//  Created by 吴冬 on 16/8/19.
//  Copyright © 2016年 北京金源互动科技有限公司. All rights reserved.
//

#import "JYOperateBtn.h"

@implementation JYOperateBtn

- (void)moveAction:(NSTimer *)timer
{
    NSInteger operateType = [timer.userInfo integerValue];
    
    CGFloat x = 0;
    CGFloat y = 0;
    
    switch (operateType) {
        case upOperate:
        {
            x = 0 ; y = _speed;
        }
            break;
            case downOperate:
        {
            x = 0 ; y = -_speed;
        }
            break;
            case leftOperate:
        {
            x = - _speed ; y = 0;

        }
            break;
            case rightOperate:
        {
            x = _speed ; y = 0;

        }
            break;
            
        default:
            break;
    }
    
    BLOCK_EXEC(_moveBlock,x,y,operateType);
    
}



- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        _time = 0.015;
        self.operateType = moveAttribute;
        
       // self.backgroundColor = [UIColor blackColor];
        self.normalAlpha = 1;
        self.selectAlpha = .5;
        self.userInteractionEnabled = YES;
        self.alpha = self.normalAlpha;
    }
    
    return self;
}




@end
