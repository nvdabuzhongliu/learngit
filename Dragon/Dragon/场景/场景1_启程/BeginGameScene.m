//
//  BeginGameScene.m
//  ddd
//
//  Created by 吴冬 on 16/8/24.
//  Copyright © 2016年 北京金源互动科技有限公司. All rights reserved.
//


/*
 ground.physicsBody?.categoryBitMask = landCategory
 ground.physicsBody?.contactTestBitMask = birdCategory
 ground.physicsBody?.collisionBitMask = birdCategory
   文档中的解释分别是： 1.一个标记，定义了这个物体所属分类 2.一个标记，定义了哪种物体接触到该物体，该物体会收到通知（谁撞我我会收到通知） 3.一个标记，定义了哪种物体会碰撞到自己 第二种是用来抛出接触消息的，第三种是用来检测碰撞的。碰撞检测，默认所有物体之间互相可碰撞。接触消息，默认所有物体接触都不产生消息，这样是为了保证效率。当你对某种接触感兴趣时，单独设置contactCategory，监听这类碰撞消息。
 */
@implementation BeginGameScene
{
    SKSpriteNode *_bgNode;
    
    
    int  _next;
    int  _time;
    
    BOOL _isContactDrawer1;
    BOOL _isContactDrawer2;
    BOOL _isContactDrawer3;
    
    BOOL _isContactBed;
    BOOL _isContactFurnace;
    
    BOOL _isMonsterEndSay;
    BOOL _isMonsterEndSay2;
    BOOL _isSister;
    BOOL _isNextScene;
    
    BOOL _isGrab;
    
    SKLabelNode *_labelNodel;
    
    SKSpriteNode *_furnaceNode;
    
    NSMutableArray *_furnaces;
    NSMutableArray *_transimtDoors;
    
    SKSpriteNode *_sister;
    SKSpriteNode *_monster1;
    SKSpriteNode *_monster2;
    
    SKSpriteNode *_transimtDoorNode;
    
    NSMutableDictionary *_monster1Dic;
    NSMutableDictionary *_monster2Dic;
    NSMutableDictionary *_sisterDic;
    
}


//Label
- (void)_createLabelNode
{
    _labelNodel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    _labelNodel.fontSize = 25.f;
    _labelNodel.position = CGPointMake(self.screenWidth / 2.0, self.screenHeight - 100);
    _labelNodel.zPosition = kZposition_player + 1;
    
    [self addChild:_labelNodel];
    
    
    SKSpriteNode *prompt = [SKSpriteNode spriteNodeWithImageNamed:@"抬起.png"];
    prompt.position = CGPointMake(0, 0);
    [_labelNodel addChild:prompt];
    
    
    SKTexture *p1 = [SKTexture textureWithImage:[UIImage imageNamed:@"抬起.png"]];
    SKTexture *p2 = [SKTexture textureWithImage:[UIImage imageNamed:@"按下.png"]];
    
    SKAction *promptAct = [SKAction animateWithTextures:@[p1,p2] timePerFrame:0.3];
    SKAction *repeatingAct = [SKAction repeatActionForever:promptAct];
    [prompt runAction:repeatingAct];
    
    [self showLabelNode:@"夜幕降临了...   A"];

}

