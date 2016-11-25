//
//  JYPlayerManager.m
//  ddd
//
//  Created by 吴冬 on 16/8/24.
//  Copyright © 2016年 北京金源互动科技有限公司. All rights reserved.
//

#import "JYPlayerManager.h"

static JYPlayerManager *manager = nil;
@implementation JYPlayerManager
+ (JYPlayerManager *)manager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (manager == nil) {
            manager = [[JYPlayerManager alloc] init];
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



//插入
+ (void)insertData:(JYPlayerModel *)model
          complete:(CompleteBlock)block
{
    
    JYDataBase *data = [JYDataBase dataBase];
    if ([data openDB]) {
        
        NSString *sql = [NSString stringWithFormat:@"INSERT INTO players (uid,name,head)VALUES('%d','%@','%@')",model.uid,model.name,model.head];
        char *err;
        int result = sqlite3_exec(data.dataBase, [sql UTF8String], NULL, NULL, &err);
        if (result != SQLITE_OK) {
            block(NO);
            return;
        }
        
        sqlite3_close(data.dataBase);
        block(YES);
        
        
    }else{
    
        block(NO);
    }
    
}

+ (int )selectCount
{
    JYDataBase *data = [JYDataBase dataBase];
    if ([data openDB]) {
        
        char *sql = "SELECT COUNT () FROM players";
        
        sqlite3_stmt *stmt;

        int result = sqlite3_prepare_v2(data.dataBase, sql, -1, &stmt, NULL);
        int sumCount = 0;
       
        if (result == SQLITE_OK) {
            while (sqlite3_step(stmt) == SQLITE_ROW) {
                
               int count = sqlite3_column_int(stmt, 0);
                sumCount += count;
            }

        }
        
        sqlite3_finalize(stmt);
        sqlite3_close(data.dataBase);
        
        return sumCount;
        
    }else{
       
        return 0;
    }
}

//查询
+ (JYPlayerModel *)selectPlayer:(int )uid
{
    JYDataBase *data = [JYDataBase dataBase];
    if ([data openDB]) {
        
        NSString *sql = [NSString stringWithFormat:@"SELECT uid ,name ,head FROM players WHERE uid = %d",uid];
        sqlite3_stmt *stmt;
        
        int result = sqlite3_prepare_v2(data.dataBase, [sql UTF8String], -1, &stmt, NULL);
        JYPlayerModel *model;

        if (result == SQLITE_OK) {
            
            while (sqlite3_step(stmt) == SQLITE_ROW) {
                
                model = [[JYPlayerModel alloc] init];
                char *name = (char *)sqlite3_column_text(stmt, 1);
                char *head = (char *)sqlite3_column_text(stmt, 2);
                int uid = (int )sqlite3_column_int(stmt, 3);
                
                model.name = [NSString stringWithUTF8String:name];
                model.head = [NSString stringWithUTF8String:head];
                model.uid = uid;
                
                
            }
        }
        
        sqlite3_finalize(stmt);
        sqlite3_close(data.dataBase);
        
        return model;
        
    }else{
    
        return nil;
    }
}


@end
