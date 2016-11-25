//
//  JYPlayerModel.h
//  ddd
//
//  Created by 吴冬 on 16/8/23.
//  Copyright © 2016年 北京金源互动科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JYMonsterModel.h"

@interface JYPlayerModel : NSObject


@property (nonatomic ,copy)NSString *name;
@property (nonatomic ,copy)NSString *head;
@property (nonatomic ,assign)int uid;


@property (nonatomic ,copy)NSArray <JYMonsterModel *> *monsters;


@end
