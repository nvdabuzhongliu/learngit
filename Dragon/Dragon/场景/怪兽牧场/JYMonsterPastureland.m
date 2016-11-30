//
//  JYMonsterPastureland.m
//  Dragon
//
//  Created by 吴冬 on 16/9/22.
//  Copyright © 2016年 北京金源互动科技有限公司. All rights reserved.
//


@implementation JYMonsterPastureland

{
    SKSpriteNode *_pastureLandBg;
   
    //鬃毛怪兽
    SKSpriteNode *_monster1;
    NSMutableDictionary *_monster1Dic;
    BOOL _isTouchMonster1;
    
    //蝙蝠怪兽
    SKSpriteNode *_monster2;
    NSMutableDictionary *_monster2Dic;
    BOOL _isTouchMonster2;
    
    //牧场管家
    SKSpriteNode *_pasturelandManager;
    NSMutableDictionary *_pasturelandDic;
    BOOL _isTouchPastureland;
    int  _textNumber;
}

- (void)didMoveToView:(SKView *)view
{
   
    if ([self initWithCreateKey]) {
        
        [self _createNodes];
    }
    
    [self changePlayerPosition];
    _pastureLandBg.position = CGPointMake(-kScreenWidth, 0);
}

- (void)_setBg:(UIImage *)bgImage
{
    SKTexture *t = [SKTexture textureWithImage:bgImage];
    
    _pastureLandBg = [SKSpriteNode spriteNodeWithTexture:t];
    
    _pastureLandBg.position = CGPointMake(-kScreenWidth, 0);
    _pastureLandBg.anchorPoint = CGPointMake(0, 0);
    _pastureLandBg.zPosition = kZposition_player - 5;
    
    [self addChild:_pastureLandBg];

}

- (void)_createNodes
{
    self.physicsWorld.contactDelegate = self;
    
    [self setFrame];
    
    if ([kDeviceVersion floatValue] < 8.0) {
        
        [self _setBg:[UIImage imageNamed:@"怪兽牧场"]];

    }else{
       
        _pastureLandBg = (SKSpriteNode *)[self childNodeWithName:@"_pastureLandBg"];
    }
    
    //设置主角
    [self setPlayerType:@"left"];
    [_pastureLandBg addChild:self.player];
    
    
    [self setMonsterWithSuperSence:_pastureLandBg imageNames:@[@"史莱姆.png",@"蝙蝠.png",@"史莱姆.png"]];
    
    [self _createJYImperialPlace];
    
    [self _createWalls];
    
    [self createPromptNode];
    
    [self monster1];
    [self monster2];
    [self pasturelandManager];
}

