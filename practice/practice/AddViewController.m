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

@interface AddViewController ()

@end

@implementation AddViewController
{
    __weak UIImageView *_avatar;
    __weak UITextField *_name;
    __weak UITextField *_account;
    __weak UITextField *_password;
    __weak UITextField *_website;
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
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    // Do any additional setup after loading the view from its nib.
    self.title = @"新账户";
    UIBarButtonItem *rightBtnItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save)];
    self.navigationItem.rightBarButtonItem = rightBtnItem;
}

-(void) save
{
    CellData *data = [[CellData alloc] init];
    data.name       =_name.text;
    data.account    = _account.text;
    data.password   = _password.text;
    [self.delegate getCellData:data];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //头像，名称
    if (indexPath.row == 0)
    {
        NSString *cellIdentify = @"ImageTextFieldCellIdentify";
        ImageAndNameCell  *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
        if (!cell)
        {
            [tableView registerNib:[UINib nibWithNibName:@"ImageAndNameCell" bundle:nil] forCellReuseIdentifier:cellIdentify];
            cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
        }
        _name = cell.nameTextField;
        
        //头像点击
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleAvatarTap:)];
        [cell.avatarImageView addGestureRecognizer:singleTap];
        cell.avatarImageView.userInteractionEnabled = YES;
        _avatar = cell.avatarImageView;
        
        return cell;
    }
    //账号，密码，网址
    else if (indexPath.row >= 1 && indexPath.row <= 3)
    {
        NSString *cellIdentify = @"LabelTextFieldCellIdentify";
        LabelTextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
        if (!cell) {
            [tableView registerNib:[UINib nibWithNibName:@"LabelTextFieldCell" bundle:nil] forCellReuseIdentifier:cellIdentify];
            cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
        }
        if (indexPath.row == 1)
        {
            _account = cell.contentField;
            cell.contentLabel.text = @"账号:";
            cell.contentField.placeholder = @"账号";
            
        } else if (indexPath.row == 2)
        {
            _password = cell.contentField;
            cell.contentLabel.text = @"密码:";
            cell.contentField.placeholder = @"密码";
            
        } else if (indexPath.row == 3)
        {
            _website = cell.contentField;
            cell.contentLabel.text = @"网址:";
            cell.contentField.placeholder = @"网址";
            cell.contentField.text = @"http://";
        }
        return cell;
    }
    return nil;
    
}
//头像点击，换头像
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
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
        return 70;
    return 34.0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 1.0;
    }
    return 30.0;
}
@end