//furnace
- (void)_createFurnace
{
    NSMutableArray *furnaces = [JYTool image:[UIImage imageNamed:@"火炉副本.png"] size:CGSizeMake(64, 96) line:4 arrange:3];
    _furnaces = [NSMutableArray arrayWithCapacity:furnaces.count];
    for (UIImage *pic in furnaces) {
        SKTexture *temp = [SKTexture textureWithImage:pic];
        [_furnaces addObject:temp];
    }
    
    NSMutableArray *actionArr = [NSMutableArray arrayWithCapacity:3];
    [actionArr addObject:_furnaces[2]];
    [actionArr addObject:_furnaces[5]];
    [actionArr addObject:_furnaces[8]];
    [actionArr addObject:_furnaces[11]];
    
    _furnaceNode = [SKSpriteNode spriteNodeWithTexture:_furnaces[2]];
    _furnaceNode.position = CGPointMake(self.screenWidth - 64 * 1.3 / 2.0, self.screenHeight - 96 * 1.3 / 2.0 + 10);
    _furnaceNode.zPosition = kZposition_player - 2;
    _furnaceNode.xScale = 1.3;
    _furnaceNode.yScale = 1.3;
    _furnaceNode.anchorPoint = CGPointMake(0.5, 0.5);
    [self addChild:_furnaceNode];
    
    SKAction *action = [SKAction animateWithTextures:actionArr timePerFrame:0.3];
    SKAction *repeating1 = [SKAction repeatActionForever:action];
    [_furnaceNode runAction:repeating1];
    
    
    SKPhysicsBody *furnaceBody = [self _physicsBody:64*1.3 height:96*1.3-85];
    _furnaceNode.physicsBody = furnaceBody;
    [self _setContact:_furnaceNode userData:[@{@"火炉":@(1)} mutableCopy]];
}

//monster
- (void)_createMonsterNode
{
    NSMutableArray *mon1 = [JYTool image:[UIImage imageNamed:@"坏哥布林.png"] size:CGSizeMake(39,43) line:4 arrange:4];
    NSMutableArray *mon2 = [JYTool image:[UIImage imageNamed:@"好哥布林.png"] size:CGSizeMake(39,43) line:4 arrange:4];
    
    _monster1Dic = [JYTool images:mon1 arrange:4 line:4];
    _monster2Dic = [JYTool images:mon2 arrange:4 line:4];

    _monster1 = [SKSpriteNode spriteNodeWithTexture:_monster1Dic[@"down"][0]];
    _monster1.position = CGPointMake(_furnaceNode.position.x, _furnaceNode.position.y - 25.f);
    _monster1.zPosition = kZposition_player;
    _monster1.alpha = 0;
    
    [self addChild:_monster1];
    SKPhysicsBody *bedBody = [self _physicsBody:39 height:43];
    bedBody.dynamic = YES;
    _monster1.physicsBody = bedBody;
    [self _setContact:_monster1 userData:[@{@"monster":@(1)} mutableCopy]];
    
    
    
    _monster2 = [SKSpriteNode spriteNodeWithTexture:_monster2Dic[@"down"][0]];
    _monster2.position = CGPointMake(_furnaceNode.position.x, _furnaceNode.position.y - 25.f);
    _monster2.zPosition = kZposition_player;
    _monster2.alpha = 0;
    
    [self addChild:_monster2];
    
    SKPhysicsBody *bedBody2 = [self _physicsBody:39 height:43];
    bedBody2.dynamic = YES;
    _monster2.physicsBody = bedBody2;
    [self _setContact:_monster2 userData:[@{@"monster2":@(1)} mutableCopy]];
    

}

- (void)_createSister
{
    NSMutableArray *sisters = [JYTool image:[UIImage imageNamed:@"player1.png"] size:CGSizeMake(32, 32) line:4 arrange:3];
    _sisterDic = [JYTool images:sisters arrange:3 line:4];
    
    _sister = [SKSpriteNode spriteNodeWithTexture:_sisterDic[@"right"][0]];
    _sister.position = CGPointMake(self.player.position.x - 10 - 32, self.player.position.y);
    _sister.zPosition = kZposition_player;
    
 
    
    [self addChild:_sister];
    
    SKPhysicsBody *bedBody = [self _physicsBody:32 height:32];
    bedBody.dynamic = NO;
    _sister.physicsBody = bedBody;
    [self _setContact:_sister userData:[@{@"sister":@(1)} mutableCopy]];
    

}


