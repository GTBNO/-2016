//
//  ScanVC.m
//  毕业设计
//
//  Created by lanou on 16/3/21.
//  Copyright © 2016年 SK. All rights reserved.
//

#import "ScanVC.h"
#import "MakeQRView.h"

@interface ScanVC ()

@end

@implementation ScanVC

- (void)viewWillDisappear:(BOOL)animated
{
    [MakeQRView stopTimer];
}

- (void)viewWillAppear:(BOOL)animated
{
    [MakeQRView resumeTimer];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
// 点击生成二维码的button
    UIButton *createQRCode = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    createQRCode.frame = CGRectMake(0, 0, 120, 40);
    createQRCode.center = self.view.center;
    createQRCode.alpha = 0.5;
    createQRCode.layer.cornerRadius = 4;
    createQRCode.backgroundColor = [UIColor lightGrayColor];
    [createQRCode setTitle:@"生成二维码" forState:UIControlStateNormal];
    createQRCode.titleLabel.font = [UIFont systemFontOfSize:20];
    [createQRCode addTarget:self action:@selector(createQRCodeHandle:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:createQRCode];
    
}

- (void)createQRCodeHandle:(UIButton *)btn 
{
    [MakeQRView showQRCodeInView:self.view withFrame:CGRectMake((self.view.bounds.size.width - 200) / 2, 100, 200, 200)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
