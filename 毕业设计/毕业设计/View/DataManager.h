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
@interface DataManager : NSObject

@property (nonatomic,copy) RegistBlock registBlock;
@property (nonatomic,strong) NSString *job; //判断是学生还是老师

//初始化方法
+(DataManager *)sharedDataManager;

//添加学生方法
-(void)creatStudent:(NSString *)className userName:(NSString *)userName code:(NSString *)code name:(NSString *)name ;

//添加老师的方法
-(void)creatTeacher:(NSString *)userName  name:(NSString *)name;

//注册方法
-(void)regist:(NSString *)userName code:(NSString *)code bingo:(Block)block;

@end
