//
//  JYSceneManager.h
//  Dragon
//
//  Created by 吴冬 on 16/9/7.
//  Copyright © 2016年 北京金源互动科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JYSceneManager : NSObject
+ (JYSceneManager *)manager;

@property (nonatomic ,strong)NSMutableDictionary *sceneDic;

@end
