//
//  DataBase.h
//  practice
//
//  Created by na on 14-3-7.
//  Copyright (c) 2014年 na. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "define.h"
#import "CellData.h"

@interface DataBase : NSObject

+(void)insert:(CellData*) data;
+(int) getTotalNumbers;
+(void)createTable;

+(void)clearAll;
+(void)update:(CellData*)target :(CellData*)source ;
+(void)deleteData:(CellData*)data;
+ (BOOL)isHomonym:(CellData*) data;
@end
