//
//  DataManager.h
//  毕业设计
//
//  Created by lanou on 16/3/22.
//  Copyright © 2016年 SK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BmobSDK/Bmob.h>
typedef void(^Block)();
typedef void(^RegistBlock)();
typedef void(^ModelBlock)();
typedef void(^ReBlock)();
typedef void(^CommentBlock)();
@interface DataManager : NSObject

@property (nonatomic,copy) RegistBlock registBlock;
@property (nonatomic,strong) NSString *job; //判断是学生还是老师
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) NSMutableArray *refreshArray;
@property (nonatomic,strong) NSMutableArray *commentArray;

//初始化方法
+(DataManager *)sharedDataManager;

//添加学生方法
-(void)creatStudent:(NSString *)className userName:(NSString *)userName code:(NSString *)code name:(NSString *)name ;

//添加老师的方法
-(void)creatTeacher:(NSString *)userName  name:(NSString *)name;

//注册方法
-(void)regist:(NSString *)userName code:(NSString *)code class:(NSString*)className name:(NSString *)name bingo:(Block)block;

//有问必答方法
-(void)questionWith:(NSString *)question;

//查找问题的方法
-(void)findQuestion:(ModelBlock)modelBlock;

//刷新新的问题方法
-(void)refreshQuestion:(ReBlock)reBlock;

//回复的方法
-(void)commentQuestion:(NSString *)answer;

//回复某个人的方法
-(void)commentSomeone:(NSString*)answer commentee:(NSString *)commentee;

//得到一个问题的全部评论
-(void)getAllAnswer:(CommentBlock)commentBlock;

//删除评论的方法
-(void)deleteComment:(NSInteger)which;

//返回当前班和老师
-(NSMutableArray *)returnAllUser;

@end
