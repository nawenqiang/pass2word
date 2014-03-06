//
//  AddViewController.m
//  practice
//
//  Created by na on 14-3-3.
//  Copyright (c) 2014年 na. All rights reserved.
//

#import "AddViewController.h"
#import "ImageAndNameCell.h"
#import "LabelTextFieldCell.h"
#import "RemarkCell.h"

@interface AddViewController ()
@property (weak, nonatomic) IBOutlet UITableView *addTableView;

@end

@implementation AddViewController
{
    BOOL        _isOperator;
    CellData    *_cellData;
    UITextField *_name;
    UITextField *_account;
    UITextField *_password;
    UITextField *_website;
}

-(void) getData: (CellData*) data
{
    _cellData = data;
    _isOperator = YES;
//    _name.text      = data.name;
//    _account.text   = data.account;
//    _password.text  = data.password;
//    _website.text   = data.website;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        _isOperator = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    // Do any additional setup after loading the view from its nib.
    self.title = @"新账户";
    UIBarButtonItem *rightBtnItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save)];
    self.navigationItem.rightBarButtonItem = rightBtnItem;
}
#pragma mark-- save Button
-(void) save
{
    CellData *data;
    if(!_isOperator)
    {
        data  = [[CellData alloc] init];
    }
    else
        data = _cellData;
    data.account    = _account.text;
    data.name       = _name.text;
    data.website    = _website.text;
    data.password   = _password.text;        
    [self.delegate setCellData:data];

    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark-- number of section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 4;
}

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
        NSString *cellIdentify = @"ImageAndNameCellIdentify";
        ImageAndNameCell  *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
        if (!cell)
        {
            [tableView registerNib:[UINib nibWithNibName:@"ImageAndNameCell" bundle:nil] forCellReuseIdentifier:cellIdentify];
            cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
        }
        _name = cell.nameTextField;
        if(_isOperator)
        {
          cell.nameTextField.text = _cellData.name;
        }

        //头像点击
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleAvatarTap:)];
        [cell.avatarImageView addGestureRecognizer:singleTap];
        cell.avatarImageView.userInteractionEnabled = YES;

        
        return cell;
    }
    //账号，密码
    else if (indexPath.section == 1)
    {
        NSString *cellIdentify = @"LabelTextFieldCellIdentify";
        LabelTextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
        if (!cell)
        {
            [tableView registerNib:[UINib nibWithNibName:@"LabelTextFieldCell" bundle:nil] forCellReuseIdentifier:cellIdentify];
            cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
        }
        if (indexPath.row == 0)
        {
            _account = cell.contentField;
            cell.contentLabel.text = @"账号:";
            cell.contentField.placeholder = @"账号";
            if(_isOperator)
            {
                cell.contentField.text = _cellData.account;
            }
        }
        else if (indexPath.row == 1)
        {
            _password = cell.contentField;
            cell.contentLabel.text = @"密码:";
            cell.contentField.placeholder = @"密码";
            if(_isOperator)
            {
                cell.contentField.text = _cellData.password;
            }
        }
        return cell;
    }
    else if (indexPath.section == 2)
    {
        NSString *cellIdentify = @"RemarkCellIdentify";
        RemarkCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
        if (!cell)
        {
            [tableView registerNib:[UINib nibWithNibName:@"RemarkCell" bundle:nil] forCellReuseIdentifier:cellIdentify];
            cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
        }
        
        return cell;
    }
    else //if (indexPath.section == 3)
    {
        NSString *cellIdentify = @"LabelTextFieldCellIdentify";
        LabelTextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
        if (!cell)
        {
            [tableView registerNib:[UINib nibWithNibName:@"LabelTextFieldCell" bundle:nil] forCellReuseIdentifier:cellIdentify];
            cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];

        }
        _website = cell.contentField;
        cell.contentLabel.text = @"网址:";
        cell.contentField.placeholder = @"网址";
        cell.contentField.text = @"http://";
        if(_isOperator)
        {
            cell.contentField.text = _cellData.website;
        }
        return cell;
    }
 //   return nil;
    
}
#pragma mark --头像点击，换头像
- (void)handleAvatarTap:(UIGestureRecognizer *)gestureRecognizer
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"拍照", @"本地图片", nil];
    
    [actionSheet showInView:self.view];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(section == 2)
    {
        return @"附加信息:";
    }
    return @"";
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
        return 70;
    else if(indexPath.section == 2)
        return 80;
    return 40.0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 1.0;
    }
    return 30.0;
}
@end
