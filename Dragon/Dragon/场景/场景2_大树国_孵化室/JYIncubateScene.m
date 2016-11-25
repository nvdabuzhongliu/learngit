//
//  JYIncubateScene.m
//  ddd
//
//  Created by 吴冬 on 16/9/1.
//  Copyright © 2016年 北京金源互动科技有限公司. All rights reserved.
//


const float z_shrimp = 2;
const float z_npc1   = 2;

@implementation JYIncubateScene

{
   
    BOOL    _contactBookShelf;
    BOOL    _contactShrimp;
    BOOL    _contactChair;
    BOOL    _contactNpc1;
    BOOL    _contactDoor;
    
    CGPoint _centerPoint;
    
    SKSpriteNode *_shrimp;
    SKSpriteNode *_npc1;
    SKSpriteNode *_chairAndDesk;
    SKSpriteNode *_bookShelf;
    SKSpriteNode *_door;
    
    
    
}

- (void)dealloc
{
    NSLog(@"1122");
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
    [self _setBg:[UIImage imageNamed:@"孵化室背景.png"]];
    
    _centerPoint = CGPointMake(self.screenWidth / 2.0, self.screenHeight / 2.0);
    
    
    //设置主角
    [self setPlayerType:@"left"];
    [self addChild:self.player];
 
    //四周的墙
    [self _createWall];
    
    //设置大虾
    [self _createShrimp];
    //npc1
    [self _createNpc];
    //桌椅
    [self _createDeskAndChair];
    //书架
    [self _createBookShelf];
    //门
    [self _createDoor];
    //按键提示
    [self createPromptNode];
    //切换scene
    [self nextSceneNode];
    
    [self setMonsterWithSuperSence:self];

    
}

#pragma mark 创建Node
//虾
- (void)_createShrimp
{
    
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:3];
    for (int i = 1;i < 6 ; i++) {
        
        NSString *name ;
        
        if (i == 4) {
            name = @"虾2";
        }else if(i == 5){
            name = @"虾1";
        }else{
            name = [NSString stringWithFormat:@"虾%d",i];
            
        }
        
        SKTexture *texture = [SKTexture textureWithImage:[UIImage imageNamed:name]];
        [arr addObject:texture];
        
    }
    
    
    _shrimp = [SKSpriteNode spriteNodeWithImageNamed:@"虾1.png"];
    _shrimp.anchorPoint = CGPointMake(0, 0);
    _shrimp.position = CGPointMake(110, self.screenHeight - _shrimp.size.height - 30);
    _shrimp.zPosition = z_shrimp;
    
    [self addChild:_shrimp];
    
    NSArray *arr1 = @[arr[0],arr[1],arr[2]];
    NSArray *arr2 = @[arr[3],arr[4]];
    
    SKAction *action1 = [SKAction animateWithTextures:arr1 timePerFrame:0.1];
    SKAction *wait1 = [SKAction waitForDuration:0.5];
    SKAction *action2 = [SKAction animateWithTextures:arr2 timePerFrame:0.15];
    SKAction *time = [SKAction waitForDuration:2.0];
    
    SKAction *seq = [SKAction sequence:@[action1,wait1,action2,time]];
    SKAction *rep = [SKAction repeatActionForever:seq];
    
    [_shrimp runAction:rep];
    
    
    SKPhysicsBody *body = [self _physicsBody:_shrimp.size.width height:_shrimp.size.height -10 x:0 y:10];
    _shrimp.physicsBody = body;
    [self _setContact:_shrimp userData:[@{@"_shrimp":@(1)} mutableCopy]];
    
}


//孵化室npc1
- (void)_createNpc
{
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:2];
    for (int i = 1;i < 3 ; i++) {
        NSString *name = [NSString stringWithFormat:@"孵化室_npc%d",i];
        SKTexture *texture = [SKTexture textureWithImage:[UIImage imageNamed:name]];
        [arr addObject:texture];
        
    }
    
    _npc1 = [SKSpriteNode spriteNodeWithImageNamed:@"孵化室_npc1.png"];
    _npc1.zPosition = z_npc1;
    _npc1.position = CGPointMake(455.5, self.screenHeight- 240 - _npc1.size.height);
    _npc1.anchorPoint = CGPointMake(0, 0);
    
    SKAction *moveAction = [SKAction animateWithTextures:arr timePerFrame:0.5];
    SKAction *rep = [SKAction repeatActionForever:moveAction];
    
    [self addChild:_npc1];
    [_npc1 runAction:rep];
    
    SKPhysicsBody *body = [self _physicsBody:_npc1.size.width height:_npc1.size.height x:0 y:0];
    _npc1.physicsBody = body;
    [self _setContact:_npc1 userData:[@{@"npc1":@(1)} mutableCopy]];
    
    
}

