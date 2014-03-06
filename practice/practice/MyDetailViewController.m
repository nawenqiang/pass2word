//
//  MyCellViewController.m
//  practice
//
//  Created by na on 14-3-4.
//  Copyright (c) 2014年 na. All rights reserved.
//

#import "MyDetailViewController.h"
#import "DatailContentCell.h"
#import "DatailAvatarAndNameCell.h"
#import "CellData.h"
#import "AddViewController.h"
#import "DetailRemarkCell.h"

@interface MyDetailViewController ()<UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UITableView *detailTableView;

@end

@implementation MyDetailViewController
{
    CellData *_cellData;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"操作" style:UIBarButtonSystemItemAction target:self action:@selector(operator)];
}
#pragma mark-- operator
-(void) operator
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@""  delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:Nil otherButtonTitles:@"修改",@"删除", nil];
    [actionSheet showInView:self.view];
}
#pragma mark-- actionsheet delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0)
    {
        AddViewController *addvc = [[AddViewController alloc] init];
        addvc.delegate = self;

        [self.navigationController pushViewController:addvc animated:YES];
        [addvc getData:_cellData];        

    }
    else if(buttonIndex == 1)
    {
        [_delegate sendID:_cellData.ID];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

-(void) getData: (CellData*)data
{
    _cellData = data;
}

#pragma mark-- AddViewControllerDelegate
- (void)setCellData:(CellData *)data
{
//    _cellData.name = data.name;
//    _cellData.account = data.account;
//    _cellData.password = data.password;
//    _cellData.website = data.website;
    [self.detailTableView reloadData];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark ---  number of section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
#pragma mark ---  row numbers of every section
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 1)
        return 2;
    else
        return 1;
}

#pragma mark-- 绘制Cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //头像，名称
    if (indexPath.section == 0)
    {
        NSString *cellIdentify = @"DatailAvatarAndNameCellIdentify";
        DatailAvatarAndNameCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
        if (!cell)
        {
            [tableView registerNib:[UINib nibWithNibName:@"DatailAvatarAndNameCell" bundle:nil] forCellReuseIdentifier:cellIdentify];
            cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
        }
        cell.nameLabel.text = _cellData.name;
        
        return cell;
    }
    //账号，密码
    else if (indexPath.section == 1)
    {
        NSString *cellIdentify = @"DatailContentCellIdentify";
        DatailContentCell   *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
        if (!cell)
        {
            [tableView registerNib:[UINib nibWithNibName:@"DatailContentCell" bundle:nil] forCellReuseIdentifier:cellIdentify];
            cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
        }
        if (indexPath.row == 0)
        {
            cell.contentLabel.text = _cellData.account;
            cell.infoLabel.text = @"账号";
        }
        else if (indexPath.row == 1)
        {
            cell.contentLabel.text = _cellData.password;
            cell.infoLabel.text = @"密码:";
        }
        return cell;
    }
    else if (indexPath.section == 2)
    {
        NSString *cellIdentify = @"DetailRemarkCellIdentify";
        DetailRemarkCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
        if (!cell)
        {
            [tableView registerNib:[UINib nibWithNibName:@"DetailRemarkCell" bundle:nil] forCellReuseIdentifier:cellIdentify];
            cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
        }
        cell.detailRemarkTextView.text = _cellData.remark;
        return cell;
    }
    else if (indexPath.section == 3)
    {
        NSString *cellIdentify = @"DatailContentCellIdentify";
        DatailContentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
        if (!cell)
        {
            [tableView registerNib:[UINib nibWithNibName:@"DatailContentCell" bundle:nil] forCellReuseIdentifier:cellIdentify];
            cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
            
        }
        cell.contentLabel.text = _cellData.website;
        cell.infoLabel.text = @"网址";
        return cell;
    }
    return nil;
    
}

#pragma mark-- 表格height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
        return 70;
    else if(indexPath.section == 2)
        return 80;
    return 40.0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(section == 2)
    {
        return @"附加信息:";
    }
    return @"";
}
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}
@end
