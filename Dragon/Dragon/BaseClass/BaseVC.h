//
//  BaseVC.h
//  ddd
//
//  Created by 吴冬 on 16/8/24.
//  Copyright © 2016年 北京金源互动科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>

@interface BaseVC : UIViewController
@property (nonatomic ,strong)JYPlayerModel *model;
@property (nonatomic ,strong)SKView *skView;

- (NSMutableDictionary *)setPlayerDic;

/**
 *  设置移动速度
 */
- (void)setSpeed:(CGFloat )speed;

/**
 *  移动
 */
- (void)move:(CGFloat )x
           y:(CGFloat )y
        type:(DirectionType )type;

/**
 *  停止移动
 */
- (void)stopMove;


/**
 *  左右上下选择
 */
- (void)selectUpDownLeftAndRight:(DirectionType )type;

/**
 *  确定
 */
- (void)confirm;

/**
 *  取消
 */
- (void)cancel;



@end