//桌椅
- (void)_createDeskAndChair
{
    _chairAndDesk = [SKSpriteNode spriteNodeWithImageNamed:@"孵化室_桌椅.png"];
    _chairAndDesk.zPosition = z_npc1;
    _chairAndDesk.position = CGPointMake(412.5, self.screenHeight - 191 - _chairAndDesk.size.height);
    _chairAndDesk.anchorPoint = CGPointMake(0, 0);
    
    [self addChild:_chairAndDesk];
    
    SKPhysicsBody *body = [self _physicsBody:_chairAndDesk.size.width height:_chairAndDesk.size.height x:0 y:0];
    _chairAndDesk.physicsBody = body;
    [self _setContact:_chairAndDesk userData:[@{@"desk":@(1)} mutableCopy]];
    
}

//墙
- (void)_createWall
{
    SKSpriteNode *topWall = [SKSpriteNode node];
    topWall.position = CGPointMake(0, self.screenHeight - 45);
    topWall.size = CGSizeMake(self.screenWidth, 45.0);
    
    SKPhysicsBody *body = [self _physicsBody:self.screenWidth height:45 - 10 x:0 y:10];
    topWall.physicsBody = body;
    [self _setContact:topWall userData:[@{@"topWall":@(1)} mutableCopy]];
    
    
    SKSpriteNode *leftWall = [SKSpriteNode node];
    leftWall.position = CGPointMake(0, 24);
    leftWall.size = CGSizeMake(24, self.screenHeight);
    
    SKPhysicsBody *body1 = [self _physicsBody:24 height:self.screenHeight x:0 y:0];
    leftWall.physicsBody = body1;
    [self _setContact:leftWall userData:[@{@"leftWall":@(1)} mutableCopy]];
    
    
    SKSpriteNode *bottomWall1 = [SKSpriteNode node];
    bottomWall1.position = CGPointMake(0, 0);
    bottomWall1.size = CGSizeMake(self.screenWidth, 20);
    
    SKPhysicsBody *body2 = [self _physicsBody:300 height:20 x:0 y:0];
    bottomWall1.physicsBody = body2;
    [self _setContact:bottomWall1 userData:[@{@"bottomWall1":@(1)} mutableCopy]];
    
    
    SKSpriteNode *bottomWall2 = [SKSpriteNode node];
    bottomWall2.position = CGPointMake(370, 0);
    bottomWall2.size = CGSizeMake(self.screenWidth, 20);
    
    SKPhysicsBody *body3 = [self _physicsBody:300 height:20 x:0 y:0];
    bottomWall2.physicsBody = body3;
    [self _setContact:bottomWall2 userData:[@{@"bottomWall2":@(1)} mutableCopy]];

    SKSpriteNode *rightWall = [SKSpriteNode node];
    rightWall.position = CGPointMake(self.screenWidth - 24, 0);
    rightWall.size = CGSizeMake(24, self.screenHeight);
    
    SKPhysicsBody *body4 = [self _physicsBody:24 height:self.screenHeight x:0 y:0];
    rightWall.physicsBody = body4;
    [self _setContact:rightWall userData:[@{@"rightWall":@(1)} mutableCopy]];
    
    
    
    
    
    [self addChild:topWall];
    [self addChild:leftWall];
    [self addChild:bottomWall1];
    [self addChild:bottomWall2];
    [self addChild:rightWall];
}

