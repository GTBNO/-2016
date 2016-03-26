//
//  SentMessageVC.m
//  毕业设计
//
//  Created by lanou on 16/3/24.
//  Copyright © 2016年 SK. All rights reserved.
//

#import "SentMessageVC.h"

@interface SentMessageVC ()<UITextViewDelegate>

@property (nonatomic, strong)UIButton *rightBarButon;

@property (nonatomic, strong)UITextView *textView;

@end

@implementation SentMessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = [NSString stringWithFormat:@"@%@", self.sentToTeacher];
    
    _rightBarButon = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 80, 30, 60, 30)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:_rightBarButon];
    
    [_rightBarButon addTarget:self action:@selector(rightBarButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_rightBarButon setTitle:@"发送" forState:UIControlStateNormal];
    _rightBarButon.layer.borderColor = [UIColor blackColor].CGColor;
    _rightBarButon.layer.borderWidth = 0.1;
    _rightBarButon.layer.cornerRadius = 5;
    [_rightBarButon setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    _rightBarButon.enabled = NO;
    [_rightBarButon setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    
    self.textView = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    self.textView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.textView];
    self.textView.font = [UIFont systemFontOfSize:18];
    
    self.textView.delegate = self;
    
    // 监听键盘
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
}
#pragma mark - button点击方法
- (void)rightBarButtonAction:(UIButton *)btn
{
    [self.textView resignFirstResponder];
}

#pragma mark - textView代理方法
- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length > 0) {
        _rightBarButon.backgroundColor = [UIColor orangeColor];
        [_rightBarButon setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _rightBarButon.enabled = YES;
    }
    else {
        _rightBarButon.backgroundColor = [UIColor clearColor];
        [_rightBarButon setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        _rightBarButon.enabled = NO;

    }
}


#pragma mark - 键盘监听方法
- (void)keyboardWillShow:(NSNotification *)noti
{    
    NSDictionary *info = [noti userInfo];
    CGRect kbRect = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    
    self.textView.frame = CGRectMake(0, 0, self.textView.frame.size.width, self.view.bounds.size.height - kbRect.size.height);
    
}


- (void)keyboardWillHidden:(NSNotification *)noti
{
    self.textView.frame = CGRectMake(0, 0, self.textView.frame.size.width, self.view.frame.size.height);
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
