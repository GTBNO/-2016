//
//  HomeWorkVC.m
//  毕业设计
//
//  Created by lanou on 16/3/21.
//  Copyright © 2016年 SK. All rights reserved.
//

#import "HomeWorkVC.h"
#import "StudentHomeWorkView.h"
#import "HomeWorkDetailVC.h"

@interface HomeWorkVC ()

@end

@implementation HomeWorkVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
     self.title = @"作业";
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    CGRect rect = CGRectMake(20, 100, self.view.frame.size.width - 40, 80);
    StudentHomeWorkView *view = [StudentHomeWorkView instanceWithFrame:&rect title:@"1111"];

    // btn回调方法
    view.btnHandleBlock = ^(NSString *title) {
      
        HomeWorkDetailVC *vc = [[HomeWorkDetailVC alloc]init];
        vc.selectTitle = title;
        
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
        
        [self presentViewController:nav animated:YES completion:^{
            
        }];
    };
    
    [self.view addSubview:view];
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
