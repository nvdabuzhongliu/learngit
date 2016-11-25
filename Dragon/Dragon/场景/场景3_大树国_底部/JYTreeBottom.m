//
//  JYTreeBottom.m
//  Dragon
//
//  Created by 吴冬 on 16/9/8.
//  Copyright © 2016年 北京金源互动科技有限公司. All rights reserved.
//



@implementation JYTreeBottom



#pragma mark 初始化
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
    [self _setBg:[UIImage imageNamed:@"大树国底部拼凑.png"]];
    
    
    //设置主角
    [self setPlayerType:@"left"];
    [self addChild:self.player];
  
    //阶梯Node
    [self _createStairs];
    
    //墙
    [self _createWallNode];
    
    //通往大树国中部
    [self _createMiddleNode];
    
    [self setMonsterWithSuperSence:self];

}

//中间Node
- (void)_createMiddleNode
{

    SKSpriteNode *node = [SKSpriteNode node];
    node.position = CGPointMake(135, self.screenHeight - 1);
    node.size = CGSizeMake(60, 1);
    
    SKPhysicsBody *body = [self _physicsBody:60 height:1 x:0 y:0];
    node.physicsBody = body;
    
    [self _setContact:node userData:[@{kSence_treeMiddle:@(1)}mutableCopy]];
    
    [self addChild:node];
}

//阶梯
- (void)_createStairs
{
    SKSpriteNode *PopNode = [self _alphaNode:CGPointMake(300, 72) size:CGSizeMake(1, 1)];
    
    SKPhysicsBody *body = [self _physicsBody:1 height:1 x:0 y:0];
    PopNode.physicsBody = body;
    [self _setContact:PopNode userData:[@{kSence_incubate2:@(1)} mutableCopy]];
    
    
    [self addChild:PopNode];
}