//书架
- (void)_createBookShelf
{
    _bookShelf = [SKSpriteNode node];
    _bookShelf.anchorPoint = CGPointMake(0, 0);
    _bookShelf.position = CGPointMake(545, self.screenHeight - 80);
    _bookShelf.size = CGSizeMake(100, 80);
    
    SKPhysicsBody *body = [self _physicsBody:100 height:80 x:0 y:20];
    _bookShelf.physicsBody = body;
    [self _setContact:_bookShelf userData:[@{@"_bookShelf":@(1)}mutableCopy]];
    
    [self addChild:_bookShelf];
}

//创建门
- (void)_createDoor
{
    _door = [SKSpriteNode node];
    _door.position = CGPointMake(390, self.screenHeight - 45);
    _door.anchorPoint = CGPointMake(0, 0);
    
    _door.size = CGSizeMake(40, 45);
    
    SKPhysicsBody *body = [self _physicsBody:40 height:45 x:0 y:10];
    _door.physicsBody = body;
    [self _setContact:_door userData:[@{@"_door":@(1)}mutableCopy]];
    
    [self addChild:_door];

    
}



- (void)nextSceneNode
{
    SKSpriteNode *node = [SKSpriteNode node];
    node.position = CGPointMake(self.screenWidth / 2.0,0);
    node.size = CGSizeMake(70, 10);
    
    node.anchorPoint = CGPointMake(0, 0);
   
    SKPhysicsBody *body = [self _physicsBody:70 height:1 x:0 y:0];
    node.physicsBody = body;
    [self _setContact:node userData:[@{kSence_incubate2:@(1)}mutableCopy]];
    
    [self addChild:node];
    
}




#pragma mark 碰撞检测
- (void)didBeginContact:(SKPhysicsContact *)contact
{
    SKSpriteNode * A = (SKSpriteNode *)contact.bodyA.node;
    
    if ([A.userData objectForKey:@"_bookShelf"])
    {
        NSLog(@"碰撞到书架了");
        _contactBookShelf = YES;
        [self showConfirmPrompt:@"" hidden:YES frame:CGRectZero];
    }
    else if ([A.userData objectForKey:@"npc1"])
    {
        NSLog(@"触碰NPC1了");
        _contactNpc1 = YES;
        [self showConfirmPrompt:@"" hidden:YES frame:CGRectZero];

    }
    else if ([A.userData objectForKey:@"_shrimp"])
    {
        NSLog(@"触碰大虾了");
        _contactShrimp = YES;
        [self showConfirmPrompt:@"" hidden:YES frame:CGRectZero];

    }
    else if ([A.userData objectForKey:@"_door"])
    {
        NSLog(@"触碰门了");
        _contactDoor = YES;
        [self showConfirmPrompt:@"" hidden:YES frame:CGRectZero];

    }
    else if ([A.userData objectForKey:kSence_incubate2])
    {
        NSLog(@"切换视图了需要");
        
        [self presentSceneWithPosition:CGPointMake(self.screenWidth / 2.0, self.screenHeight - self.player.size.height / 2.0 - 10)scenePosition:CGPointMake(0, 0)  texture:self.dic_player[@"down"][0] key:kSence_incubate2 tra:nil];
    }

}



- (void)didEndContact:(SKPhysicsContact *)contact
{
    _contactBookShelf = NO;
    _contactShrimp = NO;
    _contactNpc1 = NO;
    _contactDoor = NO;
    [self cancel];
}

#pragma mark 操作方法
- (void)confirm
{
    
    self.confirmPrompt.hidden = YES;
    
    
    if (_contactBookShelf)
    {
        [self showCancelPrompt:@"有关交配的书籍,请到图书馆查阅" hidden:NO frame:CGRectZero];
    }
    else if(_contactShrimp)
    {
        [self showCancelPrompt:@"我是大虾，虾米的虾" hidden:NO frame:CGRectZero];
    }
    else if(_contactNpc1)
    {
        [self showCancelPrompt:@"那个大虾是个傻子哦" hidden:NO frame:CGRectZero];
    }
    else if(_contactDoor)
    {
        [self showCancelPrompt:@"锁住了" hidden:NO frame:CGRectZero];
    }
}

- (void)cancel
{
    self.cancelPrompt.hidden = YES;
    self.confirmPrompt.hidden = YES;
    
    [self showCancelPrompt:@"" hidden:YES frame:CGRectZero];

}



@end
