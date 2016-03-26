//
//  HomeWorkDetailVC.m
//  毕业设计
//
//  Created by lanou on 16/3/25.
//  Copyright © 2016年 SK. All rights reserved.
//

#import "HomeWorkDetailVC.h"

@interface HomeWorkDetailVC ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation HomeWorkDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(leftBarButtonAction:)];
    
    [self showDetail];
}

- (void)showDetail{
    
    if ([self.selectTitle isEqualToString:@"更多"]) {
      
        UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
        tableView.bounces = NO;
        tableView.delegate = self;
        tableView.dataSource = self;
        [self.view addSubview:tableView];
    }
    else {
        
        UITextView *textView = [[UITextView alloc]initWithFrame:self.view.frame];
        [self.view addSubview:textView];
        textView.editable = NO;
        textView.text = @"111111111111111111111";
        textView.font = [UIFont systemFontOfSize:20];
    
    }
}

#pragma mark - tableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]init];
    }
    
    cell.textLabel.text = self.selectTitle;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeWorkDetailVC *vc = [[HomeWorkDetailVC alloc]init];
    vc.selectTitle = @"push";
    
    [self.navigationController pushViewController:vc animated:YES];
}



// 返回按钮响应方法
- (void)leftBarButtonAction:(UIBarButtonItem *)rightBarButton
{
    if ([self.selectTitle isEqualToString:@"push"]) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
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
