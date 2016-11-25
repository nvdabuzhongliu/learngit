//
//  BaseScene.h
//  ddd
//
//  Created by 吴冬 on 16/8/24.
//  Copyright © 2016年 北京金源互动科技有限公司. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
//        categoryBitMask，它标记了物体属于那一类物体，默认值为0xffffffff
//        collisionBitMask，它标记了哪些物体可以跟其发生碰撞，默认值为0xffffffff
//        contactTestBitMask，它标记了哪些物体会和其发生碰撞后产生一些影响，默认值为0x00000000

@interface BaseScene : SKScene<SKPhysicsContactDelegate>





#pragma mark 布局场景操作相关
//是否第一次进入
@property (nonatomic ,assign)BOOL isAlreadyCreate;
//场景KEY
@property (nonatomic ,strong)NSMutableDictionary *sceneKeyDic;
@property (nonatomic ,copy)void (^beginOrEndGameBlock)(BOOL); //禁止移动操作
@property (nonatomic ,copy)void (^beginOrEndOperateBlock)(BOOL); //禁止AB操作
@property (nonatomic ,copy)void (^presentSceneBlock)(BaseScene *scene,SKTransition *,CGPoint position,SKTexture *texture);   //切换场景
@property (nonatomic ,copy)void (^showMonsterList)();//怪兽选项


@property (nonatomic ,assign)CGPoint scenePoint;
@property (nonatomic ,assign)CGFloat screenWidth;
@property (nonatomic ,assign)CGFloat screenHeight;

@property (nonatomic ,assign)int index;



//Action

/**
 *  切换场景
 *
 *  @param position 要显示的场景人物出现坐标
 *  @param texture  任务朝向
 *  @param key      要出现的class名
 */
- (void)presentSceneWithPosition:(CGPoint )position
                   scenePosition:(CGPoint)scenePosition
                         texture:(SKTexture *)texture
                             key:(NSString *)key
                             tra:(SKTransition *)tra;

/**
 *  切换场景改变player
 */
- (void)changePlayerPosition;

//玩家行为
- (BOOL)moveActionWithkey:(NSString *)key
                        x:(CGFloat )x
                        y:(CGFloat )y;

- (void)selectUpDownLeftAndRight:(DirectionType)type;


- (void)confirm;
- (void)cancel;
- (void)stopMove;


/**
 *  初始化场景
 *
 *  @return 如果场景未创建，返回YES
 */
- (BOOL)initWithCreateKey;

//设置背景
- (void)_setBg:(UIImage *)bgImage;
/**
 *  设置墙壁(ios8.0之前)
 *
 *  @param wallArr 墙壁数组：x,y,width,height
 */
- (void)_createWalls:(NSArray *)wallArr
          superSence:(SKNode *)sence;

//8之后创建方法
- (void)createWalls:(NSInteger )number superSence:(SKNode *)sence;

/**
 *  设置切换场景的Node
 */
- (void)setChangeSenceNode:(NSDictionary *)frameDic
                       key:(NSString *)key
                superSence:(SKNode *)sence;


//8以后切换方法
- (void)setChangeSenceNode:(SKSpriteNode *)node
                       key:(NSString *)key;




#pragma mark 玩家相关
//玩家node
@property (nonatomic ,strong)SKSpriteNode *cancelPrompt; //取消提示
@property (nonatomic ,strong)SKSpriteNode *confirmPrompt;//确认提示

@property (nonatomic ,strong)JYPlayerModel *model;
@property (nonatomic ,strong)SKSpriteNode  *player;
@property (nonatomic ,copy)NSMutableDictionary *dic_player;
@property (nonatomic ,assign)CGPoint playerPosition;    //刷新坐标
@property (nonatomic ,strong)SKTexture *playerTexture;  //朝向
@property (nonatomic ,assign)CGPoint playerCutPosition; //是否卡住的坐标

//Action

//行走动画
- (void)changePlayerPic:(NSString *)key;
//设置主角
- (void)setPlayerType:(NSString *)key;



#pragma mark 怪兽相关
//怪兽相关
@property (nonatomic ,strong)NSString *monsterKey1;
@property (nonatomic ,strong)NSString *monsterKey2;
@property (nonatomic ,strong)NSString *monsterKey3;

@property (nonatomic ,strong)SKSpriteNode *monsterNode1;
@property (nonatomic ,strong)SKSpriteNode *monsterNode2;
@property (nonatomic ,strong)SKSpriteNode *monsterNode3;


@property (nonatomic ,strong)NSMutableDictionary *monsterDic1;
@property (nonatomic ,strong)NSMutableDictionary *monsterDic2;
@property (nonatomic ,strong)NSMutableDictionary *monsterDic3;

@property (nonatomic ,assign)int       page;  //怪兽和玩家距离



//Action

//设置Monster
- (void)setMonsterWithSuperSence:(SKNode *)sence;
- (void)setMonsterWithSuperSence:(SKNode *)sence imageNames:(NSArray *)images;


//怪物行走动画
- (NSString *)changeMonsterPic:(NSString *)key
                          node:(SKSpriteNode *)node
                           dic:(NSMutableDictionary *)dic
                     changeKey:(NSString *)changeKey;



#pragma mark 按键提示
/**
 *  按键提示
 */
- (void)createPromptNode;

//show prompt
- (void)showCancelPrompt:(NSString *)text hidden:(BOOL)isHidden frame:(CGRect)frame;
- (void)showConfirmPrompt:(NSString *)text hidden:(BOOL)isHidden frame:(CGRect)frame;

@property (nonatomic ,copy)void (^showCancelPrompt)(NSString *text,BOOL hidden,UIFont *font,CGRect frame);
@property (nonatomic ,copy)void (^showConfirmPrompt)(NSString *text,BOOL hidden,UIFont *font ,CGRect frame);





#pragma mark 工具方法

- (void)setFrame;

//设置物理属性
- (SKPhysicsBody *)_physicsBody:(CGFloat )width height:(CGFloat )height x:(CGFloat )x y:(CGFloat )y;

//设置人物物理属性
- (SKPhysicsBody *)_physicsBodyForNPC:(CGFloat )width height:(CGFloat )height;

//设置与玩家的碰撞属性
- (void)_setContact:(SKSpriteNode *)node userData:(NSMutableDictionary *)data;

//可移动
- (void)canMove;







@end
