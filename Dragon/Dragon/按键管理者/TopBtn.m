//
//  TopBtn.m
//  ddd
//
//  Created by 吴冬 on 16/8/19.
//  Copyright © 2016年 北京金源互动科技有限公司. All rights reserved.
//

#import "TopBtn.h"

@implementation TopBtn


- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.moveTimer invalidate];
    self.stopMoveBlock();

}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
  
    if (self.operateType == moveAttribute) {
         self.moveTimer = [NSTimer scheduledTimerWithTimeInterval:self.time target:self selector:@selector(moveAction:) userInfo:@(upOperate) repeats:YES];
    }else{
        self.selectBlock(upOperate);

    }
}

@end
