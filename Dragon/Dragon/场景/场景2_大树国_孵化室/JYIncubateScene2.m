//
//  JYIncubateScene2.m
//  ddd
//
//  Created by 吴冬 on 16/9/6.
//  Copyright © 2016年 北京金源互动科技有限公司. All rights reserved.
//



@implementation JYIncubateScene2

{

    SKSpriteNode *_npc1;
    NSMutableDictionary *_npc1Dic;
    
    SKSpriteNode *_npc2;
    NSMutableDictionary *_npc2Dic;
    
    SKSpriteNode *_npc3;
    NSMutableDictionary *_npc3Dic;
    
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
    [self _setBg:[UIImage imageNamed:@"孵化室背景2_1"]];
        
    
    //设置主角
    [self setPlayerType:@"left"];
    [self addChild:self.player];
    

    //四周的墙
    [self _createWall];

    //隐藏墙，返回cubateScene1
    [self _createPopNode];
    
    //npc1
    [self _createNpc1];
    
    //npc2
    [self _createNpc2];
    
    //npc3
    [self _createNpc3];
    
    //书架
    [self _createBookShelf];
    
    //进入下个场景
    [self _createPushNode];
    
    [self setMonsterWithSuperSence:self];

}

//墙
- (void)_createWall
{
    SKSpriteNode *bottomWall = [SKSpriteNode node];
    bottomWall.position = CGPointMake(0, 0);
    bottomWall.size = CGSizeMake(self.screenWidth, 20);
    
    SKPhysicsBody *body = [self _physicsBody:self.screenWidth height:20 x:0 y:0];
    bottomWall.physicsBody = body;
    [self _setContact:bottomWall userData:[@{@"bottomWall":@(1)} mutableCopy]];
    
    
    SKSpriteNode *leftWall = [SKSpriteNode node];
    leftWall.position = CGPointMake(0, 90);
    leftWall.size = CGSizeMake(24, self.screenHeight);
    
    SKPhysicsBody *body1 = [self _physicsBody:24 height:self.screenHeight x:0 y:0];
    leftWall.physicsBody = body1;
    [self _setContact:leftWall userData:[@{@"leftWall":@(1)} mutableCopy]];
    
    
    SKSpriteNode *topWall1 = [SKSpriteNode node];
    topWall1.position = CGPointMake(0, self.screenHeight - 80);
    topWall1.size = CGSizeMake(305, 80);
    
    SKPhysicsBody *body2 = [self _physicsBody:305 height:80 x:0 y:0];
    topWall1.physicsBody = body2;
    [self _setContact:topWall1 userData:[@{@"topWall1":@(1)} mutableCopy]];
    
    
    SKSpriteNode *topWall2 = [SKSpriteNode node];
    topWall2.position = CGPointMake(400, self.screenHeight - 80);
    topWall2.size = CGSizeMake(self.screenWidth, 80);
    
    SKPhysicsBody *body3 = [self _physicsBody:500 height:80 x:0 y:0];
    topWall2.physicsBody = body3;
    [self _setContact:topWall2 userData:[@{@"topWall2":@(1)} mutableCopy]];
    
    SKSpriteNode *rightWall = [SKSpriteNode node];
    rightWall.position = CGPointMake(self.screenWidth - 24, 0);
    rightWall.size = CGSizeMake(24, self.screenHeight);
    
    SKPhysicsBody *body4 = [self _physicsBody:24 height:self.screenHeight x:0 y:0];
    rightWall.physicsBody = body4;
    [self _setContact:rightWall userData:[@{@"rightWall":@(1)} mutableCopy]];
    
    
    
    
    
    [self addChild:topWall1];
    [self addChild:leftWall];
    [self addChild:topWall2];
    [self addChild:bottomWall];
    [self addChild:rightWall];
}

//孵化室1
- (void)_createPopNode
{
    SKSpriteNode *PopNode = [SKSpriteNode node];
    PopNode.position = CGPointMake(300, self.screenHeight - 1);
    PopNode.size = CGSizeMake(300, 1);
    
    SKPhysicsBody *body = [self _physicsBody:300 height:1 x:0 y:0];
    PopNode.physicsBody = body;
    [self _setContact:PopNode userData:[@{kSence_incubate:@(1)} mutableCopy]];
    
    
    [self addChild:PopNode];

}

//大树国底部
- (void)_createPushNode
{
    SKSpriteNode *PushNode = [SKSpriteNode node];
    PushNode.position = CGPointMake(0, 0);
    PushNode.size = CGSizeMake(1, 90);
    
    SKPhysicsBody *body = [self _physicsBody:1 height:90 x:0 y:0];
    PushNode.physicsBody = body;
    [self _setContact:PushNode userData:[@{kSence_treeBottom:@(1)} mutableCopy]];
    
    
    [self addChild:PushNode];
}

//npc1
- (void)_createNpc1
{
    UIImage *image = [UIImage imageNamed:@"孵化室_npc2_1.png"];
    NSMutableArray *imageArr = [JYTool image:image size:CGSizeMake(96 / 3.0, 128 / 4.0) line:3 arrange:3];
    _npc1Dic = [JYTool images:imageArr arrange:3 line:3];
    
    _npc1 = [self _createNPC:CGPointMake(500, 120) key:@"npc1" dic:_npc1Dic];
    [self addChild:_npc1];
}

