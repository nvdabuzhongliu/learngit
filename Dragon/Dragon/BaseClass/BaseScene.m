//
//  BaseScene.m
//  ddd
//
//  Created by 吴冬 on 16/8/24.
//  Copyright © 2016年 北京金源互动科技有限公司. All rights reserved.
//

#import "BaseScene.h"

@implementation BaseScene

- (void)setFrame
{
    _screenWidth  = self.frame.size.width;
    _screenHeight = self.frame.size.height;
    
    NSLog(@"宽度%lf",_screenWidth);
    NSLog(@"高度%lf",_screenHeight);
}

- (void)setPlayerType:(NSString *)key
{
    _player = [SKSpriteNode spriteNodeWithTexture:self.dic_player[key][0]];
    _player.position = self.playerPosition;
    _player.xScale = 1.4;
    _player.yScale = 1.4;
    _player.zPosition = kZposition_player;
    
    SKPhysicsBody *body = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(_player.size.width, _player.size.height)];
    body.affectedByGravity = NO;
    body.allowsRotation = NO;
    
    _player.physicsBody = body;
    
    _player.physicsBody.categoryBitMask = player_type;
    _player.physicsBody.contactTestBitMask = objc_type;
    _player.physicsBody.collisionBitMask = objc_type;
}

- (void)setMonsterWithSuperSence:(SKNode *)sence imageNames:(NSArray *)images
{
    self.page = self.player.size.width / 2.0 + 5 + self.player.size.width / 2.0;
    
    NSDictionary *dic1 = [self monsterNodeWithImageName:images[0]];
    NSDictionary *dic2 = [self monsterNodeWithImageName:images[1] size:CGSizeMake(42, 48)];
    NSDictionary *dic3 = [self monsterNodeWithImageName:images[2]];
    
    _monsterNode1 = dic1[@"node"];
    _monsterDic1  = dic1[@"dic"];
    
    _monsterNode2 = dic2[@"node"];
    _monsterDic2  = dic2[@"dic"];
    
    _monsterNode3 = dic3[@"node"];
    _monsterDic3  = dic3[@"dic"];
    
    [sence addChild:_monsterNode1];
    [sence addChild:_monsterNode2];
    [sence addChild:_monsterNode3];
}

- (void)setMonsterWithSuperSence:(SKNode *)sence
{
    self.page = self.player.size.width / 2.0 + 5 + self.player.size.width / 2.0;
    
    NSDictionary *dic1 = [self monsterNodeWithImageName:@"player4"];
    NSDictionary *dic2 = [self monsterNodeWithImageName:@"player3"];
    NSDictionary *dic3 = [self monsterNodeWithImageName:@"player2"];
    
    _monsterNode1 = dic1[@"node"];
    _monsterDic1  = dic1[@"dic"];
    
    _monsterNode2 = dic2[@"node"];
    _monsterDic2  = dic2[@"dic"];
    
    _monsterNode3 = dic3[@"node"];
    _monsterDic3  = dic3[@"dic"];
    
    [sence addChild:_monsterNode1];
    [sence addChild:_monsterNode2];
    [sence addChild:_monsterNode3];
    
}

- (NSDictionary *)monsterNodeWithImageName:(NSString *)imageName size:(CGSize)size
{
    NSString *picName = imageName;
    UIImage *image = [UIImage imageNamed:picName];
    NSMutableArray *imageArr = [JYTool image:image size:size line:4 arrange:4];
    NSMutableDictionary *dic = [JYTool images:imageArr arrange:4 line:4];
    
    SKSpriteNode *node = [SKSpriteNode spriteNodeWithTexture:dic[@"right"][0]];
    node.position = CGPointMake(self.playerPosition.x  , self.playerPosition.y);
    node.xScale = 1.4;
    node.yScale = 1.4;
    node.zPosition = kZposition_player - 1;
    
    return @{@"node":node,@"dic":dic};
}


- (NSDictionary *)monsterNodeWithImageName:(NSString *)imageName
{
    NSString *picName = imageName;
    UIImage *image = [UIImage imageNamed:picName];
    NSMutableArray *imageArr = [JYTool image:image size:CGSizeMake(30, 30) line:4 arrange:4];
    NSMutableDictionary *dic = [JYTool images:imageArr arrange:4 line:4];
    
    SKSpriteNode *node = [SKSpriteNode spriteNodeWithTexture:dic[@"right"][0]];
    node.position = CGPointMake(self.playerPosition.x  , self.playerPosition.y);
    node.xScale = 1.4;
    node.yScale = 1.4;
    node.zPosition = kZposition_player - 1;

    return @{@"node":node,@"dic":dic};
}


