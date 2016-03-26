//
//  DataManager.m
//  毕业设计
//
//  Created by lanou on 16/3/22.
//  Copyright © 2016年 SK. All rights reserved.
//


#import "DataManager.h"


@implementation DataManager


//初始化方法
+(DataManager *)sharedDataManager
{
    static DataManager *dataManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (dataManager == nil) {
            dataManager = [[DataManager alloc] init];
            
        }
    });
    return dataManager;
}

//注册方法
-(void)regist:(NSString *)userName code:(NSString *)code bingo:(Block)block
{
    BmobUser *bUser = [[BmobUser alloc] init];
    [bUser setUserName:userName];
    [bUser setPassword:code];
    [bUser setObject:self.job forKey:@"job"];
    
    [bUser signUpInBackgroundWithBlock:^ (BOOL isSuccessful, NSError *error){
        if (isSuccessful){
            NSLog(@"Sign up successfully");
            block();
        } else {
            NSLog(@"%@",error);
         self.registBlock();
            
        }
    }];

}

//添加学生的方法
-(void)creatStudent:(NSString *)className userName:(NSString *)userName code:(NSString *)code name:(NSString *)name 
{
   
    BmobObject  *bmobObject= [BmobObject objectWithClassName:className];
    
    [bmobObject setObject:name forKey:@"name"];
    [bmobObject setObject:userName forKey:@"userName"];
    [bmobObject setObject:className forKey:@"className"];
    
    
    //异步保存到服务器
    [bmobObject saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        if (isSuccessful) {
            //创建成功后会返回objectId，updatedAt，createdAt等信息
            //创建对象成功，打印对象值
       
        } else if (error){
            //发生错误后的动作
            NSLog(@"%@",error);
        } else {
            NSLog(@"Unknow error");
        }
    }];
    
}
//添加老师的方法
-(void)creatTeacher:(NSString *)userName  name:(NSString *)name
{
    BmobObject *bmob = [BmobObject objectWithClassName:@"Teacher"];
    [bmob setObject:userName forKey:@"userName"];
    [bmob setObject:name forKey:@"name"];
    
    [bmob saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        if (isSuccessful) {
            //创建成功后会返回objectId，updatedAt，createdAt等信息
            //创建对象成功，打印对象值
            
        } else if (error){
            //发生错误后的动作
            NSLog(@"%@",error);
        } else {
            NSLog(@"Unknow error");
        }

    }];
}

@end