//npc2
- (void)_createNpc2
{
    UIImage *image = [UIImage imageNamed:@"孵化室_npc2_2.png"];
    NSMutableArray *imageArr = [JYTool image:image size:CGSizeMake(96 / 3.0, 128 / 4.0) line:3 arrange:3];
    _npc2Dic = [JYTool images:imageArr arrange:3 line:3];
    
    _npc2 = [self _createNPC:CGPointMake(250, 250) key:@"npc2" dic:_npc2Dic];
    [self addChild:_npc2];
}

//npc3
- (void)_createNpc3
{
    UIImage *image = [UIImage imageNamed:@"孵化室_npc2_3.png"];
    NSMutableArray *imageArr = [JYTool image:image size:CGSizeMake(96 / 3.0, 128 / 4.0) line:3 arrange:3];
    _npc3Dic = [JYTool images:imageArr arrange:3 line:3];
    
    _npc3 = [self _createNPC:CGPointMake(100, 150) key:@"npc3" dic:_npc3Dic];
    [self _setContact:_npc3 userData:[@{@"npc3":@(1)}mutableCopy]];
    [self addChild:_npc3];
}

- (void)_createBookShelf
{
    SKSpriteNode *node = [SKSpriteNode spriteNodeWithImageNamed:@"书架.png"];
    node.position = CGPointMake(565, 238);
    node.anchorPoint = CGPointMake(0, 0);
    node.zPosition = kZposition_player - 2;
    [self addChild:node];
    
    SKPhysicsBody *body = [self _physicsBody:565 height:238 x:20 y:25];
    node.physicsBody = body;
    
    [self _setContact:node userData:[@{@"bookShelf":@(1)}mutableCopy]];
}

#pragma mark 切换场景


//返回上一幕
- (void)popScene
{
    [self stopMove];
    
    /*
    BLOCK_EXEC(self.popSceneBlock,self.popKey,[SKTransition fadeWithDuration:2.0],CGPointMake(self.screenWidth / 2.0, 30),self.dic_player[@"up"][0]);
     */
}

//推出下一幕
- (void)pushScene
{
    NSLog(@"下一幕了");
    
    [self stopMove];
   
    /*
    JYSceneManager *manager = [JYSceneManager manager];

    JYTreeBottom *treeBottom = manager.sceneDic[kSence_treeBottom];
    SKTransition *tra = [SKTransition fadeWithDuration:2.0];

    if (!treeBottom) {
        treeBottom = [[JYTreeBottom alloc] initWithSize:CGSizeMake(self.screenWidth, self.screenHeight)];
        treeBottom.scaleMode = SKSceneScaleModeAspectFill;
        treeBottom.model = self.model;
        BLOCK_EXEC(self.pushSceneBlock,kSence_treeBottom,treeBottom,tra,CGPointMake(270, 80),self.dic_player[@"left"][0]);
     
    }
    
      BLOCK_EXEC(self.pushSceneBlock,kSence_treeBottom,treeBottom,tra,CGPointMake(270, 80),self.dic_player[@"left"][0]);
     
     */
}

#pragma mark 碰撞检测
- (void)didBeginContact:(SKPhysicsContact *)contact
{
    SKSpriteNode * A = (SKSpriteNode *)contact.bodyA.node;
    SKSpriteNode * B = (SKSpriteNode *)contact.bodyB.node;
    

    if ([A.userData objectForKey:kSence_incubate])
    {
  
        //present 孵化室1
        [self presentSceneWithPosition:CGPointMake(self.screenWidth / 2.0, 30) scenePosition:CGPointMake(0, 0) texture:self.dic_player[@"up"][0] key:kSence_incubate tra:nil];
     
    }
    
    else if([A.userData objectForKey:kSence_treeBottom])
    {
        //pressnt 大树国底部
        [self presentSceneWithPosition:CGPointMake(270, 80) scenePosition:CGPointMake(0, 0) texture:self.dic_player[@"left"][0] key:kSence_treeBottom tra:nil];
    }
   
    else if([A.userData objectForKey:@"bookShelf"])
    {
        NSLog(@"书架");
    }
    
    else if([B.userData objectForKey:@"npc1"])
    {
        NSLog(@"右下Npc");
    }
    
    else if([B.userData objectForKey:@"npc2"])
    {
        NSLog(@"上npc");
    }
    
    else if([B.userData objectForKey:@"npc3"])
    {
        NSLog(@"左下npc");
    }
    
    
    
}

- (void)didEndContact:(SKPhysicsContact *)contact
{
    
    
}

#pragma mark 工具方法
//创建npc
- (SKSpriteNode *)_createNPC:(CGPoint )point
                         key:(NSString *)key
                         dic:(NSMutableDictionary *)dic
{
    
    
   SKSpriteNode *node = [SKSpriteNode spriteNodeWithTexture:dic[@"down"][0]];
    
    node.position = point;
    node.zPosition = kZposition_player-2;
    node.xScale = 1.4;
    node.yScale = 1.4;
    SKPhysicsBody *body = [self _physicsBodyForNPC:32*1.4 height:32*1.4 ];
    node.physicsBody = body;
    
    [self _setContact:node userData:[@{key:@(1)}mutableCopy]];
    
    
    NSMutableArray *arr = [NSMutableArray arrayWithArray:dic[@"down"]];
    [arr removeObjectAtIndex:1];
    SKAction *runAction = [SKAction animateWithTextures:arr timePerFrame:0.5];
    SKAction *rep = [SKAction repeatActionForever:runAction];
    
    [node runAction:rep withKey:@"run"];
    
    return node;
}

@end
