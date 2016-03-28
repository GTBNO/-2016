//
//  Comment.h
//  毕业设计
//
//  Created by lanou on 16/3/28.
//  Copyright © 2016年 SK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Comment : NSObject


@property (nonatomic,strong) NSString *commenter;  //评论者
@property (nonatomic,strong) NSString *commentee;   //被评论者
@property (nonatomic,strong) NSString *content;   //内容

@end
