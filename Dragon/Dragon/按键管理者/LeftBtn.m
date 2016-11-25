//
//  LeftBtn.m
//  ddd
//
//  Created by 吴冬 on 16/8/19.
//  Copyright © 2016年 北京金源互动科技有限公司. All rights reserved.
//

#import "LeftBtn.h"

@implementation LeftBtn

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.moveTimer invalidate];
    self.stopMoveBlock();
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    if (self.operateType == moveAttribute) {
    self.moveTimer = [NSTimer scheduledTimerWithTimeInterval:self.time target:self selector:@selector(moveAction:) userInfo:@(leftOperate) repeats:YES];
    }else{
        
        self.selectBlock(leftOperate);
    }
    
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"移动了左");
    for (UITouch *touch in touches) {
        CGPoint point = [touch locationInView:self];
        
        NSLog(@"x:%lf \n y:%lf",point.x,point.y);
        
        if (point.x < 0 || point.x > 50 || point.y < 0 || point.y > 50) {
           
            NSLog(@"我需要停止了");
            [self.moveTimer invalidate];
            self.stopMoveBlock();
            
        }
        
    }
}

@end
