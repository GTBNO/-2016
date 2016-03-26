//
//  ChatVC.m
//  毕业设计
//
//  Created by lanou on 16/3/21.
//  Copyright © 2016年 SK. All rights reserved.
//

#import "ChatVC.h"
#import "AppDelegate.h"
#import "SentMessageVC.h"

@interface ChatVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong)UITableView *selectTeacherTableView;

@property (nonatomic, strong)UIView *shadowView;

// 点击手势, 点击选择老师界面消失
@property (nonatomic, strong)UITapGestureRecognizer *tapGesture;

@end

@implementation ChatVC

- (void)viewDidLoad {
    [super viewDidLoad];
  
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    
     self.title = @"私信";
    
    UIView *view = [[UIView alloc]initWithFrame:self.view.bounds];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发私信" style:(UIBarButtonItemStyleDone) target:self action:@selector(rightBarButtonAction)];
    
     self.selectTeacherTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - app.autorX * 100, 4 * 40 * app.autorY) style:UITableViewStylePlain];
    self.selectTeacherTableView.center = self.view.center;
    self.selectTeacherTableView.delegate = self;
    self.selectTeacherTableView.dataSource = self;
    
    self.tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture:)];
    
    self.shadowView = [[UIView alloc]initWithFrame:self.view.bounds];
    self.shadowView.backgroundColor = [UIColor blackColor];
    self.shadowView.alpha = 0.3;
    [self.shadowView addGestureRecognizer:self.tapGesture];
}

- (void)rightBarButtonAction
{
    [self.view addSubview:self.shadowView];
    [self.view addSubview:self.selectTeacherTableView];    
}

#pragma mark - 手势方法
- (void)tapGesture:(UITapGestureRecognizer *)tap
{
    if (self.selectTeacherTableView) {
              [self.selectTeacherTableView removeFromSuperview];
        }
    if (self.shadowView) {
                [self.shadowView removeFromSuperview];
        }
}

#pragma mark - tabelView 代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:self.selectTeacherTableView]) {
        return 4;
    }
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    cell.textLabel.text = @"老师";
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.selectTeacherTableView]) {
        return 39.5;
    }
    return 20;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([tableView isEqual:self.selectTeacherTableView]) {
    
        SentMessageVC *vc = [[SentMessageVC alloc]init];
        vc.sentToTeacher = cell.textLabel.text;
        [self.navigationController pushViewController:vc animated:YES];
        [self.shadowView removeFromSuperview];
        [self.selectTeacherTableView removeFromSuperview];
         [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
