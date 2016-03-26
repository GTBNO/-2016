//
//  StudentListVC.m
//  毕业设计
//
//  Created by lanou on 16/3/25.
//  Copyright © 2016年 SK. All rights reserved.
//

#import "StudentListVC.h"
#import "StudentSignDetailVC.h"

@interface StudentListVC ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation StudentListVC

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
   
    UITableView *list = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    list.tableFooterView = [UIView new];
    list.delegate = self;
    list.dataSource = self;
    [self.view addSubview:list];

}


#pragma mark - tableView 代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    cell.textLabel.text = @"20160325 gtb";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    StudentSignDetailVC *vc = [[StudentSignDetailVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

    
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
