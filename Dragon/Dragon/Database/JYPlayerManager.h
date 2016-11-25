//
//  JYPlayerManager.h
//  ddd
//
//  Created by 吴冬 on 16/8/24.
//  Copyright © 2016年 北京金源互动科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^CompleteBlock)(BOOL);

@interface JYPlayerManager : NSObject

+ (JYPlayerManager *)manager;

//插入
+ (void)insertData:(JYPlayerModel *)model
          complete:(CompleteBlock)block;

//查询
+ (JYPlayerModel *)selectPlayer:(int )uid;

//查询数据数量
+ (int )selectCount;

@end