- (void)monster1{
    //鬃毛怪
    NSMutableArray *picArr = [JYTool image:[UIImage imageNamed:@"鬃毛怪.png"] size:CGSizeMake(32,32) line:4 arrange:3];
    _monster1Dic    = [JYTool imagesUpFirst:picArr arrange:3 line:4];
    
    _monster1 = (SKSpriteNode *)[_pastureLandBg childNodeWithName:@"monster1"];
    [_monster1 setTexture:_monster1Dic[@"down"][0]];
    
    SKAction *action = [SKAction animateWithTextures:_monster1Dic[@"down"] timePerFrame:0.3];
    SKAction *rep = [SKAction repeatActionForever:action];
    
    [_monster1 runAction:rep withKey:@"dance"];
    
    SKPhysicsBody *body = [self _physicsBodyForNPC:_monster1.size.width - 20 height:_monster1.size.width - 20];
    _monster1.physicsBody = body;
    [self _setContact:_monster1 userData:[@{@"monster1":@"1"}mutableCopy]];
    

}
- (void)monster2{

    //蝙蝠
    NSMutableArray *picArr = [JYTool image:[UIImage imageNamed:@"蝙蝠.png"] size:CGSizeMake(42,48) line:4 arrange:4];
    _monster2Dic    = [JYTool images:picArr arrange:4 line:4];
    
    _monster2 = (SKSpriteNode *)[_pastureLandBg childNodeWithName:@"monster2"];
    [_monster2 setTexture:_monster2Dic[@"right"][0]];
    
    SKAction *action = [SKAction animateWithTextures:_monster2Dic[@"right"] timePerFrame:0.3];
    SKAction *rep = [SKAction repeatActionForever:action];
    
    [_monster2 runAction:rep withKey:@"dance"];
    
    SKPhysicsBody *body = [self _physicsBodyForNPC:_monster2.size.width height:_monster2.size.height];
    _monster2.physicsBody = body;
    [self _setContact:_monster2 userData:[@{@"monster2":@"1"}mutableCopy]];

}
- (void)pasturelandManager
{
    NSMutableArray *picArr = [JYTool image:[UIImage imageNamed:@"牧场管家.png"] size:CGSizeMake(32,32) line:4 arrange:3];
    _pasturelandDic    = [JYTool imagesUpFirst:picArr arrange:3 line:4];
    
    _pasturelandManager = (SKSpriteNode *)[_pastureLandBg childNodeWithName:@"pasturelandManager"];
    [_pasturelandManager setTexture:_pasturelandDic[@"down"][0]];
    
    SKAction *action = [SKAction animateWithTextures:_pasturelandDic[@"down"] timePerFrame:0.3];
    SKAction *rep = [SKAction repeatActionForever:action];
    
    [_pasturelandManager runAction:rep withKey:@"dance"];
    
    SKPhysicsBody *body = [self _physicsBodyForNPC:_pasturelandManager.size.width height:_pasturelandManager.size.height];
    _pasturelandManager.physicsBody = body;
    [self _setContact:_pasturelandManager userData:[@{@"pastureManager":@"1"}mutableCopy]];
    
    
}

- (void)_createWalls{
    
    NSArray *wallS = @[@[@870,@0,@255,@50],
                       @[@470,@50,@400,@50],
                       @[@265,@100,@200,@50],
                       @[@200,@150,@50,@90],
                       @[@90,@240,@160,@1],
                       @[@90,@240,@1,@115],
                       @[@200,@345,@50,@150],
                       @[@275,@490,@120,@50],
                       @[@400,@535,@120,@50],
                       @[@535,@585,@190,@50],
                       @[@735,@630,@130,@50],
                       @[@865,@675,@65,@50],
                       @[@1070,@675,@65,@50],
                       @[@1135,@630,@130,@50],
                       @[@1265,@580,@195,@50],
                       @[@1465,@535,@150,@50],
                       @[@1140,@45,@400,@50],
                       @[@1530,@100,@200,@50],
                       @[@1730,@150,@50,@335]];
    
    [self _createWalls:wallS superSence:_pastureLandBg];
    
}

- (void)_createJYImperialPlace
{
    [self setChangeSenceNode:@{@"x":@1165,@"y":@120,@"width":@1,@"height":@1} key:kSence_imperialPlace superSence:_pastureLandBg];
}

- (BOOL)moveActionWithkey:(NSString *)key x:(CGFloat)x y:(CGFloat)y
{
   BOOL isCut = [super moveActionWithkey:key x:x y:y];
    
    if (isCut) {
        return NO;
    }

    NSLog(@"非卡主记录:   %d",(int)self.playerCutPosition.x);
    NSLog(@"非卡主实际:   %d",(int)self.player.position.x);
    NSLog(@"卡主不该走我了啊");
    
    _pastureLandBg.position = CGPointMake(_pastureLandBg.position.x - x, _pastureLandBg.position.y - y);
    
    if (_pastureLandBg.position.x < - 2 * self.screenWidth) {
        _pastureLandBg.position = CGPointMake(-2 * self.screenWidth, _pastureLandBg.position.y);
    }else if(_pastureLandBg.position.x > 0){
     _pastureLandBg.position = CGPointMake(0, _pastureLandBg.position.y);
    }
    
    if (_pastureLandBg.position.y < - self.screenHeight) {
        _pastureLandBg.position = CGPointMake(_pastureLandBg.position.x, -self.screenHeight);
    }else if(_pastureLandBg.position.y > 0){
     _pastureLandBg.position = CGPointMake(_pastureLandBg.position.x, 0);
    }
    
    return YES;
    
}


