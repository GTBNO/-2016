//
//  MakeQRView.m
//  毕业设计
//
//  Created by lanou on 16/3/22.
//  Copyright © 2016年 SK. All rights reserved.
//

#import "MakeQRView.h"
#import "HGDQQRCodeView.h"

UILabel *timeLabel;
NSTimer *timer;
float totalTime;
MakeQRView *QRView;

// 计时总时间
#define kTotalTime 120

@implementation MakeQRView


+ (void)showQRCodeInView:(UIView *)superView withFrame:(CGRect)frame
{
    QRView = [[MakeQRView alloc]initWithFrame:frame];
    [superView addSubview:QRView];
    
    totalTime = kTotalTime;
    
    NSDate *date = [NSDate date];
    NSString *dataStr = [NSString stringWithFormat:@"%@", date];
    [HGDQQRCodeView creatQRCodeWithURLString:dataStr superView:QRView logoImage:[UIImage imageNamed:@"3.jpg"] logoImageSize:CGSizeMake(60, 60) logoImageWithCornerRadius:0];
    
    timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(frame.origin.x,CGRectGetMaxY(frame) + 20, QRView.frame.size.width, 30)];
    timeLabel.text = [NSString stringWithFormat:@"%.f", totalTime];
    timeLabel.textAlignment = NSTextAlignmentCenter;
    [superView addSubview:timeLabel];
    timeLabel.backgroundColor = [UIColor redColor];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    
}

+ (void)removeQRCode
{
    if (QRView.superview) {
        [QRView removeFromSuperview];
        [timeLabel removeFromSuperview];
    }
    
    if ([timer isValid]) {
        [timer invalidate];
    }
}

+ (void)stopTimer
{
    if (timer && timer.isValid) {
        [timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:INT_MAX]];
    }
}

+ (void)resumeTimer
{
    if (timer && timer.isValid) {
        [timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:1]];
    }
}

// 计时器响应方法
+ (void)timerAction 
{
    totalTime -= 1;
    timeLabel.text = [NSString stringWithFormat:@"%.f", totalTime];
    if (totalTime == 0) {
        [timer invalidate];
        [QRView removeFromSuperview];
        [timeLabel removeFromSuperview];
    }
}

//+ (NSString *)getWeekDayFordate:(NSDate *)date
//{
//    NSArray *weekDay = @[@"周日", @"周一", @"周二", @"周三", @"周三", @"周四", @"周五", @"周六"];
//    
//    
//}

@end