- (BOOL)moveActionWithkey:(NSString *)key
                        x:(CGFloat )x
                        y:(CGFloat )y
{
    
    CGFloat spriteX = 0;
    CGFloat spriteY = 0;
    
    spriteX = self.player.position.x + x;
    spriteY = self.player.position.y + y;
    
    BOOL isCut = NO;
    
    if ((int)_playerCutPosition.x != (int)self.player.position.x || (int)_playerCutPosition.y != (int)self.player.position.y) {
        NSLog(@"我呗卡主了");
        
        NSLog(@"记录:   %d",(int)_playerCutPosition.x);
        NSLog(@"实际:   %d",(int)self.player.position.x);
        isCut = YES;
        //return;
    }
    
    
    
    self.player.position = CGPointMake(spriteX, spriteY);
    [self changePlayerPic:key];
    
    
    
    self.monsterKey1 = [self key:key x:x y:y node:self.player node2:self.monsterNode1 dic:self.monsterDic1 changeKey:self.monsterKey1];
    self.monsterKey2 = [self key:key x:x y:y node:self.monsterNode1 node2:self.monsterNode2 dic:self.monsterDic2 changeKey:self.monsterKey2];
    self.monsterKey3 = [self key:key x:x y:y node:self.monsterNode2 node2:self.monsterNode3 dic:self.monsterDic3 changeKey:self.monsterKey3];
   
    _playerCutPosition = self.player.position;
    
    
    return  isCut;
}

- (NSString *)key:(NSString *)key x:(CGFloat )x y:(CGFloat )y node:(SKSpriteNode *)node1 node2:(SKSpriteNode *)node2 dic:(NSMutableDictionary *)dic changeKey:(NSString *)changeKey
{
    
    int monsterNode_Y = 0;
    int monsterNode_X = 0;
    NSString *monsterKey = @"";
    
    int spriteX = node1.position.x;
    int spriteY = node1.position.y;
    
    
    if ([key isEqualToString:@"up"] || [key isEqualToString:@"down"])
    {
        int add = fabs(y);
        
        if (node2.position.x != spriteX) {
            
            if ([key isEqualToString:@"up"]) {
                
                if (node2.position.y > spriteY) {
                    monsterKey = @"down";
                    monsterNode_Y = node2.position.y - add;
                    monsterNode_X = node2.position.x;
                }else{
                    //怪兽在右
                    if (node2.position.x > spriteX) {
                        
                        node2.position.x - add < spriteX ? (monsterNode_X = spriteX):(monsterNode_X = node2.position.x - add);
                        monsterNode_Y = node2.position.y;
                        monsterKey    = @"left";
                        
                    }else{
                        
                        //怪兽在左
                        node2.position.x + add > spriteX ? (monsterNode_X = spriteX):(monsterNode_X = node2.position.x + add);
                        monsterNode_Y = node2.position.y;
                        monsterKey    = @"right";
                    }
                }
                
            }else{
             
                if (node2.position.y < spriteY) {
                    monsterKey = @"up";
                    monsterNode_X = node2.position.x;
                    monsterNode_Y = node2.position.y + add;
                    
                }else{
                 
                    
                    
                    //怪兽在右
                    if (node2.position.x > spriteX) {
                        
                        node2.position.x - add < spriteX ? (monsterNode_X = spriteX):(monsterNode_X = node2.position.x - add);
                        monsterNode_Y = node2.position.y;
                        monsterKey    = @"left";
                        
                    }else{
                        
                        //怪兽在左
                        node2.position.x + add > spriteX ? (monsterNode_X = spriteX):(monsterNode_X = node2.position.x + add);
                        monsterNode_Y = node2.position.y;
                        monsterKey    = @"right";
                    }
                }
            }
            
          
            
        }else{
            
            monsterKey = key;
            monsterNode_X = spriteX;
            
            if ([key isEqualToString:@"up"]) {
                
                fabs(spriteY - node2.position.y) > self.page ? (monsterNode_Y = spriteY - self.page):(monsterNode_Y = node2.position.y);
                
                if (node2.position.y > spriteY) {
                    monsterNode_Y = node2.position.y - add;
                    monsterKey = @"down";
                }
                
            }else{
                
                fabs(spriteY - node2.position.y) > self.page ? (monsterNode_Y = spriteY + self.page):(monsterNode_Y = node2.position.y);
                
                if (node2.position.y < spriteY) {
                    monsterNode_Y = node2.position.y + add;
                    monsterKey = @"up";
                }
                
            }
        }
    }
    
    else if([key isEqualToString:@"left"] || [key isEqualToString:@"right"])
    {
        int add = fabs(x);
        
        
        //在左右行走的同时，怪兽Y坐标与主角坐标不同的情况
        if (node2.position.y != spriteY) {
            
            
            if ([key isEqualToString:@"right"]) {
                
                if (node2.position.x > spriteX) {
                    monsterKey = @"left";
                    monsterNode_Y = node2.position.y;
                    monsterNode_X = node2.position.x - add;
                    
                }else{
    
                        if (node2.position.y > spriteY) {
                            
                            node2.position.y - add < spriteY ? (monsterNode_Y = spriteY) : (monsterNode_Y = node2.position.y - add);
                            
                            monsterNode_X = node2.position.x;
                            monsterKey = @"down";
                            
                        }else{
                            
                            //怪兽在下
                            node2.position.y + add > spriteY ? (monsterNode_Y = spriteY) : (monsterNode_Y = node2.position.y + add);
                            
                            monsterNode_X = node2.position.x;
                            monsterKey    = @"up";
                        }
                }
            
                
            }else{
                
                if (node2.position.x < spriteX) {
                    monsterKey = @"right";
                    monsterNode_X = node2.position.x + add;
                    monsterNode_Y = node2.position.y;
                    
                }else{
                 
                    //怪兽在上
                    if (node2.position.y > spriteY) {
                        
                        node2.position.y - add < spriteY ? (monsterNode_Y = spriteY) : (monsterNode_Y = node2.position.y - add);
                        
                        monsterNode_X = node2.position.x;
                        monsterKey = @"down";
                        
                    }else{
                        
                        //怪兽在下
                        node2.position.y + add > spriteY ? (monsterNode_Y = spriteY) : (monsterNode_Y = node2.position.y + add);
                        
                        monsterNode_X = node2.position.x;
                        monsterKey    = @"up";
                    }
                }
                
            }
      
        }else{

            monsterKey    = key;
            monsterNode_Y = spriteY;

            if ([key isEqualToString:@"right"]) {
   
                fabs(spriteX - node2.position.x) > self.page ? (monsterNode_X = spriteX - self.page):(monsterNode_X = node2.position.x);
                
                if (node2.position.x > spriteX) {
                    monsterKey = @"left";
                    monsterNode_X = node2.position.x - add;
                }
        
            }else{
                
                fabs(spriteX - node2.position.x) > self.page ? ( monsterNode_X = spriteX + self.page):(monsterNode_X = node2.position.x);
                
                if (node2.position.x < spriteX) {
                    monsterKey = @"right";
                    monsterNode_X = node2.position.x + add;
                }
                
            }
            
        }
    }

    
    node2.position = CGPointMake(monsterNode_X, monsterNode_Y);
    
    return  [self changeMonsterPic:monsterKey node:node2 dic:dic changeKey:changeKey];
}

