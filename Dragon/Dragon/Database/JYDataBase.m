//
//  JYDataBase.m
//  ddd
//
//  Created by 吴冬 on 16/8/24.
//  Copyright © 2016年 北京金源互动科技有限公司. All rights reserved.
//

#import "JYDataBase.h"
static JYDataBase *dataBase = nil;
@implementation JYDataBase

+ (JYDataBase *)dataBase
{
   
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (dataBase == nil) {
            dataBase = [[JYDataBase alloc] init];
        }
    });

    return dataBase;
}

+ (id)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (dataBase == nil) {
            dataBase = [super allocWithZone:zone];
        }
    });
    
    return dataBase;
}


- (NSString *)_filePath
{
    
    NSArray *pathArr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *pathStr = pathArr[0];
    
    
    return [pathStr stringByAppendingPathComponent:@"JYDataBase.sqlite"];
}

- (BOOL)openDB
{
    
    NSString *filePath = [self _filePath];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:filePath]) {
        
        BOOL isOpen = sqlite3_open([filePath UTF8String], &_dataBase);
        if (isOpen == SQLITE_OK) {
            return YES;
        }else{
            return NO;
        }
        
    }else{
    
        BOOL isOpen = sqlite3_open([filePath UTF8String], &_dataBase);
        
        [self _createPlayerList];
        
        return isOpen;
        
    }
    
    return NO;
}


- (BOOL)_createPlayerList
{
    char *sql = "CREATE TABLE IF NOT EXISTS players(ID INTEGER PRIMARY KEY AUTOINCREMENT, name text, head text ,uid int)";
    sqlite3_stmt *stmt;
    
    int result = sqlite3_prepare_v2(_dataBase, sql, -1, &stmt, NULL);
    
    if (result != SQLITE_OK) {
        return NO;
    }
    
    int success = sqlite3_step(stmt);
    
    sqlite3_finalize(stmt);
    
    if (success != SQLITE_OK) {
        return NO;
    }
   
    return YES;
}

- (BOOL)_createMonsterList
{
  char *sql = "CREATE TABLE IF NOT EXISTS monsters(ID INTEGER PRIMARY KEY AUTOINCREMENT ,)";
    
    return 0;
}



@end
