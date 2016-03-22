//
//  MakeQRView.m
//  毕业设计
//
//  Created by lanou on 16/3/22.
//  Copyright © 2016年 SK. All rights reserved.
//

#import "MakeQRView.h"
#import "HGDQQRCodeView.h"

@interface MakeQRView ()

@property (nonatomic, strong)UILabel *timeLabe;

@end

@implementation MakeQRView


+ (void)showQRCodeInView:(UIView *)superView withFrame:(CGRect)frame
{
    MakeQRView *QRView = [[MakeQRView alloc]initWithFrame:frame];
    [superView addSubview:QRView];
    
    NSDate *date = [NSDate date];
    NSString *dataStr = [NSString stringWithFormat:@"%@", date];
    [HGDQQRCodeView creatQRCodeWithURLString:dataStr superView:QRView logoImage:[UIImage imageNamed:@"3.jpg"] logoImageSize:CGSizeMake(60, 60) logoImageWithCornerRadius:0];
    
    
    NSLog(@"date_______%@", dataStr);
}

@end