- (void)stopMove
{
    [self.player removeActionForKey:@"moveAction"];
    [self.monsterNode1 removeAllActions];
    [self.monsterNode2 removeAllActions];
    [self.monsterNode3 removeAllActions];
}

//改变monster行走动画
- (NSString *)changeMonsterPic:(NSString *)key
                    node:(SKSpriteNode *)node
                     dic:(NSMutableDictionary *)dic
               changeKey:(NSString *)changeKey
{
    if (![changeKey isEqualToString:key] || ![node actionForKey:@"moveAction"]) {
       
        SKAction *picAction = [SKAction animateWithTextures:dic[key] timePerFrame:0.1];
        SKAction *rep = [SKAction repeatActionForever:picAction];
        
        [node runAction:rep withKey:@"moveAction"];
        //记录方位
        return key;
    }
    
    return  changeKey;
}

//行走动画
- (void)changePlayerPic:(NSString *)key
{
    
    if (![_player actionForKey:@"moveAction"]) {
        SKAction *picAction = [SKAction animateWithTextures:self.dic_player[key] timePerFrame:0.1];
        SKAction *rep = [SKAction repeatActionForever:picAction];
        
        [_player runAction:rep withKey:@"moveAction"];
    }
    
}




- (void)selectUpDownLeftAndRight:(DirectionType)type
{
    
}


- (void)confirm
{
    
    
}

- (void)cancel
{
    
}

#pragma mark 工具方法
//设置与玩家的碰撞属性
- (void)_setContact:(SKSpriteNode *)node userData:(NSMutableDictionary *)data
{
    node.physicsBody.categoryBitMask = objc_type;
    node.physicsBody.contactTestBitMask = player_type;
    node.physicsBody.collisionBitMask = player_type;
    node.userData = data;
    
}

