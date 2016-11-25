//
//  JYMonsterCharacter.h
//  ddd
//
//  Created by 吴冬 on 16/8/22.
//  Copyright © 2016年 北京金源互动科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(int ,MonsterCharacter){
 
    white = 0, 
    green ,
    blue  ,
    orange,
    
};

typedef NS_ENUM(int ,MonsterAttribute){
 
    gold = 0,
    wood    ,
    soil    ,
    water   ,
    fire    ,
};

//金 -> 木 -> 土 -> 水 -> 火 -> 金   %10 attribute

@interface JYMonsterModel : NSObject


@property (nonatomic ,assign)MonsterAttribute attribute; //属性
@property (nonatomic ,assign)MonsterCharacter character; //品质

@property (nonatomic ,strong)UIColor *color;


@property (nonatomic ,assign)int hp;        //生命
@property (nonatomic ,assign)int mp;        //魔法
@property (nonatomic ,assign)int attackValue; //攻击力
@property (nonatomic ,assign)int defendValue; //防御力


@end