//中间触发剧情的墙
- (void)_createAlphaNode:(NSString *)key
{
    //隐形触发剧情墙
    SKSpriteNode *alphaNode = [SKSpriteNode spriteNodeWithImageNamed:@"红砖墙.jpg"];
    alphaNode.size = CGSizeMake(50, self.screenHeight - 500);
    alphaNode.position = CGPointMake(self.screenWidth / 2.0, self.screenHeight / 2.0);
    NSLog(@"%lf",self.screenHeight);
    NSLog(@"%lf",kScreenHeight);
    SKPhysicsBody *alphaBody = [self _physicsBody:50 height:fabs(self.screenHeight - 500)];
    alphaNode.physicsBody = alphaBody;
    alphaNode.zPosition = kZposition_player - 1;
    alphaNode.alpha = 0;
    [self addChild:alphaNode];
    
    [self _setContact:alphaNode userData:[@{key:@(1)} mutableCopy]];

}

- (void)_createTransmitDoor
{
 
    _transimtDoors = [NSMutableArray array];
    
    for (int i = 1; i < 9; i++) {
        NSString *picName = [NSString stringWithFormat:@"传送门%d.jpg",i];
        SKTexture *texture = [SKTexture textureWithImage:[UIImage imageNamed:picName]];
        [_transimtDoors addObject:texture];
    }
    
    _transimtDoorNode = [SKSpriteNode spriteNodeWithImageNamed:@"传送门.png"];
    
    _transimtDoorNode.position = CGPointMake(_furnaceNode.position.x, _furnaceNode.position.y - 35);
    _transimtDoorNode.zPosition = kZposition_player - 1;
    _transimtDoorNode.xScale = 0.15;
    _transimtDoorNode.yScale = 0.15;
    _transimtDoorNode.alpha  = 0;
    [self addChild:_transimtDoorNode];
    
    SKAction *action = [SKAction rotateByAngle:2 * M_PI duration:2.0];
    SKAction *rep = [SKAction repeatActionForever:action];
    
    [_transimtDoorNode runAction:rep];
    
}