//设置人物物理属性
- (SKPhysicsBody *)_physicsBodyForNPC:(CGFloat )width height:(CGFloat )height
{
    
    SKPhysicsBody *body = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(width, height)];
    
    body.affectedByGravity = NO;
    body.allowsRotation = NO;
    body.dynamic = NO;
    return body;

}

//设置物理属性
- (SKPhysicsBody *)_physicsBody:(CGFloat )width height:(CGFloat )height x:(CGFloat )x y:(CGFloat )y
{
    SKPhysicsBody *body = [SKPhysicsBody bodyWithEdgeLoopFromRect:CGRectMake(x, y, width, height)];
    
    body.affectedByGravity = NO;
    body.allowsRotation = NO;
    body.dynamic = NO;
    return body;
}


//prompt
- (void)createPromptNode
{
    
    
    _cancelPrompt = [SKSpriteNode spriteNodeWithImageNamed:@"抬起.png"];
    _cancelPrompt.position = CGPointMake(self.screenWidth - 115 - _cancelPrompt.size.width / 2.0, 90);
    _cancelPrompt.zPosition = kZposition_player + 100;
    _cancelPrompt.hidden = YES;
    [self addChild:_cancelPrompt];
    
    
    SKTexture *p1 = [SKTexture textureWithImage:[UIImage imageNamed:@"抬起.png"]];
    SKTexture *p2 = [SKTexture textureWithImage:[UIImage imageNamed:@"按下.png"]];
    
    SKAction *promptAct = [SKAction animateWithTextures:@[p1,p2] timePerFrame:0.3];
    SKAction *repeatingAct = [SKAction repeatActionForever:promptAct];
    [self.cancelPrompt runAction:repeatingAct];
    
    _confirmPrompt = [SKSpriteNode spriteNodeWithImageNamed:@"抬起.png"];
    _confirmPrompt.position = CGPointMake(self.screenWidth - 30 - self.cancelPrompt.size.width / 2.0, 90);
    _confirmPrompt.zPosition = kZposition_player + 100;
    _confirmPrompt.hidden = YES;
    [self addChild:_confirmPrompt];
    
    
    SKTexture *p3 = [SKTexture textureWithImage:[UIImage imageNamed:@"抬起.png"]];
    SKTexture *p4 = [SKTexture textureWithImage:[UIImage imageNamed:@"按下.png"]];
    
    SKAction *promptAct1 = [SKAction animateWithTextures:@[p3,p4] timePerFrame:0.3];
    SKAction *repeatingAct1 = [SKAction repeatActionForever:promptAct1];
    [_confirmPrompt runAction:repeatingAct1];
    
}

//show cancel Prompt
- (void)showCancelPrompt:(NSString *)text hidden:(BOOL)isHidden frame:(CGRect)frame
{
    _cancelPrompt.hidden = isHidden;
    UIFont *font = [UIFont systemFontOfSize:25];
    if (text.length > 10) {
        font = [UIFont systemFontOfSize:23];
    }
    
    BLOCK_EXEC(_showCancelPrompt,text,isHidden,font,frame);
}

//show confirm Prompt
- (void)showConfirmPrompt:(NSString *)text hidden:(BOOL)isHidden frame:(CGRect)frame
{
    _confirmPrompt.hidden = NO;
    UIFont *font = [UIFont systemFontOfSize:25];
    if (text.length > 10) {
        font = [UIFont systemFontOfSize:23];
    }
    
    BLOCK_EXEC(_showConfirmPrompt,text,isHidden,font,frame);
}



//可操作
- (void)canMove
{
    self.beginOrEndOperateBlock(YES);
    self.beginOrEndGameBlock(YES);
}

//切换场景
- (void)pushScene:(BaseScene *)sence
{}

//已有的场景直接pop
- (void)popScene:(BaseScene *)sence
{}

//初始化
- (BOOL)initWithCreateKey;
{
    self.beginOrEndOperateBlock(NO);//可选择操作
    self.beginOrEndGameBlock(NO);   //可移动操作
    
    if (!self.isAlreadyCreate) {
        
        self.isAlreadyCreate = YES;
        [self performSelector:@selector(canMove) withObject:nil afterDelay:1];

        return YES;
        
    }else{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.player.texture = self.playerTexture;
        });
        
        [self performSelector:@selector(canMove) withObject:nil afterDelay:1];
        return NO;
    }
}


