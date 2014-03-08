//
//  DataBase.m
//  practice
//
//  Created by na on 14-3-7.
//  Copyright (c) 2014年 na. All rights reserved.
//

#import "DataBase.h"
#import "FMDatabase.h"

@implementation DataBase
//'id' INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL ,
+(void)createTable
{
    NSFileManager * fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:dbPath] == NO)
    {
        // create it
        FMDatabase * db = [FMDatabase databaseWithPath:dbPath];
        if ([db open])
        {
            NSString * sql = @"CREATE TABLE user ( name VARCHAR(30),account VARCHAR(30), password VARCHAR(30),remark VARCHAR(30),website VARCHAR(30) )";
            BOOL res = [db executeUpdate:sql];
            if (!res)
            {
                NSLog(@"error when creating db table, error = %@", [db lastError]);
            }
            else
            {
                NSLog(@"succ to creating db table");
            }
            [db close];
        }
        else
        {
            NSLog(@"error when open db");
        }
    }
}
+ (BOOL)isHomonym:(CellData*) data
{
    FMDatabase * db = [FMDatabase databaseWithPath:dbPath];
    if ([db open])
    {
        NSString * sql = @"select name from  user where name = ?";
        FMResultSet * rs = [db executeQuery:sql,data.name];
        if([rs next])
        {
            return YES;
        }
        [db close];
    }
    else
    {
        NSLog(@"open db failed");
    }
    return NO;
}

+(void) cleanHomonym:(CellData*) data
{
    FMDatabase * db = [FMDatabase databaseWithPath:dbPath];
    if ([db open])
    {
        NSString * sql = @"select name from  user ";
        FMResultSet * rs = [db executeQuery:sql];
        while([rs next])
        {
            NSString *name = [rs stringForColumn:@"name"];
            if([name isEqualToString:data.name])
            {
                sql = @"delete from  user where name = ?";
                BOOL res = [db executeUpdate:sql,name];
                if (!res) {
                    NSLog(@"error to delete db data %@",[db lastError]);
                } else {
                    NSLog(@"succ to deleta db data");
                }
            }
        }
        [db close];
    }
    else
    {
        NSLog(@"open db failed");
    }
}

+(void)insert:(CellData*) data
{
    [self cleanHomonym:data];
    FMDatabase * db = [FMDatabase databaseWithPath:dbPath];
    if ([db open]) {
        NSString * sql = @"insert into user (name,account, password,remark,website) values(?,?,?,?,?)";
        BOOL res = [db executeUpdate:sql, data.name, data.account,data.password,data.remark,data.website];
        if (!res)
        {
            NSLog(@"error to insert data %@",[db lastError]);
        }
        else
        {
            NSLog(@"succ to insert data");
        }
        [db close];
    }
}


+(void)deleteData:(CellData*)data
{
    FMDatabase * db = [FMDatabase databaseWithPath:dbPath];
    if ([db open])
    {
        NSString * sql = @"delete from user  WHERE name = ?";
        BOOL res = [db executeUpdate:sql,data.name];
        if (!res) {
            NSLog(@"error to delete db data");
        } else {
            NSLog(@"succ to deleta db data");
        }
        [db close];
    }
    else
    {
        NSLog(@"open db failed");
    }
}
+(void)update:(CellData*)target :(CellData*)source ;
{
    FMDatabase * db = [FMDatabase databaseWithPath:dbPath];
    if ([db open])
    {
        NSString * sql = @"UPDATE user SET name = ?,account = ?,password = ?,remark = ?,website = ? WHERE name = ?";
        BOOL res = [db executeUpdate:sql,target.name,target.account,target.password,target.remark,target.website,source.name];
        if (!res) {
            NSLog(@"error to delete db data");
        } else {
            NSLog(@"succ to deleta db data");
        }
        [db close];
    }
    else
    {
        NSLog(@"open db failed");
    }
}
+(int) getTotalNumbers
{
    int num = 0;
    FMDatabase * db = [FMDatabase databaseWithPath:dbPath];
    if ([db open])
    {
        NSString * sql = @"select count(*) from user";
        FMResultSet * rs = [db executeQuery:sql];
        if ([rs next])
        {
            num = [rs intForColumnIndex:0];
        }
        [db close];
        return num;
    }
    else
    {
        NSLog(@"open db failed");
        return 0;
    }
}

+(void)clearAll
{
    FMDatabase * db = [FMDatabase databaseWithPath:dbPath];
    if ([db open])
    {
        NSString * sql = @"delete from user";
        BOOL res = [db executeUpdate:sql];
        if (!res) {
            NSLog(@"error to delete db data");
        } else {
            NSLog(@"succ to deleta db data");
        }
        [db close];
    }
    else
    {
        NSLog(@"open db failed");
    }
}

@end