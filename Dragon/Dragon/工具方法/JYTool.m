//
//  JYTool.m
//  ddd
//
//  Created by 吴冬 on 16/8/22.
//  Copyright © 2016年 北京金源互动科技有限公司. All rights reserved.
//

#import "JYTool.h"

@implementation JYTool

+ (NSMutableArray *)image:(UIImage *)image size:(CGSize )picSize line:(int )line arrange:(int )arrange
{
    int count = line * arrange;
    
    CGImageRef imageRef = image.CGImage;
    
    NSMutableArray *images = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i < count; i++) {
        
        CGFloat x = (i % arrange) * picSize.width;
        int y = (i / arrange) * picSize.height;
        
        CGRect frame = CGRectMake(x, y, picSize.width, picSize.height);
        CGImageRef cgImage = CGImageCreateWithImageInRect(imageRef, frame);
        
        UIImage *shearImage = [[UIImage alloc]initWithCGImage:cgImage];
        [images addObject:shearImage];
        
    }
    
    return images;
}

+ (NSMutableDictionary *)images:(NSMutableArray *)images arrange:(int )arrange line:(int )line
{
    NSMutableArray *downArr = [NSMutableArray arrayWithCapacity:arrange];
    NSMutableArray *upArr   = [NSMutableArray arrayWithCapacity:arrange];
    NSMutableArray *leftArr = [NSMutableArray arrayWithCapacity:arrange];
    NSMutableArray *rightArr = [NSMutableArray arrayWithCapacity:arrange];
    
    int changeLineNumber = arrange;
    for (int i = 0; i < images.count; i++) {
     
        SKTexture *temp = [SKTexture textureWithImage:images[i]];

        if (i < changeLineNumber) {
            
            [downArr addObject:temp];
            continue;
        }
        
        if (i < changeLineNumber * 2) {
            [leftArr addObject:temp];
            continue;
        }
        
        if (i < changeLineNumber * 3) {
            [rightArr addObject:temp];
            continue;
        }
        
        if (i < changeLineNumber * 4) {
            [upArr addObject:temp];
            continue;
        }
    }
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:4];
    [dic setObject:downArr forKey:@"down"];
    [dic setObject:leftArr forKey:@"left"];
    [dic setObject:rightArr forKey:@"right"];
    [dic setObject:upArr forKey:@"up"];
    
 
    return dic;
}

+ (NSMutableDictionary *)imagesUpFirst:(NSMutableArray *)images arrange:(int )arrange line:(int )line
{
    NSMutableArray *downArr = [NSMutableArray arrayWithCapacity:arrange];
    NSMutableArray *upArr   = [NSMutableArray arrayWithCapacity:arrange];
    NSMutableArray *leftArr = [NSMutableArray arrayWithCapacity:arrange];
    NSMutableArray *rightArr = [NSMutableArray arrayWithCapacity:arrange];
    
    int changeLineNumber = arrange;
    for (int i = 0; i < images.count; i++) {
        
        SKTexture *temp = [SKTexture textureWithImage:images[i]];
        
        if (i < changeLineNumber) {
            
            [upArr addObject:temp];
            continue;
        }
        
        if (i < changeLineNumber * 2) {
            [rightArr addObject:temp];
            continue;
        }
        
        if (i < changeLineNumber * 3) {
            [downArr addObject:temp];
            continue;
        }
        
        if (i < changeLineNumber * 4) {
            [leftArr addObject:temp];
            continue;
        }
    }
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:4];
    [dic setObject:downArr forKey:@"down"];
    [dic setObject:leftArr forKey:@"left"];
    [dic setObject:rightArr forKey:@"right"];
    [dic setObject:upArr forKey:@"up"];
    
    
    return dic;
}


+ (SKAction *)revolveAction:(NSMutableDictionary *)dic
                       time:(NSTimeInterval )timer
               hideOrAppear:(BOOL)isHidden
                      count:(NSInteger )count
               timePerFrame:(NSTimeInterval )timerPerFrame;
{
    NSMutableArray *actArr = [@[dic[@"left"][0],dic[@"up"][0],dic[@"right"][0],dic[@"down"][0]] mutableCopy];
    SKAction *revolve = [SKAction animateWithTextures:actArr timePerFrame:timerPerFrame]; //0.15
    
    SKAction *alphaACT;
    if (isHidden) {
        alphaACT = [SKAction fadeAlphaTo:0 duration:timer]; //3
    }else{
        alphaACT = [SKAction fadeAlphaBy:1 duration:timer];
    }
    
    SKAction *repeatingACT = [SKAction repeatAction:revolve count:count]; //5
    
    SKAction *groupAlphaACT = [SKAction group:@[alphaACT,repeatingACT]];
    
    return groupAlphaACT;
}



+ (SKPhysicsBody *)_physicsBody:(CGFloat )width height:(CGFloat )height
{
    SKPhysicsBody *body = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(width, height)];
    body.affectedByGravity = NO;
    body.allowsRotation = NO;
    body.dynamic = NO;
    return body;
}

@end
