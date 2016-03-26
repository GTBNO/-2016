//
//  SignVC.m
//  毕业设计
//
//  Created by lanou on 16/3/21.
//  Copyright © 2016年 SK. All rights reserved.
//

#import "SignVC.h"
#import "StudentSignDetailVC.h"
#import "StudentListVC.h"

@interface SignVC ()<UITableViewDelegate, UITableViewDataSource>

// 当前登录的是老师还是学生
@property (nonatomic, strong)NSString *userType;

@property (nonatomic, strong)StudentSignDetailVC *studentSignDetailVC;

@end

@implementation SignVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
     self.title = @"考勤记录";
    
    _userType = [[NSUserDefaults standardUserDefaults] objectForKey:@"job"];
 
    _userType = @"老师";
    
    CGRect rect = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64);
    UITableView *tableView = [[UITableView alloc]initWithFrame:rect style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.bounces = NO;
    [self.view addSubview:tableView];
}

#pragma mark - tableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([_userType isEqualToString:@"老师"]) {
        return 5;
        
    } else if ([_userType isEqualToString:@"学生"]) {
        
        return 40;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    if ([_userType isEqualToString:@"老师"]) {
        
        cell.textLabel.text = @"班级";
        
    } else if ([_userType isEqualToString:@"学生"]) {
        
       cell.textLabel.text = @"数学";
    }

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_userType isEqualToString:@"学生"]) {
        
        self.studentSignDetailVC = [[StudentSignDetailVC alloc]init];

        [self.navigationController pushViewController:self.studentSignDetailVC animated:YES];
    }
    
    else if ([_userType isEqualToString:@"老师"]) {
        
        StudentListVC *vc = [[StudentListVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
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
