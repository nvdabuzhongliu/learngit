//
//  JYTreeMiddle.m
//  Dragon
//
//  Created by 吴冬 on 16/9/9.
//  Copyright © 2016年 北京金源互动科技有限公司. All rights reserved.
//


@implementation JYTreeMiddle



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
    [self _setBg:[UIImage imageNamed:@"大树国中部拼凑.png"]];
    
    //设置主角
    [self setPlayerType:@"left"];
    [self addChild:self.player];
    
      
    //创建墙壁边缘
    [self _createWall];
    
    //创建云
    [self _createCloud];
    
    //大树底部Node
    [self _createTreeBottomNode];
    
    //大树竞技场Node
    [self _createJJCNode];
    
    [self setMonsterWithSuperSence:self];

}


- (void)_createCloud
{
    SKSpriteNode *cloud1 = [SKSpriteNode spriteNodeWithImageNamed:@"云1"];
    cloud1.position = CGPointMake(-cloud1.size.width, 130);
    cloud1.anchorPoint = CGPointMake(0, 0);
    cloud1.zPosition = kZposition_player + 1;
    [self addChild:cloud1];
    
    
    SKAction *action1 = [self cloudMoveAction:self.screenWidth other:-cloud1.size.width time:70];
    [cloud1 runAction:action1];
    
    SKSpriteNode *cloud2 = [SKSpriteNode spriteNodeWithImageNamed:@"云2"];
    cloud2.position = CGPointMake(self.screenWidth + cloud2.size.width, 210);
    cloud2.anchorPoint = CGPointMake(0, 0);
    cloud2.zPosition = kZposition_player + 1;
    [self addChild:cloud2];
    
    SKAction *action2 = [self cloudMoveAction:-cloud2.size.width other:cloud2.size.width time:100];
    [cloud2 runAction:action2];
    
    
    SKSpriteNode *cloud3 = [SKSpriteNode spriteNodeWithImageNamed:@"云3"];
    cloud3.position = CGPointMake(0, -250);
    cloud3.anchorPoint = CGPointMake(0, 0);
    cloud3.zPosition = kZposition_player + 1;
    [self addChild:cloud3];
    
    SKAction *action3 = [self cloudMoveAction:self.screenWidth other:-cloud3.size.width time:100];
    [cloud3 runAction:action3];
    
}

- (void)_createWall
{
    NSArray *arr = @[
  @[@(135),@(0),@(1),@(self.screenHeight)],
  @[@(135 + 60),@(210),@(1),@(165)],
  @[@(135+60),@(45),@(400),@(1)],
  @[@(135 + 60),@(210),@(145),@(1)],
  @[@(135 + 60),@(0),@(1),@(45)],
  @[@(135 + 60 + 145 + 65),@(210),@(140),@(1)],
  @[@(135 + 60 + 145 + 65),@(210),@(1),@(165)],
  @[@(135 + 60 + 145 + 65),@(260),@(200),@(1)],
  @[@(135 + 60 + 200 + 65),@(45 ),@(200),@(1)],
  @[@(135 + 60 + 200 + 65 + 140),@(45),@(1),@(50)],
  @[@(135 + 60 + 200 + 65 + 140),@(45+50),@(200),@(1)],
  @[@(535),@(210),@(1),@(200)],
  @[@(535),@(260),@(200),@(1)]];
    
    [self _createWalls:arr superSence:self];

    
}

- (void)_createTreeBottomNode
{
      [self setChangeSenceNode:@{@"x":@(135),@"y":@(1),@"width":@(60),@"height":@(1)} key:kSence_treeBottom superSence:self];
 
}

- (void)_createJJCNode
{
    [self setChangeSenceNode:@{@"x":@(135),@"y":@(self.screenHeight - 1),@"width":@(60),@"height":@(1)} key:kSence_treeMiddleJJC superSence:self];

}

#pragma mark 碰撞检测
- (void)didBeginContact:(SKPhysicsContact *)contact
{
    SKSpriteNode * A = (SKSpriteNode *)contact.bodyA.node;
    //SKSpriteNode * B = (SKSpriteNode *)contact.bodyB.node;
    
    if ([A.userData objectForKey:kSence_treeBottom])
    {
        
        [self presentSceneWithPosition:CGPointMake(135 + self.player.size.width / 2.0 + 5, self.screenHeight - self.player.size.height ) scenePosition:CGPointMake(0, 0) texture:self.dic_player[@"down"][0] key:kSence_treeBottom tra:nil];
    }
    
    else if([A.userData objectForKey:kSence_treeMiddleJJC])
    {
    
        [self presentSceneWithPosition:CGPointMake(135 + self.player.size.width / 2.0 + 5, self.player.size.height / 2.0 + 5) scenePosition:CGPointMake(0, 0) texture:self.dic_player[@"up"][0] key:kSence_treeMiddleJJC tra:nil];
    }
    
    
}


#pragma mark 工具方法
- (SKAction *)cloudMoveAction:(CGFloat )x1 other:(CGFloat )x2 time:(NSTimeInterval )time
{
    SKAction *moveRight = [SKAction moveToX:x1 duration:time];
    SKAction *moveLeft  = [SKAction moveToX:x2 duration:time];
    
    SKAction *seq = [SKAction sequence:@[moveRight,moveLeft]];
    
    
    SKAction *rep = [SKAction repeatActionForever:seq];
  
    
    return rep;
}



@end
