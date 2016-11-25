//
//  JYPrison1.m
//  Dragon
//
//  Created by 吴冬 on 16/11/15.
//  Copyright © 2016年 北京金源互动科技有限公司. All rights reserved.
//


@implementation JYPrison1
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
    [self createWalls:9 superSence:self];
    
    //怪物
    [self setMonsterWithSuperSence:self imageNames:@[@"史莱姆.png",@"蝙蝠.png",@"史莱姆.png"]];
    
    //JYImperialPlace
    [self _createImperialPalce];
    
    //JYDoor1
    [self _createDoor1];
    
}

- (void)_createDoor1
{
    SKSpriteNode *node = (SKSpriteNode *)[self childNodeWithName:@"JYDoor1"];
    [self setChangeSenceNode:node key:kSence_door1];

}

- (void)_createImperialPalce
{
    SKSpriteNode *node = (SKSpriteNode *)[self childNodeWithName:@"JYImperialPlace"];
    [self setChangeSenceNode:node key:kSence_imperialPlace];
}

- (void)didBeginContact:(SKPhysicsContact *)contact
{
    SKSpriteNode * A = (SKSpriteNode *)contact.bodyA.node;
//    SKSpriteNode * B = (SKSpriteNode *)contact.bodyB.node;
    
    if ([A.userData objectForKey:kSence_imperialPlace])
    {
        
        [self presentSceneWithPosition:CGPointMake(230, 120) scenePosition:CGPointMake(0, 0) texture:self.dic_player[@"right"][0] key:kSence_imperialPlace tra:nil];
    }
    
    else if([A.userData objectForKey:kSence_door1]){
    
        [self presentSceneWithPosition:CGPointMake(535, 50) scenePosition:CGPointMake(0, 0) texture:self.dic_player[@"up"][0] key:kSence_door1 tra:nil];
    }

}


@end