- (void)didMoveToView:(SKView *)view
{
    self.physicsWorld.contactDelegate = self;

    [self setFrame];
    
    //设置主角
    [self setPlayerType:@"left"];
    [self addChild:self.player];
   
    self.player.physicsBody.categoryBitMask = player_type;
    self.player.physicsBody.contactTestBitMask = objc_type;
    self.player.physicsBody.collisionBitMask = objc_type;
    

    
    //创建火炉
    [self _createFurnace];
    
    //创建小怪兽
    [self _createMonsterNode];
    
    //创建莉娜
    [self _createSister];
    
    //文字
    [self _createLabelNode];
    
    
    //墙壁
    for (int i = 0; i < 4; i ++) {
        SKPhysicsBody *body;
        SKSpriteNode *node = [SKSpriteNode spriteNodeWithImageNamed:@"红砖墙.jpg"];
        if (i == 0) {
            node.position = CGPointMake(self.screenWidth / 2.0, self.screenHeight);
        }else if(i == 1){
            node.position = CGPointMake(self.screenWidth / 2.0, 0);
        }else if(i == 2){
            node.position = CGPointMake(0, self.screenHeight / 2.0);
        }else {
            node.position = CGPointMake(self.screenWidth, self.screenHeight / 2.0);
        }
        
        if (i < 2) {
            body = [self _physicsBody:self.screenWidth height:15];
//            node.xScale = 0.2;
//            node.yScale = 0.15;
            node.size = CGSizeMake(self.screenWidth, 15);
        }else{
            body = [self _physicsBody:15 height:self.screenHeight];
//            node.xScale = 0.2;
//            node.yScale = 0.15;
            node.size = CGSizeMake(15, self.screenHeight);
        }
        
        node.physicsBody = body;
        node.zPosition = kZposition_player-2;
        [self addChild:node];
    }
    
    /*
    SKTexture *tempTexture = [SKTexture textureWithImage:[UIImage imageNamed:@"墙.png"]];
    for (int i = 0; i < 92; i++) {
        SKSpriteNode *node = [SKSpriteNode spriteNodeWithTexture:tempTexture];
        if (i < 46) {
            node.position = CGPointMake(i * 15, self.screenHeight);
        }else{
            node.position = CGPointMake((i-46)*15,0);
        }
        
        SKPhysicsBody *body = [self _physicsBody:15 height:30];
        node.physicsBody = body;
        node.zPosition = kZposition_player-2;
        node.xScale = 0.5;
        node.yScale = 0.5;
        [self addChild:node];
    }
    
    for (int i = 0; i < 50; i++) {
        SKSpriteNode *node = [SKSpriteNode spriteNodeWithTexture:tempTexture];
        if (i< 25) {
            node.position = CGPointMake(0, i * 15);
        }else{
            node.position = CGPointMake(self.screenWidth , (i-25) * 15);
        }
        
        SKPhysicsBody *body = [self _physicsBody:15 height:30];
        node.physicsBody = body;
        node.zPosition = kZposition_player-2;
        node.xScale = 0.5;
        node.yScale = 0.5;
        [self addChild:node];
    }
    */
    
    //地板
    SKTexture *floorTexture = [SKTexture textureWithImage:[UIImage imageNamed:@"地板.png"]];
    for (int i = 0; i < 84; i++) {
        
        int x = (i % 12) * 64;
        int y = (i / 12) * 64;
        
        SKSpriteNode *floorNode = [SKSpriteNode spriteNodeWithTexture:floorTexture];
        floorNode.position = CGPointMake(x, y);
        floorNode.zPosition = kZposition_ground;
        [self addChild:floorNode];
    }
    
 
    //抽屉
    SKTexture *drawerTexture = [SKTexture textureWithImage:[UIImage imageNamed:@"抽屉.png"]];
    SKSpriteNode *drawerNode = [SKSpriteNode spriteNodeWithTexture:drawerTexture];
    drawerNode.position = CGPointMake(50, self.screenHeight - 30);
    drawerNode.yScale = 2.0;
    drawerNode.xScale = 1.5;
    drawerNode.zPosition = kZposition_player - 1;
    [self addChild:drawerNode];
    
    SKPhysicsBody *drawerBody = [self _physicsBody:58 * 1.5 height:52 * 1.5 - 30];
    drawerNode.physicsBody = drawerBody;
    [self _setContact:drawerNode userData:[@{@"桌子":@(1)} mutableCopy]];
    
    
    //桌子
    SKTexture *deskTexture = [SKTexture textureWithImage:[UIImage imageNamed:@"桌子1.png"]];
    SKSpriteNode *deskNode = [SKSpriteNode spriteNodeWithTexture:deskTexture];
    deskNode.position = CGPointMake(self.screenWidth / 2.0 + 180, self.screenHeight / 2.0 - 70);
    deskNode.xScale = 1.3;
    deskNode.yScale = 1.3;
    deskNode.zPosition = kZposition_player - 1;
    [self addChild:deskNode];
    
    
    SKPhysicsBody *deskBody = [self _physicsBody:96 * 1.3 height:96 * 1.3];
    deskNode.physicsBody = deskBody;
    
   
    //床
    SKTexture *bedTexture = [SKTexture textureWithImage:[UIImage imageNamed:@"床1.png"]];
    SKSpriteNode *bed = [SKSpriteNode spriteNodeWithTexture:bedTexture];
    bed.position = CGPointMake(80, self.screenHeight / 2.0 - 70);
    bed.xScale = 1.3;
    bed.yScale = 1.3;
    bed.zPosition = kZposition_player - 1;
    [self addChild:bed];
    
    SKPhysicsBody *bedBody = [self _physicsBody:33 * 1.3 height:70 * 1.3];
    bed.physicsBody = bedBody;
    [self _setContact:bed userData:[@{@"床":@(1)} mutableCopy]];
    
    
    //床2
    SKTexture *bedTexture2 = [SKTexture textureWithImage:[UIImage imageNamed:@"床1.png"]];
    SKSpriteNode *bed2 = [SKSpriteNode spriteNodeWithTexture:bedTexture2];
    bed2.position = CGPointMake(80 + 80 + 1.3 * 33, self.screenHeight / 2.0 - 70);
    bed2.xScale = 1.3;
    bed2.yScale = 1.3;
    bed2.zPosition = kZposition_player - 1;
    [self addChild:bed2];
    
    SKPhysicsBody *bedBody2 = [self _physicsBody:33 * 1.3 height:70 * 1.3];
    bed2.physicsBody = bedBody2;
    [self _setContact:bed2 userData:[@{@"床":@(1)} mutableCopy]];

   
    //上边挡墙
    SKTexture *wallText = [SKTexture textureWithImage:[UIImage imageNamed:@"墙.png"]];
    SKSpriteNode *wallTop = [SKSpriteNode spriteNodeWithTexture:wallText];
    wallTop.position = CGPointMake(self.screenWidth / 2.0, self.screenHeight - (self.screenHeight - 250) / 2.0);
    wallTop.size = CGSizeMake(50, self.screenHeight - 250);
    
    wallTop.zPosition = kZposition_player - 1;
    [self addChild:wallTop];
    
    SKPhysicsBody *wallBody = [self _physicsBody:50 height:(self.screenHeight - 250)];
    wallTop.physicsBody = wallBody;
    [self _setContact:wallTop userData:[@{@"g ":@(1)} mutableCopy]];

    
    //下边的挡墙
    SKTexture *wallText2 = [SKTexture textureWithImage:[UIImage imageNamed:@"墙.png"]];
    SKSpriteNode *wallBottom = [SKSpriteNode spriteNodeWithTexture:wallText2];
    wallBottom.position = CGPointMake(self.screenWidth / 2.0, (self.screenHeight - 250) / 2.0);
    wallBottom.size = CGSizeMake(50, self.screenHeight - 250);
    
    wallBottom.zPosition = kZposition_player - 1;
    [self addChild:wallBottom];
    
    SKPhysicsBody *wallBody2 = [self _physicsBody:50 height:(self.screenHeight - 250) ];
    wallBottom.physicsBody = wallBody2;
    [self _setContact:wallBottom userData:[@{@"g ":@(1)} mutableCopy]];

    
    //隐形墙
    [self _createAlphaNode:@"隐形墙"];
    
    //传送门
    [self _createTransmitDoor];
}

