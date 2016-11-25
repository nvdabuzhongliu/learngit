//
//  JYTool.h
//  ddd
//
//  Created by 吴冬 on 16/8/22.
//  Copyright © 2016年 北京金源互动科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

@interface JYTool : NSObject


/**
 *  图片数组
 */
+ (NSMutableArray *)image:(UIImage *)image size:(CGSize )picSize line:(int )line arrange:(int )arrange;


/**
 *  图片字典
 */
+ (NSMutableDictionary *)images:(NSMutableArray *)images arrange:(int )arrange line:(int )line;
/**
 *  图片字典，人物朝向，上在第一行
 */
+ (NSMutableDictionary *)imagesUpFirst:(NSMutableArray *)images arrange:(int )arrange line:(int )line;

/**
 *  旋转动画
 */
+ (SKAction *)revolveAction:(NSMutableDictionary *)dic
                       time:(NSTimeInterval )timer
               hideOrAppear:(BOOL)isHidden
                      count:(NSInteger )count
               timePerFrame:(NSTimeInterval )timerPerFrame;


/**
 *  设置不可动场景物理属性
 */
+ (SKPhysicsBody *)_physicsBody:(CGFloat )width height:(CGFloat )height;

@end