- (void)changePlayerPosition
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.player.position = self.playerPosition;
        self.monsterNode1.position = self.playerPosition;
        self.monsterNode2.position = self.playerPosition;
        self.monsterNode3.position = self.playerPosition;
        self.player.texture  = self.playerTexture;
    });
}

/**
 *  切换场景
 *
 *  @param position 要显示的场景人物出现坐标
 *  @param texture  任务朝向
 *  @param key      要出现的class名
 */
- (void)presentSceneWithPosition:(CGPoint )position
                   scenePosition:(CGPoint )scenePosition
                         texture:(SKTexture *)texture
                             key:(NSString *)key
                             tra:(SKTransition *)tra
{
    
     [self stopMove];
    
    JYSceneManager *manager = [JYSceneManager manager];
    BaseScene *sence = manager.sceneDic[key];
    
 
    
    if (!sence) {

        //key == 类名
        Class superScene = NSClassFromString(key);
        
      
        if ([kDeviceVersion floatValue] >= 8.0) {
            
          sence = [superScene nodeWithFileNamed:key];
          sence.scaleMode = SKSceneScaleModeAspectFill;

        }else{
          sence = [[superScene alloc] initWithSize:CGSizeMake(1334, 750)];
            sence.scaleMode = SKSceneScaleModeAspectFill;

        }
      
        //存储
        [manager.sceneDic setObject:sence forKey:key];
    }

    sence.scenePoint = scenePosition;
    if (tra == nil) {
        tra = [SKTransition fadeWithDuration:1.0];
    }
    
    BLOCK_EXEC(self.presentSceneBlock,sence,tra,position,texture);
}

//设置背景
- (void)_setBg:(UIImage *)bgImage
{
    SKTexture *t = [SKTexture textureWithImage:bgImage];
    
    SKSpriteNode *d = [SKSpriteNode spriteNodeWithTexture:t];
    

    d.position = CGPointMake(0, 0);
    d.anchorPoint = CGPointMake(0, 0);
    [self addChild:d];
}

- (void)_createWalls:(NSArray *)wallArr
          superSence:(SKNode *)sence
{
    for (int i = 0; i < wallArr.count; i++) {
        NSArray *frameArr = wallArr[i];
        
        CGFloat x = [frameArr[0]floatValue];
        CGFloat y = [frameArr[1]floatValue];
        
        CGFloat width = [frameArr[2]floatValue];
        CGFloat height = [frameArr[3]floatValue];
        
        SKSpriteNode *wallNode = [SKSpriteNode node];
        wallNode.position = CGPointMake(x, y);
        wallNode.size = CGSizeMake(width, height);
        
        SKPhysicsBody *body = [self _physicsBody:width height:height x:0 y:0];
        wallNode.physicsBody = body;
        
        [self _setContact:wallNode userData:[@{@"wall":@(1)}mutableCopy]];
        
        [sence addChild:wallNode];
    }
}

- (void)createWalls:(NSInteger )number superSence:(SKNode *)sence
{
    for (int i = 1; i < number; i ++) {
        
        NSString *nodeName = [NSString stringWithFormat:@"wall%d",i];
        
        SKSpriteNode *node = (SKSpriteNode *)[sence childNodeWithName:nodeName];
        SKPhysicsBody *body = [self _physicsBody:node.size.width height:node.size.height x:0 y:0];
        node.physicsBody = body;
        [self _setContact:node userData:nil];
    }
}

- (void)setChangeSenceNode:(SKSpriteNode *)node
                       key:(NSString *)key
{
    SKPhysicsBody *body = [self _physicsBody:node.size.width height:node.size.height x:0 y:0];
    node.physicsBody = body;
    
    [self _setContact:node userData:[@{key:@(1)}mutableCopy]];
}

- (void)setChangeSenceNode:(NSDictionary *)frameDic
                       key:(NSString *)key
                superSence:(SKNode *)sence
{
    CGFloat x = [frameDic[@"x"]floatValue];
    CGFloat y = [frameDic[@"y"]floatValue];
    CGFloat width = [frameDic[@"width"]floatValue];
    CGFloat height = [frameDic[@"height"]floatValue];
    
    SKSpriteNode *node = [SKSpriteNode node];
    node.position = CGPointMake(x, y);
    node.size = CGSizeMake(width, height);
    
    SKPhysicsBody *body = [self _physicsBody:width height:height x:0 y:0];
    node.physicsBody = body;
    
    [self _setContact:node userData:[@{key:@(1)}mutableCopy]];
    
    [sence addChild:node];
    
}

//设置切换到其他场景的key
- (void)_setKey
{}

@end