//设置与玩家的碰撞属性
- (void)_setContact:(SKSpriteNode *)node userData:(NSMutableDictionary *)data;
{
    node.physicsBody.categoryBitMask = objc_type;
    node.physicsBody.contactTestBitMask = player_type;
    node.physicsBody.collisionBitMask = player_type;
    node.userData = data;

}

//设置物理属性
- (SKPhysicsBody *)_physicsBody:(CGFloat )width height:(CGFloat )height
{
    SKPhysicsBody *body = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(width, height)];
    body.affectedByGravity = NO;
    body.allowsRotation = NO;
    body.dynamic = NO;
    return body;
}


#pragma mark -触碰方法
//触碰开始
- (void)didBeginContact:(SKPhysicsContact *)contact
{
    
    //SKSpriteNode * A = (SKSpriteNode *)contact.bodyA.node;
    SKSpriteNode * B = (SKSpriteNode *)contact.bodyB.node;
 
 
    if ([[B.userData objectForKey:@"桌子"]intValue] == 1) {
        _isContactDrawer1 = YES;
    }
    
    if ([[B.userData objectForKey:@"床"]intValue] == 1) {
        _isContactBed = YES;
    }
    
    if ([[B.userData objectForKey:@"火炉"]intValue]==1) {
        _isContactFurnace = YES;
        
   //进入第二幕，大树国
        if (_isNextScene) {
            BLOCK_EXEC(self.beginOrEndGameBlock,NO);
            BLOCK_EXEC(self.beginOrEndOperateBlock,NO);
            
            [self performSelector:@selector(changeScene) withObject:nil afterDelay:1];
          
    
        }
    }
    
    if ([[B.userData objectForKey:@"隐形墙"]intValue] == 1) {
        
        BLOCK_EXEC(self.beginOrEndGameBlock,NO);
        BLOCK_EXEC(self.beginOrEndOperateBlock,NO);
        NSString *str = [NSString stringWithFormat:@"你是%@ ?找的不是你!   A",self.model.name];
        [self mosterCome:B isFirstMonster:YES str:str];
        _isMonsterEndSay = YES;
        
    }
    
    if ([[B.userData objectForKey:@"隐形墙2"]intValue] == 1) {
        
        BLOCK_EXEC(self.beginOrEndGameBlock,NO)
        BLOCK_EXEC(self.beginOrEndOperateBlock,NO);
    
        NSLog(@"好的小怪兽该出现了哦");
        NSString *str = [NSString stringWithFormat:@"莉娜呢!? 被抓走了吗?%@,跟我来   A",self.model.name];
        [self mosterCome:B isFirstMonster:NO str:str];
        _isMonsterEndSay2 = YES;

    }

    
    if ([[B.userData objectForKey:@"sister"]intValue] == 1) {
        _isSister = YES;
    }
    
    //被怪兽撞飞的动画
    if ([[B.userData objectForKey:@"monster"]intValue] == 1) {
        
        self.player.texture = self.dic_player[@"down"][0];
        
        SKAction *moveAction = [SKAction moveTo:CGPointMake(self.screenWidth / 2.0 - 100, self.screenHeight / 2.0 - 100) duration:2.0];
        SKAction *revolveA = [SKAction rotateByAngle:4 * M_PI duration:2.0];
        
        SKAction *gr = [SKAction group:@[moveAction,revolveA]];
        
        [self.player runAction:gr];
    }
    
    
}

