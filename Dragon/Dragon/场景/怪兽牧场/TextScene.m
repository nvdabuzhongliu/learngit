//
//  TextScene.m
//  Dragon
//
//  Created by 吴冬 on 16/9/28.
//  Copyright © 2016年 北京金源互动科技有限公司. All rights reserved.
//


@implementation TextScene

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
    
    
    self.backgroundColor = [UIColor cyanColor];
    
    //设置主角
    [self setPlayerType:@"left"];
    [self addChild:self.player];
    
    self.player.physicsBody.affectedByGravity = YES;
    
    [self _createWall];
}

- (void)_createWall
{
    NSArray *walls = @[@[@10,@10,@1,@(self.screenHeight)],
                       @[@10,@(self.screenHeight - 10),@(self.screenWidth),@1],
                       @[@10,@10,@(self.screenWidth),@1],
                       @[@(self.screenWidth - 10),@10,@1,@(self.screenHeight)]];
    [self walls:walls];
    
}

- (void)walls:(NSArray *)arr
{
    
    for (int i = 0; i < arr.count; i++) {
        
        NSArray *arr2 = arr[i];
        
        int x = [arr2[0]intValue];
        int y = [arr2[1]intValue];
        
        int width = [arr2[2]intValue];
        int height = [arr2[3]intValue];
        
        SKSpriteNode *node = [SKSpriteNode node];
        
        node.position = CGPointMake(x, y);
        node.size = CGSizeMake(width, height);
        
        node.anchorPoint = CGPointMake(0, 0);
        node.color = [UIColor blackColor];
        [self addChild:node];
        //        categoryBitMask，它标记了物体属于那一类物体，默认值为0xffffffff
        //        collisionBitMask，它标记了哪些物体可以跟其发生碰撞，默认值为0xffffffff
        //        contactTestBitMask，它标记了哪些物体会和其发生碰撞后产生一些影响，默认值为0x00000000
        SKPhysicsBody *body = [self _physicsBody:width height:height x:x y:y];
        node.physicsBody = body;
        
        [self _setContact:node userData:[@{@"1":@"1"}mutableCopy]];
        
        
    }
}

- (void)confirm
{
    
    SKAction *moveY = [SKAction moveToY:self.player.position.y + 100 duration:.2];

    
    [self.player runAction:moveY completion:^{
        
        
        
    }];
    
    NSLog(@"A");
}

- (void)cancel
{
   
    NSLog(@"B");
}


@end
