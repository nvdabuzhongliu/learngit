//
//  JYTreeMiddleJJC.m
//  Dragon
//
//  Created by 吴冬 on 16/9/12.
//  Copyright © 2016年 北京金源互动科技有限公司. All rights reserved.
//


@implementation JYTreeMiddleJJC



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
    
    //墙壁
    [self _createWalls];
    
    //大树国中部node
    [self _createMiddleNode];
    
    //大树国顶部node
    [self _createTopNode];
 
    [self setMonsterWithSuperSence:self];

}

- (void)_createWalls
{
    NSArray *arr = @[@[@(135),@(0),@(1),@(self.screenHeight)],
                     @[@(135 + 60),@(0),@(1),@(90)],
                     @[@(135 + 60),@(210),@(1),@(165)],
                     @[@(135 + 60),@(90),@(325),@(1)],
                     @[@(135 + 60 + 325),@(90),@(1),@(50)],
                     @[@(135 + 60 + 325),@(90 + 50),@(150),@(1)],
                     @[@(135 + 60),@(210),@(70),@(1)],
                     @[@(135 + 60 + 70),@(210),@(1),@(20)],
                     @[@(135 + 60 + 70),@(210 + 20),@(145),@(1)],
                     @[@(135 + 60 + 70 + 145),@(210),@(1),@(20)],
                     @[@(135 + 60 + 70 + 145),@(210),@(70),@(1)],
                     @[@(135 + 60 + 70 + 145),@(210),@(1),@(170)],
                     @[@(135 + 60 + 70 + 145 + 70),@(260),@(1),@(200)],
                     @[@(135 + 60 + 70 + 145 + 70),@(260),@(200),@(1)]];
    
    [self _createWalls:arr superSence:self];
  
}

- (void)_createMiddleNode
{
    [self setChangeSenceNode:@{@"x":@(135),@"y":@(0),@"width":@(60),@"height":@(1)} key:kSence_treeMiddle superSence:self];
}

- (void)_createTopNode
{
   [self setChangeSenceNode:@{@"x":@(135),@"y":@(self.screenHeight - 1),@"width":@(60),@"height":@(1)} key:kSence_treeTop superSence:self];
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
}


@end
