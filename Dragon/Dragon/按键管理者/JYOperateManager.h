//
//  JYOperateManager.h
//  ddd
//
//  Created by 吴冬 on 16/8/19.
//  Copyright © 2016年 北京金源互动科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "JYEnum.h"
#import "JYOperateBtn.h"


@interface JYOperateManager : UIView


@property (nonatomic ,strong)NSTimer *moveTimer;

+ (JYOperateManager *)manager;
- (void)createOperateBtn;



//相关操作方法
@property (nonatomic ,copy)void (^moveBlock)(CGFloat x,CGFloat y,DirectionType type);//移动
@property (nonatomic ,copy)void (^stopMoveBlock)();

@property (nonatomic ,copy)void (^selectBlock)(DirectionType type); //选择
@property (nonatomic ,copy)void (^confirmBlock)();                //确定
@property (nonatomic ,copy)void (^cancelBlock)();                 //取消

@property (nonatomic ,strong)  JYOperateBtn *top;
@property (nonatomic ,strong)  JYOperateBtn *down;
@property (nonatomic ,strong)  JYOperateBtn *left;
@property (nonatomic ,strong)  JYOperateBtn *right;
@property (nonatomic ,strong)  UIButton     *confirm;
@property (nonatomic ,strong)  UIButton     *cancel;

@property (nonatomic ,assign)OperateType operateType;  //操作状态
@property (nonatomic ,assign)DirectionType directionType;
@property (nonatomic ,assign)CGFloat speed;            //行走速度

@property (nonatomic ,strong)UIColor *btnColor;

//可以移动和选择
- (void)canMove:(BOOL)canMove;
- (void)canSelect:(BOOL)canSelect;

//停止移动，终止定时器
- (void)stopMove;

@end