#pragma mark 触碰
- (void)didBeginContact:(SKPhysicsContact *)contact
{
    SKSpriteNode * A = (SKSpriteNode *)contact.bodyA.node;
    SKSpriteNode * B = (SKSpriteNode *)contact.bodyB.node;
    
    if ([A.userData objectForKey:kSence_imperialPlace])
    {
        
        [self presentSceneWithPosition:CGPointMake(435, 120) scenePosition:CGPointMake(0, 0) texture:self.dic_player[@"left"][0] key:kSence_imperialPlace tra:nil];
    }
    
    else if ([B.userData objectForKey:@"monster1"]){
    
        _isTouchMonster1 = YES;
        [self showConfirmPrompt:@"" hidden:YES frame:CGRectZero];
    }
    
    else if ([B.userData objectForKey:@"pastureManager"]){
        
        _isTouchPastureland = YES;
        [self showConfirmPrompt:@"" hidden:YES frame:CGRectZero];
    }
    
    else if ([B.userData objectForKey:@"monster2"]){
        
        _isTouchMonster2 = YES;
        [self showConfirmPrompt:@"" hidden:YES frame:CGRectZero];
    }
}

- (void)didEndContact:(SKPhysicsContact *)contact
{
    //SKSpriteNode * A = (SKSpriteNode *)contact.bodyA.node;
    SKSpriteNode * B = (SKSpriteNode *)contact.bodyB.node;
    
    if ([B.userData objectForKey:@"monster1"]){
        
        _isTouchMonster1 = NO;
        [self cancel];
 
    }
    
    else if([B.userData objectForKey:@"monster2"]){
        
        _isTouchMonster2 = NO;
        [self cancel];
        
    }
   
    else if([B.userData objectForKey:@"pastureManager"]){
        
        _isTouchPastureland = NO;
        [self cancel];
        
    }
    
    
}


#pragma mark 拥有的怪兽


#pragma mark 操作
- (void)confirm
{
    if (_isTouchMonster1) {
        [_monster1 removeAllActions];
        self.confirmPrompt.hidden = YES;
        [self showCancelPrompt:@"从这里跳下,需要勇气" hidden:NO frame:CGRectZero];
        
    }else if(_isTouchMonster2){
        [_monster2 removeAllActions];
        self.confirmPrompt.hidden = YES;
        [self showCancelPrompt:@"这里是怪兽牧场" hidden:NO frame:CGRectMake((kScreenWidth - 360) / 2.0 ,50,360,80)];
    }else if(_isTouchPastureland){
    
        self.confirmPrompt.hidden = YES;
        
        if (_textNumber == 0) {
            [self showCancelPrompt:@"我是怪兽管理者" hidden:NO frame:CGRectZero];
        }else if(_textNumber == 1){
            [self showCancelPrompt:@"您最多可以拥有20只怪兽" hidden:NO frame:CGRectZero];
        }else{
            BLOCK_EXEC(self.showMonsterList);
            self.cancelPrompt.hidden = YES;
            self.confirmPrompt.hidden = YES;
            
            [self showCancelPrompt:@"" hidden:YES frame:CGRectZero];
        }
        _textNumber++;
    }
}

- (void)cancel
{
    self.cancelPrompt.hidden = YES;
    self.confirmPrompt.hidden = YES;
    
    
    [self showCancelPrompt:@"" hidden:YES frame:CGRectZero];
    
    if (![_monster1 actionForKey:@"dance"]) {
        SKAction *action = [SKAction animateWithTextures:_monster1Dic[@"down"] timePerFrame:0.3];
        SKAction *rep = [SKAction repeatActionForever:action];
        
        [_monster1 runAction:rep withKey:@"dance"];
    }
    
    if (![_monster2 actionForKey:@"dance"]) {
        SKAction *action = [SKAction animateWithTextures:_monster2Dic[@"right"] timePerFrame:0.3];
        SKAction *rep = [SKAction repeatActionForever:action];
        
        [_monster2 runAction:rep withKey:@"dance"];
    }
    
    
  
    _textNumber = 0;
}

@end
