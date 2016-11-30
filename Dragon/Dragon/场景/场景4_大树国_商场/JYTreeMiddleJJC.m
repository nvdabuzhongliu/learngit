//
//  JYTreeMiddleJJC.m
//  Dragon
//
//  Created by 吴冬 on 16/9/12.
//  Copyright © 2016年 北京金源互动科技有限公司. All rights reserved.
//


@implementation JYTreeMiddleJJC
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
    [self _setBg:[UIImage imageNamed:@"大树中部_竞技场.png"]];
    
    //设置主角
    [self setPlayerType:@"left"];
    [self addChild:self.player];
    
    if ([kDeviceVersion floatValue] < 8.0) {
        
    }else{
        _bg = (SKSpriteNode *)[self childNodeWithName:@"bg"];
    }
 
    //墙壁
    [self createWalls:7 superSence:_bg];
    
    //大树国中部node
    [self _createMiddleNode];
    
    //大树国顶部node
    [self _createTopNode];
    
    //JJC里边
    [self _createJJC];
    
    [self setMonsterWithSuperSence:self];

}

- (void)_createJJC
{
    SKSpriteNode *node = (SKSpriteNode *)[_bg childNodeWithName:kSence_JJC];
    [self setChangeSenceNode:node key:kSence_JJC];
}

- (void)_createMiddleNode
{
    SKSpriteNode *node = (SKSpriteNode *)[_bg childNodeWithName:kSence_treeMiddle];
    [self setChangeSenceNode:node key:kSence_treeMiddle];
}

- (void)_createTopNode
{
    SKSpriteNode *node = (SKSpriteNode *)[_bg childNodeWithName:kSence_treeTop];
    [self setChangeSenceNode:node key:kSence_treeTop];
}

#pragma mark 碰撞检测
- (void)didBeginContact:(SKPhysicsContact *)contact
{
    SKSpriteNode * A = (SKSpriteNode *)contact.bodyA.node;
    //SKSpriteNode * B = (SKSpriteNode *)contact.bodyB.node;
    
    if ([A.userData objectForKey:kSence_treeMiddle]) {
        
        [self presentSceneWithPosition:CGPointMake(135 + self.player.size.width / 2.0 + 5,self.screenHeight - self.player.size.height / 2.0 - 5) scenePosition:CGPointMake(0, 0) texture:self.dic_player[@"down"][0] key:kSence_treeMiddle tra:nil];
    }
    
    else if([A.userData objectForKey:kSence_treeTop]){
    
        [self presentSceneWithPosition:CGPointMake(135 + self.player.size.width / 2.0 + 5,self.player.size.height / 2.0 + 5) scenePosition:CGPointMake(0, 0) texture:self.dic_player[@"up"][0] key:kSence_treeTop tra:nil];
        
    }
    
    else if([A.userData objectForKey:kSence_JJC]){
    
        [self presentSceneWithPosition:CGPointMake(1000, 30) scenePosition:CGPointMake(-667, 0) texture:self.dic_player[@"up"][0] key:kSence_JJC tra:nil];
        
    }
}


@end
