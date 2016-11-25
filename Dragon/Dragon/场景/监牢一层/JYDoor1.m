//
//  JYDoor1.m
//  Dragon
//
//  Created by 吴冬 on 16/11/21.
//  Copyright © 2016年 北京金源互动科技有限公司. All rights reserved.
//


@implementation JYDoor1
{
    SKSpriteNode *_bg;
}


- (void)didMoveToView:(SKView *)view
{
  
    if ([self initWithCreateKey]) {
        [self _createNodes];
    }
    
    [self changePlayerPosition];
}

- (void)_createNodes
{
    self.physicsWorld.contactDelegate = self;
    
    [self setFrame];
    
    if ([kDeviceVersion floatValue] < 8.0) {
     
    }else{
        _bg = (SKSpriteNode *)[self childNodeWithName:@"bg"];
    }
    
    //设置主角
    [self setPlayerType:@"left"];
    [self addChild:self.player];
    
    //墙壁
    [self createWalls:9 superSence:_bg];
    
    //怪物
    [self setMonsterWithSuperSence:self imageNames:@[@"史莱姆.png",@"蝙蝠.png",@"史莱姆.png"]];
    
    //监牢1
    [self _createPrison1];
    
    //传送门1
    [self _createDoor1_1];
    
}

- (void)_createDoor1_1
{
    SKSpriteNode *node = (SKSpriteNode *)[_bg childNodeWithName:@"JYDoor1_1"];
    [self setChangeSenceNode:node key:kSence_door1_1];

}

- (void)_createPrison1
{
    SKSpriteNode *node = (SKSpriteNode *)[_bg childNodeWithName:@"JYPrison1"];
    [self setChangeSenceNode:node key:kSence_prison1];
}

- (void)didBeginContact:(SKPhysicsContact *)contact
{
    SKSpriteNode * A = (SKSpriteNode *)contact.bodyA.node;
    //    SKSpriteNode * B = (SKSpriteNode *)contact.bodyB.node;
    
    if ([A.userData objectForKey:kSence_prison1])
    {
        
        [self presentSceneWithPosition:CGPointMake(332, 265) scenePosition:CGPointMake(0, 0) texture:self.dic_player[@"down"][0] key:kSence_prison1 tra:nil];
    }
    
    else if ([A.userData objectForKey:kSence_door1_1])
    {
    
         [self presentSceneWithPosition:CGPointMake(667 / 2.0, 200) scenePosition:CGPointMake(0, 0) texture:self.dic_player[@"right"][0] key:kSence_door1_1 tra:nil];
        
    }
    
}


@end