- (void)changeScene{
 
    SKAction *alphaAction = [SKAction fadeAlphaTo:0 duration:3];
    [self.player runAction:alphaAction completion:^{
        //[self removeAllChildren];
       JYIncubateScene *scene = [[JYIncubateScene alloc] initWithSize:CGSizeMake(kScreenWidth, kScreenHeight)];
        scene.scaleMode = SKSceneScaleModeAspectFill;
        
        scene.model = self.model;
        SKTransition *tra = [SKTransition fadeWithDuration:2];
        BLOCK_EXEC(self.presentSceneBlock,scene,tra,CGPointMake(390, self.screenHeight - self.player.size.height - 45),self.dic_player[@"down"][0]);
    }];
}


//触碰结束
- (void)didEndContact:(SKPhysicsContact *)contact
{
    //SKSpriteNode * A = (SKSpriteNode *)contact.bodyA.node;
    SKSpriteNode * B = (SKSpriteNode *)contact.bodyB.node;
  

  
    if ([[B.userData objectForKey:@"桌子"]intValue] == 1) {
        _isContactDrawer1 = NO;
        NSLog(@"B碰撞结束了");
        _labelNodel.hidden = YES;
    }
    
    if ([[B.userData objectForKey:@"床"]intValue] == 1) {
        _isContactBed = NO;
        _labelNodel.hidden = YES;
    }

    
    if ([[B.userData objectForKey:@"火炉"]intValue]==1) {
        _isContactFurnace = NO;
        _labelNodel.hidden = YES;
    }
    
    if ([[B.userData objectForKey:@"sister"]intValue]==1) {
        _isSister = NO;
        [self cancel];
    }
  
}

