//
//  JYImperialCollection.m
//  Dragon
//
//  Created by 吴冬 on 16/9/19.
//  Copyright © 2016年 北京金源互动科技有限公司. All rights reserved.
//


static NSString *key_furnace = @"key_furnace";
static NSString *key_article = @"key_article";
static NSString *key_bed     = @"key_bed";

@implementation JYImperialCollection
{
    SKSpriteNode *_furnace;
    BOOL _isTouchFurnace;
    
    SKSpriteNode *_article;
    BOOL _isTouchArticle;
    
    SKSpriteNode *_bed;
    BOOL _isTouchBed;
    
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
    
    if ([kDeviceVersion floatValue] < 8.0) {
        [self _setBg:[UIImage imageNamed:@"皇宫存储室.png"]];
    }
    
    
    //设置主角
    [self setPlayerType:@"left"];
    [self addChild:self.player];
    
    
    //设置墙壁
    [self _createWalls];
    
    //返回皇宫
    [self _createImperialPlaceNode];
    
    //设置火炉
    [self _createFurnaceNode];
    
    //设置物品存储
    [self _createArticleNode];
    
    //床，存储
    [self _createBedNode];
    
    //提示按钮
    [self createPromptNode];
    
    //设置怪兽
    [self setMonsterWithSuperSence:self];


}



- (void)_createBedNode
{
    _bed = [SKSpriteNode node];
    _bed.position = CGPointMake(65, 50);
    _bed.anchorPoint = CGPointMake(0, 0);
    _bed.size = CGSizeMake(65, 130);
    _bed.zPosition = kZposition_player - 2;
    [self addChild:_bed];
    
    SKPhysicsBody *body = [self _physicsBody:65 height:130 x:0 y:0];
    _bed.physicsBody = body;
    [self _setContact:_bed userData:[@{key_bed:@(1)}mutableCopy]];
}

- (void)_createArticleNode
{
    _article = [SKSpriteNode node];
    _article.position = CGPointMake(70, 285);
    _article.anchorPoint = CGPointMake(0, 0);
    _article.size = CGSizeMake(130, 80);
    _article.zPosition = kZposition_player - 2;
    [self addChild:_article];
    
    SKPhysicsBody *body = [self _physicsBody:130 height:80 x:0 y:0];
    _article.physicsBody = body;
    [self _setContact:_article userData:[@{key_article:@(1)}mutableCopy]];
    
}

- (void)_createFurnaceNode
{
    _furnace = [SKSpriteNode spriteNodeWithImageNamed:@"火炉_3"];
    _furnace.position = CGPointMake(320, 270);
    _furnace.anchorPoint = CGPointMake(0, 0);
    _furnace.zPosition = kZposition_player - 2;
    [self addChild:_furnace];
    
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:2];
    for (int i = 3; i < 5; i++) {
        NSString *imageName = [NSString stringWithFormat:@"火炉_%d",i];
        SKTexture *texture = [SKTexture textureWithImage:[UIImage imageNamed:imageName]];
        [arr addObject:texture];
    }
    SKAction *action = [SKAction animateWithTextures:arr timePerFrame:.3];
    SKAction *rep = [SKAction repeatActionForever:action];
    
    [_furnace runAction:rep];
    
    SKPhysicsBody *body = [self _physicsBody:_furnace.size.width height:_furnace.size.height x:0 y:20];
    _furnace.physicsBody = body;
    
    [self _setContact:_furnace userData:[@{key_furnace:@"1"}mutableCopy]];
    
}

//walls
- (void)_createWalls
{
    if ([kDeviceVersion floatValue] < 8.0) {
   
        
    }else{
        for (int i = 1; i < 6; i ++) {
            
            NSString *nodeName = [NSString stringWithFormat:@"SKSpriteNode_%d",i];
            
            SKSpriteNode *node = (SKSpriteNode *)[self childNodeWithName:nodeName];
            SKPhysicsBody *body = [self _physicsBody:node.size.width height:node.size.height x:0 y:0];
            node.physicsBody = body;
            [self _setContact:node userData:nil];
        }
    }

    
}

- (void)_createImperialPlaceNode
{
    

    if ([kDeviceVersion floatValue] < 8.0) {
        
        [self setChangeSenceNode:@{@"x":@(1),@"y":@240,@"width":@1,@"height":@50} key:kSence_imperialPlace superSence:self];
        
    }else{
       
        SKSpriteNode *node = (SKSpriteNode *)[self childNodeWithName:@"kSence_imperialPlace"];
        SKPhysicsBody *body = [self _physicsBody:node.size.width height:node.size.height x:0 y:0];
        node.physicsBody = body;
        
        [self _setContact:node userData:[@{kSence_imperialPlace:@"1"}mutableCopy]];
        
    }
    
}


#pragma mark 碰撞检测
- (void)didBeginContact:(SKPhysicsContact *)contact
{
    SKSpriteNode *A = (SKSpriteNode *)contact.bodyA.node;
    
    if ([A.userData objectForKey:kSence_imperialPlace]) {
        
        [self presentSceneWithPosition:CGPointMake(self.screenWidth  - self.player.size.width / 2.0 - 20, 455.0) scenePosition:CGPointMake(0, -self.screenHeight) texture:self.dic_player[@"left"][0] key:kSence_imperialPlace tra:nil];
    }
    
    else if([A.userData objectForKey:key_furnace]){
    
        _isTouchFurnace = YES;
        [self showConfirmPrompt:@"" hidden:YES frame:CGRectZero];
    }
    
    else if([A.userData objectForKey:key_article]){
    
        _isTouchArticle = YES;
        [self showConfirmPrompt:@"" hidden:YES frame:CGRectZero];
    }
    
    else if([A.userData objectForKey:key_bed]){
        
        _isTouchBed = YES;
        [self showConfirmPrompt:@"" hidden:YES frame:CGRectZero];
    }
}

- (void)didEndContact:(SKPhysicsContact *)contact
{
    SKSpriteNode *A = (SKSpriteNode *)contact.bodyA.node;
    
    if ([A.userData objectForKey:kSence_imperialPlace]) {
        
      
    }
    
    else if([A.userData objectForKey:key_furnace]){
        
        _isTouchFurnace = NO;
        [self cancel];
    }
    
    else if([A.userData objectForKey:key_article]){
        
        _isTouchArticle = NO;
        [self cancel];
    }
    
    else if([A.userData objectForKey:key_bed]){
        
        _isTouchBed = NO;
        [self cancel];
    }
}

- (void)confirm
{
    if (_isTouchFurnace) {
        [self showCancelPrompt:@"火炉很烫，水系的怪兽可以浇灭" hidden:NO frame:CGRectZero];
    }else if(_isTouchArticle){
        [self showCancelPrompt:@"这是存储物品的地方" hidden:NO frame:CGRectZero];
    }else if(_isTouchBed){
        [self showCancelPrompt:@"这是储存游戏的地方" hidden:NO frame:CGRectZero];
    }
}

- (void)cancel
{
    self.cancelPrompt.hidden = YES;
    self.confirmPrompt.hidden = YES;
    
    
    [self showCancelPrompt:@"" hidden:YES frame:CGRectZero];
    
}

@end
