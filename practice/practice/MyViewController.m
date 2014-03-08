//
//  ViewController.m
//  practice
//
//  Created by na on 14-3-3.
//  Copyright (c) 2014年 na. All rights reserved.
//

#import "MyViewController.h"
#import "MyTableViewCell.h"
#import "SettingViewController.h"
#import "CellData.h"
#import "MyDetailViewController.h"
#import "FMDatabase.h"
#import "DataBase.h"

@interface MyViewController ()<UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@end

@implementation MyViewController
{
    NSMutableArray *_temparray;          //section data
    NSMutableArray *_arrayOfCharacters;  //section title
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {   // Custom initialization
        _temparray  = [[NSMutableArray alloc] init];
        _arrayOfCharacters  = [[NSMutableArray alloc] init];
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
//    [DataBase clearAll];
    //create table
    [DataBase createTable];
    self.title = [NSString stringWithFormat:@"所有用户（%d）",[DataBase getTotalNumbers]];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonSystemItemAction target:self action:@selector(add)];

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonSystemItemAction target:self action:@selector(settingView)];
}

#pragma mark-- setting button
-(void)settingView
{
    SettingViewController *settingView = [[SettingViewController alloc] init];
    [self.navigationController pushViewController:settingView animated:YES];
}


#pragma mark-- add Button
-(void)add
{
    AddViewController *addvc = [[AddViewController alloc] init];
    addvc.delegate = self;
    [self.navigationController pushViewController:addvc animated:YES];
}


#pragma mark-- addview delegate
- (void)setCellData:(CellData *)data;
{
    //db insert
    [DataBase insert: data];
    self.title = [NSString stringWithFormat:@"所有用户（%d）",[DataBase getTotalNumbers]];
    [self updateArrayOfCharacters];
    [self.myTableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//解决点击操作修改后界面不刷新问题
- (void)viewWillAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self updateArrayOfCharacters];
    self.title = [NSString stringWithFormat:@"所有用户（%d）",[DataBase getTotalNumbers]];
    [_myTableView reloadData];
}


#pragma mark --  section
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    [self updateTempArray:section];
    return [_temparray count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([_arrayOfCharacters count])
    {
//        if(YES == _isEmpty)
//            return [_arrayOfCharacters count] + 1;
//        else
            return [_arrayOfCharacters count];
    }
    else
    {
        return 1;
    }
}

#pragma mark-- 段的标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
//    if([_arrayOfCharacters count]==0 || section >= [_arrayOfCharacters count])
//    {
//        return @"";
//    }
    if([_arrayOfCharacters count]==0 )
    {
        return @"";
    }
    return [_arrayOfCharacters objectAtIndex:section];
}
#pragma mark-- 绘制Cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentify = @"MyTableViewCellIdentity";
    
    MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell)
    {
        [tableView registerNib:[UINib nibWithNibName:@"MyTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdentify];
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    }

    [self updateTempArray: indexPath.section];//每用一次之前,需要重新给临时数组添加匹配当前key的记录
    CellData *cellData = [_temparray objectAtIndex:indexPath.row];
    cell.nameLabel.text     = cellData.name;
    cell.accountTextField.text  = cellData.account;


    return cell;
}

#pragma mark-- 表格的索引
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    NSMutableArray *toBeReturned = [[NSMutableArray alloc]init];
    for(char c = 'A';c<='Z';c++)
        [toBeReturned addObject:[NSString stringWithFormat:@"%c",c]];
    return toBeReturned;

}
#pragma mark-- 表格height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75.0;
}

