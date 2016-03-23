//
//  LoginVC.m
//  毕业设计
//
//  Created by lanou on 16/3/22.
//  Copyright © 2016年 SK. All rights reserved.
//

#import "LoginVC.h"
#import "LoginDVC.h"
#import "TeacherLoginVC.h"
#import "AppDelegate.h"
#import "TabViewController.h"
#import <BmobSDK/Bmob.h>
#import "DataManager.h"

@interface LoginVC ()<UITextFieldDelegate>

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fingerTapped:)];
    [self.view addGestureRecognizer:tap];
  
}


//登录方法
- (IBAction)LoginBtnAction:(id)sender {
    
    
    if ([self.userNameLabel.text isEqualToString:@""]) {
        [self showAlert:@"账号不能为空"];
    }else if([self.codeLabel.text isEqualToString:@""])
    {
        [self showAlert:@"密码不能为空"];
    }else
    {
        [BmobUser loginWithUsernameInBackground:self.userNameLabel.text password:self.codeLabel.text block:^(BmobUser *user, NSError *error) {
            if (user) {
                if ([[user objectForKey:@"job"] isEqualToString:@"YES"]) {
                    [[NSUserDefaults standardUserDefaults] setObject:@"学生" forKey:@"job"];
                    [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"isLog"];
                    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
                    
                    UIStoryboard * story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                    TabViewController *tabVC = [story instantiateInitialViewController];
                    
                    delegate.window.rootViewController = tabVC;
                    
                }else
                {
                   [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"isLog"];
                     [[NSUserDefaults standardUserDefaults] setObject:@"老师" forKey:@"job"];
                    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
                    
                    UIStoryboard * story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                    TabViewController *tabVC = [story instantiateInitialViewController];
                    
                    delegate.window.rootViewController = tabVC;
                    
                }
            
   
            
                
             }else{
                 
                NSLog(@"error");
                [self showAlert:@"账号或密码错误"];
                
            }
            }];
    }
    
}
//学生注册方法
- (IBAction)StudentBtnAction:(id)sender {
   
    LoginDVC *logindvc = [[LoginDVC alloc] init];
    [self.navigationController pushViewController:logindvc animated:YES];
    [DataManager sharedDataManager].job = @"YES";
}
//老师注册方法
- (IBAction)TeacherBtnAction:(id)sender {
    TeacherLoginVC *teacherVC = [[TeacherLoginVC alloc] init];
    [self.navigationController pushViewController:teacherVC animated:YES];
     [DataManager sharedDataManager].job = @"NO";
}
//回收键盘
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
//点击空白处回收键盘
-(void)fingerTapped:(UITapGestureRecognizer *)gestureRecognizer
{
    [self.view endEditing:YES];
}
//封装方法
-(void)showAlert:(NSString *)reason
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:reason preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action =[UIAlertAction actionWithTitle:@"确认" style: UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:action];
    
    [self presentViewController:alert animated:YES completion:^{
        
    }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
