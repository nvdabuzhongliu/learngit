//
//  JYStartGame.h
//  ddd
//
//  Created by 吴冬 on 16/8/23.
//  Copyright © 2016年 北京金源互动科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import "BaseScene.h"
#import "BaseVC.h"

@class JYStartGame;
//起始场景
@interface BeginGameScene : BaseScene
@property (nonatomic ,assign)CGFloat currentRate;
- (void)operation:(JYStartGame *)operation;
@end

//孵化室1
@interface JYIncubateScene : BaseScene

@property (nonatomic ,copy)NSString *incubateScene2;
@property (nonatomic ,copy)NSString *beginGameScene;

@end

//孵化室2
@interface JYIncubateScene2 : BaseScene

@property (nonatomic ,copy)NSString *incubateScene;
@property (nonatomic ,copy)NSString *treeBottom;

@end

//大树国底部
@interface JYTreeBottom : BaseScene
@end

//家
@interface JYHomeScene : BaseScene
@end

//商场
@interface JYStoreScene : BaseScene
@end

//大树国中部
@interface JYTreeMiddle : BaseScene
@end

//大树国中部竞技场
@interface JYTreeMiddleJJC : BaseScene
@end

//大树国顶部
@interface JYTreeTop : BaseScene
@end

//皇宫
@interface JYImperialPlace : BaseScene
@end

//皇宫储藏室
@interface JYImperialCollection : BaseScene
@end

//怪兽牧场
@interface JYMonsterPastureland : BaseScene
@end

//监牢一层
@interface JYPrison1 : BaseScene
@end

//第一传送门
@interface JYDoor1 : BaseScene
@end

@interface JYDoor1_1 : BaseScene
@end

@interface JYDoor1_4 : BaseScene
@end


//测试
@interface TextScene : BaseScene
@end

@interface JYStartGame : BaseVC<UITextFieldDelegate,UIScrollViewDelegate,UINavigationControllerDelegate>

@property (nonatomic ,strong)BaseScene *scene;

@property (nonatomic ,copy)NSMutableDictionary *playerDic; //主角图片

@property (nonatomic ,assign)CGFloat systemSpeed;

@end