#pragma mark -- Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Create the next view controller.
    MyDetailViewController *detailViewController = [[MyDetailViewController alloc] init];
    [self updateTempArray: indexPath.section];
    CellData *cData = [_temparray objectAtIndex:indexPath.row];
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController getData:cData ];

}
#pragma mark-- selfdefined method
-(void)updateTempArray:(NSInteger)section
{
//    [_temparray removeAllObjects];
//    FMDatabase * db = [FMDatabase databaseWithPath:dbPath];
//    if ([db open])
//    {
//        CellData *data;
//        NSString * sql = @"select * from user";
//        FMResultSet * rs = [db executeQuery:sql];
//        while ([rs next])
//        {
//            data = [[CellData alloc] init];
//            NSString *ns = [rs stringForColumn:@"name"];
//            NSString *at = [rs stringForColumn:@"account"];
//            NSString *pswd = [rs stringForColumn:@"password"];
//            NSString *remark = [rs stringForColumn:@"remark"];
//            NSString *ws = [rs stringForColumn:@"website"];
//
//            data.name = ns;
//            data.account = at;
//            data.password = pswd;
//            data.remark = remark;
//            data.website = ws;
//            if (section >= [_arrayOfCharacters count] && [ns isEqualToString:@""])
//            {
//                [_temparray addObject:data];
//            }
//            else if(section < [_arrayOfCharacters count] && ![ns isEqualToString:@""])
//            {
//                //title of section
//                NSString *key = [_arrayOfCharacters objectAtIndex:section];
//                //get first character
//                char firstchar = [[ns uppercaseString] characterAtIndex:0];
//                //convert to NSstring
//                NSString *firstcharstring = [NSString stringWithFormat:@"%c",firstchar];
//                if ([firstcharstring isEqualToString:key])
//                {
//                    [_temparray addObject:data];
//                }
//            }
//        }
//        [db close];
//    }
//    else
//    {
//        NSLog(@"open db failed");
//    }
/////////////
    [_temparray removeAllObjects];
    FMDatabase * db = [FMDatabase databaseWithPath:dbPath];
    if ([db open])
    {
        CellData *data;
        NSString * sql = @"select * from user";
        FMResultSet * rs = [db executeQuery:sql];
        while ([rs next])
        {
            data = [[CellData alloc] init];
            NSString *ns = [rs stringForColumn:@"name"];
            NSString *at = [rs stringForColumn:@"account"];
            NSString *pswd = [rs stringForColumn:@"password"];
            NSString *remark = [rs stringForColumn:@"remark"];
            NSString *ws = [rs stringForColumn:@"website"];
            
            data.name = ns;
            data.account = at;
            data.password = pswd;
            data.remark = remark;
            data.website = ws;
            //title of section
            NSString *key = [_arrayOfCharacters objectAtIndex:section];
            char firstchar = [[ns uppercaseString] characterAtIndex:0];
            if([key isEqualToString:@"#"] && (firstchar >'Z' || firstchar <'A' ))
            {
                [_temparray addObject:data];
            }
            else if(![key isEqualToString:@"#"])
            {
                //convert to NSstring
                NSString *firstcharstring = [NSString stringWithFormat:@"%c",firstchar];
                if ([firstcharstring isEqualToString:key])
                {
                    [_temparray addObject:data];
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
-(void) updateArrayOfCharacters
{
////    _isEmpty = NO;
//    [_arrayOfCharacters removeAllObjects];
//    
//    FMDatabase * db = [FMDatabase databaseWithPath:dbPath];
//    if ([db open])
//    {
//        NSString * sql = @"select name from user";
//        FMResultSet * rs = [db executeQuery:sql];
//        while ([rs next])
//        {
//            NSString * name = [rs stringForColumn:@"name"];
//            if ([name isEqualToString:@""])
//            {
//                //_isEmpty = YES;
//                continue;
//            }
//            char firstchar = [[name uppercaseString] characterAtIndex:0];//get first character
//            NSString *firstcharstring = [NSString stringWithFormat:@"%c",firstchar]; //convert to nsstring
//
//            if (![_arrayOfCharacters containsObject:(NSObject *)firstcharstring])
//            { //if firstchar was contained
//                [_arrayOfCharacters addObject:firstcharstring];
//            }
//        }
//        [_arrayOfCharacters sortUsingSelector:@selector(localizedCaseInsensitiveCompare:)];   //将数组中的值排序
//        [db close];
//    }
//    else
//        NSLog(@"open db failed");
    [_arrayOfCharacters removeAllObjects];
    
    FMDatabase * db = [FMDatabase databaseWithPath:dbPath];
    if ([db open])
    {
        NSString * sql = @"select name from user";
        FMResultSet * rs = [db executeQuery:sql];
        while ([rs next])
        {
            NSString * name = [rs stringForColumn:@"name"];
            char firstchar = [[name uppercaseString] characterAtIndex:0];//get first character
            if (firstchar <= 'Z' && firstchar >= 'A')
            {
                NSString *firstcharstring = [NSString stringWithFormat:@"%c",firstchar]; //convert to nsstring
                
                if (![_arrayOfCharacters containsObject:(NSObject *)firstcharstring])
                { //if firstchar was contained
                    [_arrayOfCharacters addObject:firstcharstring];
                }        
            }
            else if (![_arrayOfCharacters containsObject:@"#"])
            {
                [_arrayOfCharacters addObject:@"#"];
            }

        }
        [_arrayOfCharacters sortUsingSelector:@selector(localizedCaseInsensitiveCompare:)];   //将数组中的值排序
        [db close];
    }
    else
        NSLog(@"open db failed");
}

@end


