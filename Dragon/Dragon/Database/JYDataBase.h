//
//  JYDataBase.h
//  ddd
//
//  Created by 吴冬 on 16/8/24.
//  Copyright © 2016年 北京金源互动科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface JYDataBase : NSObject

+ (JYDataBase *)dataBase;

@property (atomic)sqlite3 *dataBase;
- (BOOL)openDB;
@end
