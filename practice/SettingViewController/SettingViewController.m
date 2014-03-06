//
//  SettingViewController.m
//  practice
//
//  Created by na on 14-3-4.
//  Copyright (c) 2014年 na. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()<UIAlertViewDelegate>

@end

@implementation SettingViewController
{
    __weak UISwitch *_passwordProtect;
    UIAlertView *_passwordProtectAlertView;
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
    self.title = @"设置";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark-- cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentify = @"commonTableViewCellIdentify";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
    }
    UISwitch *sw = [[UISwitch alloc] initWithFrame:CGRectMake(258, 6, 100, 40)];
    sw.tag = 'swch';
    
    if (indexPath.section == 0)
    {
        cell.textLabel.text = @"主密码保护";
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (![cell viewWithTag:'swch'])
        {
            [cell.contentView addSubview:sw];
            _passwordProtect = sw;
            [sw addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
        }
    }
    else if(indexPath.section == 1)
    {
        cell.textLabel.text = @"改变主题颜色";
    }
    else if(indexPath.section == 2)
    {
        cell.textLabel.text = @"数据管理";
    }
    else if(indexPath.section == 3)
    {
        if(indexPath.row == 0)
        {
            cell.textLabel.text = @"升级到完整";
        }
        else
        {
            cell.textLabel.text = @"恢复购买";
        }

    }
    else if(indexPath.section == 4)
    {
        cell.textLabel.text = @"联系我们";
    }
    return cell;
}
#pragma mark-- switch change
- (void)switchChanged:(id)sender
{
    if (_passwordProtect.on == NO)
    {
        _passwordProtectAlertView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"确定取消主密码保护吗? 唤醒应用不再需要密码!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        [_passwordProtectAlertView show];
    }

}
#pragma mark-- alert delecate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView == _passwordProtectAlertView)
    {
        switch (buttonIndex)
        {
                //确定
            case 0:
                break;
                //取消
            case 1:
                [_passwordProtect setOn:YES animated:YES];
                break;
            default:
                break;
        }
    }
}
#pragma mark-- 段的标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(section == 3)
    {
        return @"升级完整享受任何功能";
    }
    return @"";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 3)
        return 2;
    else
        return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 2)
    {
        return 8.0;
    }
    else if(section == 3)
        return 30.0;
    else
        return 18.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        return 50;
    }
    return 44;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

@end
