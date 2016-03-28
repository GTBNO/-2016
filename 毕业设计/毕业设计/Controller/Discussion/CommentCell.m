//
//  CommentCell.m
//  毕业设计
//
//  Created by lanou on 16/3/28.
//  Copyright © 2016年 SK. All rights reserved.
//

#import "CommentCell.h"

@implementation CommentCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


//给对象赋值
-(void)setComment:(Comment *)comment
{
    _comment = comment;
    _commenterLabel.text = comment.commenter;
    _commenteeLabel.text = comment.commentee;
    _contentLabel.text = comment.content;
}


@end