//wall
- (void)_createWallNode
{
    
    SKSpriteNode *left1 = [self _alphaNode:CGPointMake(70, 0) size:CGSizeMake(2, self.screenHeight)];
    [self _alphaSetBody:left1 width:2 height:self.screenHeight x:0 y:0 key:@"left1"];
    [self addChild:left1];
    
    
    SKSpriteNode *left2 = [self _alphaNode:CGPointMake(135, 155) size:CGSizeMake(2, self.screenHeight - 140)];
    [self _alphaSetBody:left2 width:2 height:self.screenHeight - 140 x:0 y:0 key:@"left2"];
    [self addChild:left2];
    
    
    
    SKSpriteNode *bottom1 = [self _alphaNode:CGPointMake(0, 45) size:CGSizeMake(self.screenWidth, 2)];
    [self _alphaSetBody:bottom1 width:self.screenWidth height:2 x:0 y:0 key:@"bottom1"];
    [self addChild:bottom1];
    
    
    SKSpriteNode *right1 = [self _alphaNode:CGPointMake(535, 45) size:CGSizeMake(2, 185)];
    [self _alphaSetBody:right1 width:2 height:185 x:0 y:0 key:@"right1"];
    [self addChild:right1];
    
    
    SKSpriteNode *top1 = [self _alphaNode:CGPointMake(70, 140) size:CGSizeMake(65, 1)];
    [self _alphaSetBody:top1 width:65 height:2 x:0 y:15 key:@"top1"];
    [self addChild:top1];
    
    
    SKSpriteNode *top2 = [self _alphaNode:CGPointMake(200, 140) size:CGSizeMake(65, 1)];
    [self _alphaSetBody:top2 width:65 height:2 x:0 y:15 key:@"top2"];
    [self addChild:top2];
    
    
   
    SKSpriteNode *top3 = [self _alphaNode:CGPointMake(330, 140) size:CGSizeMake(65, 1)];
    [self _alphaSetBody:top3 width:65 height:2 x:0 y:15 key:@"top3"];
    [self addChild:top3];
    
    
    SKSpriteNode *top4 = [self _alphaNode:CGPointMake(465, 140) size:CGSizeMake(65, 1)];
    [self _alphaSetBody:top4 width:65 height:2 x:0 y:15 key:@"top4"];
    [self addChild:top4];
    
    
    SKSpriteNode *stairsRight1 = [self _alphaNode:CGPointMake(200, 155) size:CGSizeMake(2, 80)];
    [self _alphaSetBody:stairsRight1 width:2 height:75 x:0 y:0 key:@"stairsRight1"];
    [self addChild:stairsRight1];
    
    
    SKSpriteNode *stairsRight2 = [self _alphaNode:CGPointMake(200, 310) size:CGSizeMake(2, 80)];
    [self _alphaSetBody:stairsRight2 width:2 height:75 x:0 y:0 key:@"stairsRight2"];
    [self addChild:stairsRight2];
    
   
    SKSpriteNode *stairsRight3 = [self _alphaNode:CGPointMake(465, 160) size:CGSizeMake(2, 80)];
    [self _alphaSetBody:stairsRight3 width:2 height:70 x:0 y:0 key:@"stairsRight3"];
    [self addChild:stairsRight3];
    
   
    SKSpriteNode *top5 = [self _alphaNode:CGPointMake(200, 230) size:CGSizeMake(210, 2)];
    [self _alphaSetBody:top5 width:210 height:2 x:0 y:0 key:@"top5"];
    [self addChild:top5];
    
    
    SKSpriteNode *top6 = [self _alphaNode:CGPointMake(465, 150) size:CGSizeMake(75, 2)];
    [self _alphaSetBody:top6 width:75 height:2 x:0 y:15  key:@"top6"];
    [self addChild:top6];
    
    SKSpriteNode *top7 = [self _alphaNode:CGPointMake(465, 230) size:CGSizeMake(75, 2)];
    [self _alphaSetBody:top7 width:75 height:2 x:0 y:0 key:@"top7"];
    [self addChild:top7];
    
    
    SKSpriteNode *top8 = [self _alphaNode:CGPointMake(200, 310) size:CGSizeMake(140, 2)];
    [self _alphaSetBody:top8 width:140 height:2 x:0 y:0 key:@"top8"];
    [self addChild:top8];
    
    
    SKSpriteNode *top9 = [self _alphaNode:CGPointMake(395, 310) size:CGSizeMake(300, 2)];
    [self _alphaSetBody:top9 width:300 height:2 x:0 y:0 key:@"top9"];
    [self addChild:top9];
    
    SKSpriteNode *top10 = [self _alphaNode:CGPointMake(535, 180) size:CGSizeMake(150, 2)];
    [self _alphaSetBody:top10 width:150 height:2 x:0 y:0 key:@"top10"];
    [self addChild:top10];
    
}

- (void)_alphaSetBody:(SKSpriteNode *)node
                width:(CGFloat )width
               height:(CGFloat )height
                    x:(CGFloat )x
                    y:(CGFloat )y
                  key:(NSString *)key
{
    node.physicsBody = [self _physicsBody:width height:height x:x y:y];
    [self _setContact:node userData:[@{key:@(1)} mutableCopy]];

}

- (SKSpriteNode *)_alphaNode:(CGPoint)position size:(CGSize)size
{
    SKSpriteNode *node = [SKSpriteNode node];
    node.position = position;
    node.size     = size;
    
    return node;
}

#pragma mark 碰撞检测
- (void)didBeginContact:(SKPhysicsContact *)contact
{
    SKSpriteNode * A = (SKSpriteNode *)contact.bodyA.node;
    //SKSpriteNode * B = (SKSpriteNode *)contact.bodyB.node;
    
    if ([A.userData objectForKey:kSence_incubate2])
    {
        //present 孵化室2
        [self presentSceneWithPosition:CGPointMake(40, 50) scenePosition:CGPointMake(0, 0) texture:self.dic_player[@"right"][0] key:kSence_incubate2 tra:nil];
    }
    else if([A.userData objectForKey:kSence_treeMiddle]){
    
        //present 大树国中部
        [self presentSceneWithPosition:CGPointMake(135 + self.player.size.width / 2.0 + 5, self.player.size.height / 2.0 + 5) scenePosition:CGPointMake(0, 0) texture:self.dic_player[@"up"][0] key:kSence_treeMiddle tra:nil];
    }
    
}









@end
