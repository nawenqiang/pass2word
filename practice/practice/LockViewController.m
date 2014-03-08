//
//  LockViewController.m
//  practice
//
//  Created by na on 14-3-4.
//  Copyright (c) 2014年 na. All rights reserved.
//

#import "LockViewController.h"


@interface LockViewController ()

@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property NSString *password;

@end

@implementation LockViewController

- (IBAction)login:(id)sender
{
    NSString *pswd = [[NSUserDefaults standardUserDefaults] objectForKey:@"mainpassword"];
    if([_passwordTextField.text isEqualToString:pswd]) {
        [self.presentingViewController dismissViewControllerAnimated:NO completion:nil];
    } else {
        UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:@"警告" message:@"密码错误" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertV show];
    }
    _passwordTextField.text = @"";
}
-(BOOL) isLock: (BOOL) b
{
    return b;
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
