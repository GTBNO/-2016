//
//  LoginDVC.m
//  毕业设计
//
//  Created by lanou on 16/3/22.
//  Copyright © 2016年 SK. All rights reserved.
//

#import "LoginDVC.h"
#import "DataManager.h"
@interface LoginDVC () <UITextFieldDelegate>

@end

@implementation LoginDVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = @"注册";
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fingerTapped:)];
    [self.view addGestureRecognizer:tap];
}
//注册方法
- (IBAction)RegistAction:(id)sender {
    
    
    if ([self.name.text isEqualToString:@""]) {
        [self showAlert:@"姓名不能为空"];
        
    } else if([self.userName.text isEqualToString:@""])
    {
        [self showAlert:@"账号不能为空"];
    } else if ([self.code.text isEqualToString:@""])
    {
        [self showAlert:@"密码不能为空"];
    } else if ([self.codeSecond.text isEqualToString:@""])
    {
        [self showAlert:@"确认密码不能为空"];
    } else if ([self.className.text isEqualToString:@""])
    {
        [self showAlert:@"班级不能为空"];
    } else
    {
        if ([self.code.text isEqualToString:self.codeSecond.text]) {
            
            [[DataManager sharedDataManager] regist:self.userName.text code:self.code.text class:self.className.text name:self.name.text bingo:^{
                
                [self showAlert:@"注册成功"];
                [[DataManager sharedDataManager] creatStudent:self.className.text userName:self.userName.text code:self.code.text name:self.name.text];
               
                }];
            
         
        }else
        {
            [self showAlert:@"两次密码不一致"];
        }
        
    }
    
    [DataManager sharedDataManager].registBlock = ^(){
      
        [self showAlert:@"账号已存在"];
        
    };
    
}

//点击空白处回收键盘
-(void)fingerTapped:(UITapGestureRecognizer *)gestureRecognizer
{
    [self.view endEditing:YES];
}
//回收键盘
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
