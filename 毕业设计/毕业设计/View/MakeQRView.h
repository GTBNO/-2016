//
//  MakeQRView.h
//  毕业设计
//
//  Created by lanou on 16/3/22.
//  Copyright © 2016年 SK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MakeQRView : UIView

// 生成二维码并显示在superView上
+ (void)showQRCodeInView:(UIView *)superView withFrame:(CGRect)frame;

+ (void)removeQRCode;

// 暂停计时
+ (void)stopTimer;

// 继续计时
+ (void)resumeTimer;

@end