#pragma mark -按钮A方法
//A
- (void)confirm
{
    //怪兽对话结束
    if (_isMonsterEndSay) {
       
        _sister.physicsBody.dynamic = YES;

        SKAction *moveAction = [SKAction moveTo:CGPointMake(self.screenWidth / 2.0 - 200, self.screenHeight / 2.0) duration:0.9];
        SKAction *moveText   = [SKAction animateWithTextures:_monster1Dic[@"left"] timePerFrame:0.3];
        SKAction *groupACT = [SKAction group:@[moveAction,moveText]];
        
        [_monster1 runAction:groupACT completion:^{
            
            //链接俩个node
            SKPhysicsJointPin *joint = [SKPhysicsJointPin jointWithBodyA:_monster1.physicsBody bodyB:_sister.physicsBody anchor:CGPointMake((_monster1.size.width + _sister.size.width) / 2.0, _monster1.size.height / 2.0)];
            [_monster1.scene.physicsWorld addJoint:joint];
            
            SKAction *moveAction = [SKAction moveTo:CGPointMake(_furnaceNode.position.x + 30, _furnaceNode.position.y - 25.f) duration:3];
            SKAction *moveText   = [SKAction animateWithTextures:_monster1Dic[@"right"] timePerFrame:0.3];
            SKAction *rep = [SKAction repeatAction:moveText count:2];
            SKAction *gr = [SKAction group:@[moveAction,rep]];
            
            SKAction *sisterAction = [SKAction animateWithTextures:_sisterDic[@"down"] timePerFrame:0.3];
            SKAction *rep1 = [SKAction repeatAction:sisterAction count:3];
            
            
            
            [_monster1 runAction:gr completion:^{
                
                _monster1.texture = _monster1Dic[@"down"][0];
                [_monster1.scene.physicsWorld removeAllJoints];
                
                SKAction *groupAlphaACT = [SKAction fadeAlphaTo:0 duration:3];
                [_transimtDoorNode runAction:groupAlphaACT];
                
                
                [_monster1 runAction:groupAlphaACT completion:^{
                    
                    NSArray *arr = @[_furnaces[0],_furnaces[3],_furnaces[6],_furnaces[9],_furnaces[10],_furnaces[11]];
                    NSArray *actionArr = @[_furnaces[2],_furnaces[5],_furnaces[8],_furnaces[11]];
                    
                    SKAction *textAction = [SKAction animateWithTextures:arr timePerFrame:0.3];
                 
                    SKAction *action = [SKAction animateWithTextures:actionArr timePerFrame:0.3];
                    SKAction *repeating1 = [SKAction repeatActionForever:action];
                    
                    SKAction *seq = [SKAction sequence:@[textAction,repeating1]];
                    
                    [_furnaceNode runAction:seq completion:^{
                  
                    }];
                    
                    [_monster1 removeFromParent];
                    BLOCK_EXEC(self.beginOrEndGameBlock,YES)
                    [self _createAlphaNode:@"隐形墙2"];
          
                }];
                
            }];
            
            [_sister runAction:rep1 completion:^{
                
                SKAction *groupAlphaACT = [SKAction fadeAlphaTo:0 duration:3];
                
                [_sister runAction:groupAlphaACT completion:^{
                    [_sister removeFromParent];
                }];
            }];
            
        }];
    
        _isMonsterEndSay = NO;
        _labelNodel.hidden = YES;
        _isGrab = YES;
        
        return;
    }
    
    //第二只怪兽对话结束
    if (_isMonsterEndSay2) {
        
        SKAction *moveAction = [SKAction moveTo:CGPointMake(_furnaceNode.position.x, _furnaceNode.position.y - 25.f) duration:1.5];
        SKAction *moveText   = [SKAction animateWithTextures:_monster2Dic[@"right"] timePerFrame:0.3];
        SKAction *rep = [SKAction repeatAction:moveText count:2];
        SKAction *gr = [SKAction group:@[moveAction,rep]];

        [_monster2 runAction:gr completion:^{
            
            _monster2.texture = _monster2Dic[@"down"][0];
            
            SKAction *groupAlphaACT = [JYTool revolveAction:_monster2Dic time:3 hideOrAppear:YES count:5 timePerFrame:0.15];
            
            [_monster2 runAction:groupAlphaACT completion:^{
                BLOCK_EXEC(self.beginOrEndGameBlock,YES);
                [_monster2 removeFromParent];
                _isMonsterEndSay2 = NO;
                _isNextScene = YES;
            }];

        }];
        
        NSLog(@"第二只小怪兽对话结束了");
    }
    
    //触碰衣橱
    if (_isContactDrawer1) {
        [self showLabelNode:@"这里只有衣服.  B"];
        return;
    }
    
    //触碰床
    if (_isContactBed) {
        
        if (_isGrab) {
            [self showLabelNode:@"莉娜被抓走了,去查看火炉.  B"];
        }else{
            [self showLabelNode:@"睡不着啊!  B"];
        }
        return;
    }
    
    //触碰火炉
    if (_isContactFurnace) {
        [self showLabelNode:@"确定出发? A.确定 B.检查遗漏物品"];
        return;
    }
    
    if (_isSister) {
        [self showLabelNode:@"莉娜:还不睡觉，一会怪兽来抓你!  B"];
        return;
    }
   
    //开始对话
    if (_next == 0) {
        [self showLabelNode:@"莉娜:妈妈说要早点睡觉!   A"];
    }else if(_next == 1){
        NSString *str = [NSString stringWithFormat:@"莉娜:否则会被怪兽抓住哦%@!   A",self.model.name];
        [self showLabelNode:str];
    }else{
        
        //结束对话后可以移动，移动到中间部分触发场景动画
        [self cancel];
        BLOCK_EXEC(self.beginOrEndGameBlock,YES)
        
        _time = 3;
    }
    _next ++;
    
}


