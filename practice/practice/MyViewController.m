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


@interface MyViewController ()<MyDetailViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@end

@implementation MyViewController
{
    NSMutableArray *_temparray;          //section data
    NSMutableArray *_myArray;            //total data
    NSMutableArray *_arrayOfCharacters;  //section title
    BOOL    _isEmpty;
    int     _totalCustomer;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {   // Custom initialization
        _temparray  = [[NSMutableArray alloc] init];
        _myArray    = [[NSMutableArray alloc] init];
        _arrayOfCharacters  = [[NSMutableArray alloc] init];
        _isEmpty = NO;
        _totalCustomer = 0;

    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"所有用户（0）";
    UIBarButtonItem *rightBtnItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(add)];
    self.navigationItem.rightBarButtonItem = rightBtnItem;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonSystemItemAction target:self action:@selector(settingView)];
    [self updateArrayOfCharacters];
}
-(void)settingView
{
    SettingViewController *settingView = [[SettingViewController alloc] init];
    [self.navigationController pushViewController:settingView animated:YES];
}
#pragma mark--MyDetailViewControllerDelegate
-(void) sendID:(NSInteger) data
{
    for (CellData* cd in _myArray)
    {
        if(cd.ID == data)
        {
            [_myArray removeObjectAtIndex:data];
            [self updateArrayOfCharacters];
            _totalCustomer --;
            self.title = [NSString stringWithFormat:@"所有用户（%d）",_totalCustomer];
            [_myTableView reloadData];
        }
        break;
    }
}
#pragma mark-- add Button
-(void)add
{
    AddViewController *addvc = [[AddViewController alloc] init];
    addvc.delegate = self;
    [self.navigationController pushViewController:addvc animated:YES];
}

-(void) updateArrayOfCharacters
{
    _isEmpty = NO;
    [_arrayOfCharacters removeAllObjects];
    for (CellData *data in _myArray)
    {
        if ([data.name isEqualToString:@""])
        {
            _isEmpty = YES;
            continue;
        }

        char firstchar = [[data.name uppercaseString] characterAtIndex:0];//get first character
        NSString *firstcharstring = [NSString stringWithFormat:@"%c",firstchar]; //convert to nsstring
        if (![_arrayOfCharacters containsObject:(NSObject *)firstcharstring])
        { //if firstchar was contained
            [_arrayOfCharacters addObject:firstcharstring];
        }
    }
    [_arrayOfCharacters sortUsingSelector:@selector(localizedCaseInsensitiveCompare:)];   //将数组中的值排序
}
#pragma mark-- addview delegate
- (void)setCellData:(CellData *)data;
{
    [_myArray addObject:data];
    data.ID = _totalCustomer;
    _totalCustomer ++;

    self.title = [NSString stringWithFormat:@"所有用户（%d）",_totalCustomer];
    [self updateArrayOfCharacters];
    [self.myTableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [_myTableView reloadData];
}


#pragma mark --  number of section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([_arrayOfCharacters count])
    {
        if(YES == _isEmpty)
            return [_arrayOfCharacters count] + 1;
        else
            return [_arrayOfCharacters count];
    }
    else
    {
        return 1;
    }
}
#pragma mark --  row numbers of every section
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    [self getTempArray:_myArray andSection:section];
    return [_temparray count];
}

-(void)getTempArray:(NSMutableArray*)fromArray andSection:(NSInteger)section
{
    [_temparray removeAllObjects];
    //遍历数组找到匹配分组
    for (CellData* objstr in fromArray)
    {
        if (section >= [_arrayOfCharacters count] && [objstr.name isEqualToString:@""])
        {
            [_temparray addObject:objstr];
        }
        else if(section < [_arrayOfCharacters count] && ![objstr.name isEqualToString:@""])
        {
            //title of section
            NSString *key = [_arrayOfCharacters objectAtIndex:section];
            //get first character
            char firstchar = [[objstr.name uppercaseString] characterAtIndex:0];
            //convert to NSstring
            NSString *firstcharstring = [NSString stringWithFormat:@"%c",firstchar];
            if ([firstcharstring isEqualToString:key])
            {
                [_temparray addObject:objstr];
            }            
        }

    }
}

#pragma mark-- 段的标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if([_arrayOfCharacters count]==0 || section >= [_arrayOfCharacters count])
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
    if([_temparray count])
    {
       [self getTempArray:_myArray andSection:indexPath.section];//每用一次之前,需要重新给临时数组添加匹配当前key的记录
        CellData *cellData = [_temparray objectAtIndex:indexPath.row];
        cell.nameLabel.text     = cellData.name;
        cell.accountTextField.text  = cellData.account;
    }
    else
    {
        CellData *cellData = [_myArray objectAtIndex:indexPath.row];
        cell.nameLabel.text     = cellData.name;
        cell.accountTextField.text  = cellData.account;

    }

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
    detailViewController.delegate = self;
    [self getTempArray:_myArray andSection:indexPath.section];
    CellData *cData = [_temparray objectAtIndex:indexPath.row];
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController getData:cData ];

}

@end


