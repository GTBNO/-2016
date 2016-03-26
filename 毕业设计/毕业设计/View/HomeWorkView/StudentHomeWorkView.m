//
//  StudentHomeWorkView.m
//  毕业设计
//
//  Created by lanou on 16/3/24.
//  Copyright © 2016年 SK. All rights reserved.
//

#import "StudentHomeWorkView.h"


@implementation StudentHomeWorkView

+ (instancetype)instanceWithFrame:(CGRect *)frame title:(NSString *)title
{
    NSArray *nibView = [[NSBundle mainBundle] loadNibNamed:@"StudentHomeWorkView" owner:nil options:nil];
    StudentHomeWorkView *view = [nibView lastObject];
    
    view.frame = *(frame);
    view.titleLabel.text = title;
    return view;
}

- (IBAction)btnAction:(UIButton *)sender {
    
    if (self.btnHandleBlock) {
        self.btnHandleBlock(sender.titleLabel.text);
    }    
}



@end