#pragma mark -按钮B方法
//B
- (void)cancel
{
    _labelNodel.hidden = YES;
}

//怪兽飞来的动画
- (void)mosterCome:(SKSpriteNode *)node
    isFirstMonster:(BOOL)isFirstMonster
               str:(NSString *)str
{
    if (_time == 3) {
        
        [_furnaceNode removeAllActions];
        
        NSMutableArray *actionArr = [NSMutableArray arrayWithCapacity:5];
        [actionArr addObject:_furnaces[2]];
        [actionArr addObject:_furnaces[5]];
        [actionArr addObject:_furnaces[8]];
        [actionArr addObject:_furnaces[11]];
        [actionArr addObject:_furnaces[10]];
        [actionArr addObject:_furnaces[9]];
        [actionArr addObject:_furnaces[6]];
        [actionArr addObject:_furnaces[3]];
        [actionArr addObject:_furnaces[0]];
        __weak typeof(self) weekSelf = self;
    
        SKAction *act = [SKAction animateWithTextures:actionArr timePerFrame:0.3];
        [_furnaceNode runAction:act completion:^{
            
            
            NSLog(@"结束");
            NSMutableDictionary *dic;
            SKSpriteNode        *monsterNode;
            
            isFirstMonster ? (dic = _monster1Dic) : (dic = _monster2Dic);
            isFirstMonster ? (monsterNode = _monster1) : (monsterNode = _monster2);
            
            
            SKAction *groupAlphaACT = [SKAction fadeAlphaTo:1 duration:3];
           
            SKAction *moveAction = [SKAction moveTo:CGPointMake(self.screenWidth / 2.0, self.screenHeight / 2.0) duration:2.7];
            SKAction *textureACT = [SKAction animateWithTextures:dic[@"left"] timePerFrame:0.3];
            SKAction *repeatACT = [SKAction repeatAction:textureACT count:3.0];
            
            
            SKAction *moveGroupACT = [SKAction group:@[repeatACT,moveAction]];
            SKAction *sequence = [SKAction sequence:@[groupAlphaACT,moveGroupACT]];
            
            SKAction *alphaACT = [SKAction fadeAlphaTo:1 duration:3];
            
            [_transimtDoorNode runAction:alphaACT];
            
            [monsterNode runAction:sequence completion:^{
                
                
                [weekSelf showLabelNode:str];
                BLOCK_EXEC(self.beginOrEndOperateBlock,YES);
                
                [node removeFromParent];
                
            }];

        }];
        
        
    }
}


//显示Label
- (void)showLabelNode:(NSString *)text
{
    _labelNodel.zPosition = kZposition_player + 100;
    _labelNodel.hidden = NO;
    _labelNodel.text = text;
    SKSpriteNode *prompt = (SKSpriteNode *)_labelNodel.children[0];
    prompt.position = CGPointMake(text.length /2.0 * 30 - 10, 10);
    
}


#pragma mark 操作
- (void)operation:(JYStartGame *)operation
{
     
}



@end
