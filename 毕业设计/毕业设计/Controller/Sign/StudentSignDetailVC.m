//
//  StudentSignDetailVC.m
//  毕业设计
//
//  Created by lanou on 16/3/25.
//  Copyright © 2016年 SK. All rights reserved.
//

#import "StudentSignDetailVC.h"
#import "StudentSignDetailCell.h"

@interface StudentSignDetailVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, assign)NSInteger absentCount;

@end

@implementation StudentSignDetailVC

- (void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.absentCount = 10;
    
    UILabel *absentCountLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 84, self.view.frame.size.width, 40)];
    absentCountLabel.textAlignment = NSTextAlignmentCenter;
    absentCountLabel.text = [NSString stringWithFormat:@"缺席次数: %ld", self.absentCount];
    absentCountLabel.font = [UIFont  systemFontOfSize:20];
    [self.view addSubview:absentCountLabel];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(absentCountLabel.frame), self.view.frame.size.width, 40)];
    titleLabel.backgroundColor = [UIColor colorWithRed:0.6 green:0.3 blue:0.1 alpha:1];
    titleLabel.text = @"    缺席详情";
    titleLabel.font = [UIFont systemFontOfSize:19];
    [self.view addSubview:titleLabel];
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLabel.frame), self.view.frame.size.width, self.view.frame.size.height - CGRectGetMaxY(titleLabel.frame)) style:UITableViewStylePlain];
    tableView.tableFooterView = [UIView new];
    [self.view addSubview:tableView];
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerNib:[UINib nibWithNibName:@"StudentSignDetailCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
}

#pragma mark - tableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StudentSignDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
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
