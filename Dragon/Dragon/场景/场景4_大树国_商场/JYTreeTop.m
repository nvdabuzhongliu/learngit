//
//  JYTreeTop.m
//  Dragon
//
//  Created by 吴冬 on 16/9/12.
//  Copyright © 2016年 北京金源互动科技有限公司. All rights reserved.
//


@implementation JYTreeTop

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
    [self _setBg:[UIImage imageNamed:@"大树国顶部.png"]];
    
    //设置主角
    [self setPlayerType:@"left"];
    [self addChild:self.player];
    
    //墙壁
    [self _createWalls];
    
    //移动的云
    [self _createCloud];
    
    //大树国中部竞技场
    [self _createJJCNode];
    
    //皇宫
    [self _createImperialPlace];

    [self setMonsterWithSuperSence:self];

}

- (void)_createWalls
{
    NSArray *arr = @[@[@(135),@(0),@(1),@(self.screenHeight)],
                     @[@(135 + 60),@(0),@(1),@(90)],
                     @[@(135 + 60),@(90),@(400),@(1)],
                     @[@(455),@(90),@(1),@(100)],
                     @[@(400),@(170),@(50),@(1)],
                     @[@(135),@(170),@(120),@(1)],
                     @[@(135 + 120),@(170),@(1),@(50)],
                     @[@(400),@(170),@(1),@(50)],
                     @[@(135 + 120),@(190),@(140),@(1)]];
    
    [self _createWalls:arr superSence:self];
}


- (void)_createJJCNode
{
    [self setChangeSenceNode:@{@"x":@(135),@"y":@(0),@"width":@(60),@"height":@(1)} key:kSence_treeMiddleJJC superSence:self];
}

- (void)_createImperialPlace
{
    [self setChangeSenceNode:@{@"x":@270,@"y":@190,@"width":@125,@"height":@1} key:kSence_imperialPlace superSence:self];
}

- (void)_createCloud
{
    SKSpriteNode *node = [SKSpriteNode spriteNodeWithImageNamed:@"云2.png"];
    node.position = CGPointMake(0, 0);
    node.zPosition = kZposition_player + 1;
    [self addChild:node];
    
    
    SKAction *action = [self cloudMoveAction:-node.size.width other:self.screenWidth + 300 time:100];
    
    [node runAction:action];
    
}

#pragma mark 碰撞检测
- (void)didBeginContact:(SKPhysicsContact *)contact
{
    SKSpriteNode * A = (SKSpriteNode *)contact.bodyA.node;
    //SKSpriteNode * B = (SKSpriteNode *)contact.bodyB.node;
    
    if ([A.userData objectForKey:kSence_treeMiddleJJC]) {
        
        [self presentSceneWithPosition:CGPointMake(135 + self.player.size.width / 2.0 + 5,self.screenHeight - self.player.size.height / 2.0 - 5) scenePosition:CGPointMake(0, 0) texture:self.dic_player[@"down"][0] key:kSence_treeMiddleJJC tra:nil];
    }
    
    else if([A.userData objectForKey:kSence_imperialPlace])
    {

        [self presentSceneWithPosition:CGPointMake(self.screenWidth / 2.0, self.player.size.height / 2.0 + 20) scenePosition:CGPointMake(0, 0) texture:self.dic_player[@"up"][0] key:kSence_imperialPlace tra:nil];
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
