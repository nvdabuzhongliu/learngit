//
//  JYDoor1_1.m
//  Dragon
//
//  Created by 吴冬 on 16/11/22.
//  Copyright © 2016年 北京金源互动科技有限公司. All rights reserved.
//


@implementation JYDoor1_1

{
    SKSpriteNode *_bg;
}

- (void)didMoveToView:(SKView *)view
{
    if ([self initWithCreateKey]) {
        [self _createNodes];
    }
    
    [self changePlayerPosition];
    _bg.position = self.scenePoint;
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
    [self createWalls:38 superSence:_bg];
    
    //怪物
    [self setMonsterWithSuperSence:_bg imageNames:@[@"史莱姆.png",@"蝙蝠.png",@"史莱姆.png"]];
    
    //最终boss
    [self _createBoss];
}

- (void)_createBoss
{
    SKSpriteNode *node = (SKSpriteNode *)[_bg childNodeWithName:@"JYDoor1_4"];
    [self setChangeSenceNode:node key:kSence_door1_4];
}

- (BOOL)moveActionWithkey:(NSString *)key x:(CGFloat)x y:(CGFloat)y
{
    BOOL isCut = [super moveActionWithkey:key x:x y:y];
    
    if (isCut) {
        return NO;
    }
    
   // NSLog(@"%lf",self.player.position.x);
    
    _bg.position = CGPointMake(_bg.position.x - x, _bg.position.y - y);
    
    if (_bg.position.x < - 2 * self.screenWidth || self.player.position.x > self.screenWidth * 2 + self.screenWidth / 2.0) {
        _bg.position = CGPointMake(- 2 * self.screenWidth, _bg.position.y);
    }else if(_bg.position.x > 0 || self.player.position.x < self.screenWidth / 2.0){
        _bg.position = CGPointMake(0, _bg.position.y);
    }
    
    if (_bg.position.y < - 2 * self.screenHeight) {
        _bg.position = CGPointMake(_bg.position.x, - 2 * self.screenHeight);
    }else if(_bg.position.y > 0){
        _bg.position = CGPointMake(_bg.position.x, 0);
    }
    
    return YES;
    
}

- (void)didBeginContact:(SKPhysicsContact *)contact
{
    SKSpriteNode * A = (SKSpriteNode *)contact.bodyA.node;
    //    SKSpriteNode * B = (SKSpriteNode *)contact.bodyB.node;
    
    if ([A.userData objectForKey:kSence_door1_4])
    {
        
        [self presentSceneWithPosition:CGPointMake(500, 250) scenePosition:CGPointMake(-667, 0) texture:self.dic_player[@"down"][0] key:kSence_door1_4 tra:nil];
    }
    
   
}

@end
