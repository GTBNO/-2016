//
//  StudentHomeWorkView.h
//  毕业设计
//
//  Created by lanou on 16/3/24.
//  Copyright © 2016年 SK. All rights reserved.
//

#import <UIKit/UIKit.h>

// 点击button的处理block
typedef void(^btnHandleBlock)(NSString *);

@interface StudentHomeWorkView : UIView

@property (nonatomic, copy)btnHandleBlock btnHandleBlock;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

+ (instancetype)instanceWithFrame:(CGRect *)frame title:(NSString *)title;

@end
