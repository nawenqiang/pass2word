//
//  define.h
//  practice
//
//  Created by na on 14-3-7.
//  Copyright (c) 2014年 na. All rights reserved.
//

#ifndef practice_define_h
#define practice_define_h

//NSString *dbPath =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
//stringByAppendingPathComponent:@"user.sqlite"];

#define PATH_OF_DOCUMENT    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
//const NSString * doc = PATH_OF_DOCUMENT;
//NSString * path = [doc stringByAppendingPathComponent:@"user.sqlite"];

NSString *dbPath;

#endif
