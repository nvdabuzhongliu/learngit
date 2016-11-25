//
//  JYOperateBtn.h
//  ddd
//
//  Created by 吴冬 on 16/8/19.
//  Copyright © 2016年 北京金源互动科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>




@interface JYOperateBtn : UIView

@property (nonatomic ,copy)void (^moveBlock)(CGFloat x,CGFloat y ,DirectionType type);
@property (nonatomic ,copy)void (^stopMoveBlock)();

@property (nonatomic ,copy)void (^selectBlock)(DirectionType type);


@property (nonatomic ,strong)NSTimer *moveTimer;
@property (nonatomic ,assign)CGFloat speed;
@property (nonatomic ,assign)CGFloat time;


@property (nonatomic ,assign)CGFloat selectAlpha;
@property (nonatomic ,assign)CGFloat normalAlpha;

@property (nonatomic ,assign)OperateType operateType;
@property (nonatomic ,assign)DirectionType controlType;

//移动方法
- (void)moveAction:(NSTimer *)timer;



@end
