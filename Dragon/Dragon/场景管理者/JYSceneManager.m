//
//  JYSceneManager.m
//  Dragon
//
//  Created by 吴冬 on 16/9/7.
//  Copyright © 2016年 北京金源互动科技有限公司. All rights reserved.
//

#import "JYSceneManager.h"
static JYSceneManager *manager = nil;
@implementation JYSceneManager

+ (JYSceneManager *)manager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (manager == nil) {
            manager = [[JYSceneManager alloc] init];
        }
    });
    
    return manager;
}

+ (id)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (manager == nil) {
            manager = [super allocWithZone:zone];
        }
    });
    
    return manager;
}

@end
