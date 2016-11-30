//
//  JYDoor1_4.m
//  Dragon
//
//  Created by 吴冬 on 16/11/29.
//  Copyright © 2016年 北京金源互动科技有限公司. All rights reserved.
//

@implementation JYDoor1_4

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
    [_bg addChild:self.player];
    
    //墙
    [self createWalls:11 superSence:_bg];
    
    //怪物
    [self setMonsterWithSuperSence:_bg imageNames:@[@"史莱姆.png",@"蝙蝠.png",@"史莱姆.png"]];
    
    //回储存室
    [self _createImperialCollection];
    
}

- (void)_createImperialCollection
{
    SKSpriteNode *node = (SKSpriteNode *)[_bg childNodeWithName:kSence_imperialCollection];
    
    [self setChangeSenceNode:node key:kSence_imperialCollection];
}

- (void)didBeginContact:(SKPhysicsContact *)contact
{

    SKSpriteNode * A = (SKSpriteNode *)contact.bodyA.node;
    //    SKSpriteNode * B = (SKSpriteNode *)contact.bodyB.node;
    
    if ([A.userData objectForKey:kSence_imperialCollection])
    {
        
        [self presentSceneWithPosition:CGPointMake(self.player.size.width / 2.0 + 10, 245) scenePosition:CGPointMake(0, 0) texture:self.dic_player[@"right"][0] key:kSence_imperialCollection tra:nil];
    }
    
 
}

@end
