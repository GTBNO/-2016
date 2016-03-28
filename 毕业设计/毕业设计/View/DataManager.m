//
//  DataManager.m
//  毕业设计
//
//  Created by lanou on 16/3/22.
//  Copyright © 2016年 SK. All rights reserved.
//


#import "DataManager.h"
//#import ""




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
-(void)regist:(NSString *)userName code:(NSString *)code class:(NSString *)className name:(NSString *)name  bingo:(Block)block
{
    BmobUser *bUser = [[BmobUser alloc] init];
    [bUser setUserName:userName];
    [bUser setPassword:code];
    [bUser setObject:name forKey:@"name"];
    [bUser setObject:self.job forKey:@"job"];
    [bUser setObject:className forKey:@"className"];
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


//有问必答的方法
-(void)questionWith:(NSString *)question 
{
    BmobUser *bUser = [BmobUser getCurrentObject];
    if (bUser) {
     NSString *className = [bUser objectForKey:@"className"];
        NSString *name = [bUser objectForKey:@"name"];
        BmobObject  *bmobObject= [BmobObject objectWithClassName:[NSString stringWithFormat:@"%@Question",className]];
        
        
        [bmobObject setObject:question forKey:@"question"];
        [bmobObject setObject:name forKey:@"name"];
        [bmobObject setObject:className forKey:@"className"];
        
      
        
      
        
        //异步保存到服务器
        [bmobObject saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
            if (isSuccessful) {
                //创建成功后会返回objectId，updatedAt，createdAt等信息
                //创建对象成功，打印对象值
                NSLog(@"保存成功");
               NSNotificationCenter *center =  [NSNotificationCenter defaultCenter];
                [center postNotificationName:@"refresh" object:self];
                
              
                
                
            } else if (error){
                //发生错误后的动作
                NSLog(@"%@",error);
            } else {
                NSLog(@"Unknow error");
            }
        }];

        
        
    }
}
-(NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc] init];
        BmobObject *object = [[BmobObject alloc] init];
        
        
      
    }
    return _dataArray;
}
//显示问题的方法
-(void)findQuestion:(ModelBlock)modelBlock
{
    BmobUser *bUser = [BmobUser getCurrentObject];
    
    if (bUser) {
        NSString *className = [bUser objectForKey:@"className"];
        BmobQuery   *bquery = [BmobQuery queryWithClassName:[NSString stringWithFormat:@"%@Question",className]];
          [bquery orderByDescending:@"createdAt"];
     
        
       
        [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
             
                
                
                [self.dataArray addObjectsFromArray:array];
                
                modelBlock();
            
        
           
        }];
      
    }

}
//刷新问题的方法
-(void)refreshQuestion:(ReBlock)reBlock
{
     BmobUser *bUser = [BmobUser getCurrentObject];
    [self.refreshArray removeAllObjects];
    if (bUser) {
       NSString *className =  [bUser objectForKey:@"className"];
        BmobQuery   *bquery = [BmobQuery queryWithClassName:[NSString stringWithFormat:@"%@Question",className]];
        if (self.dataArray.count != 0) {

            
            NSDate *date = [[NSUserDefaults standardUserDefaults] objectForKey:@"time"];
           
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSString *lastTime = [dateFormatter stringFromDate:date];
            NSLog(@"time==========%@",lastTime);
            NSDictionary *condiction1 = @{@"createdAt":@{@"$gt":@{@"__type": @"Date", @"iso": lastTime}}};
            
            NSArray *condictonArray = @[condiction1];
            [bquery addTheConstraintByAndOperationWithArray:condictonArray];
            
            [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
                
                for (BmobObject *object in array) {
//                    NSLog(@"%@",[object objectForKey:@"question"]);
                   
                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                    NSString *lastTime1 = [dateFormatter stringFromDate:object.createdAt];
                    if ([lastTime1 isEqualToString:lastTime]) {
                        
                    }else{
                        [self.refreshArray addObject:object];
                        [self.dataArray addObject:object];
                    }
                    
                }
                        reBlock();
                
            }];

        }else
        {
            [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
            
            for (BmobObject *object in array) {
                NSLog(@"%@",[object objectForKey:@"question"]);
            }
            
            [self.refreshArray addObjectsFromArray:array];
                [self.dataArray addObjectsFromArray:self.refreshArray];
            reBlock();
            
            
        }];

            
        }
       
        
    }
    
    
}

//评论的方法
-(void)commentQuestion:(NSString *)answer
{
   
    BmobUser *user = [BmobUser getCurrentUser];
    if (user) {
        //    拿到评论的问题的对象
        NSInteger number =[[NSUserDefaults standardUserDefaults] integerForKey:@"answer"];
        BmobObject *object = self.dataArray[number];
        
        
        BmobObject *answerObject = [BmobObject objectWithClassName:@"Answer"];
        
        [answerObject setObject:answer forKey:@"answer"];
        [answerObject  setObject:[user objectForKey:@"name"] forKey:@"commenter"];
        [answerObject setObject:[object objectForKey:@"name"] forKey:@"commentee"];
        //构造关系
        BmobRelation *relation = [[BmobRelation alloc] init];
        [relation addObject:object];
        [answerObject addRelation:relation forKey:@"question"];
        
        
        [answerObject saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
            if (isSuccessful) {
                //创建成功后会返回objectId，updatedAt，createdAt等信息
                //创建对象成功，打印对象值
      
                NSLog(@"保存成功");
            } else if (error){
                //发生错误后的动作
                NSLog(@"%@",error);
            } else {
                NSLog(@"Unknow error");
            }
        }];

    }
    

    

}

//得到全部回复的方法
-(void)getAllAnswer:(CommentBlock)commentBlock
{
    
    [self.commentArray removeAllObjects];
    BmobUser *user = [BmobUser getCurrentUser];
    if (user) {
        
        NSInteger number =[[NSUserDefaults standardUserDefaults] integerForKey:@"answer"];
        BmobObject *object = self.dataArray[number];

    
        
          BmobQuery *inQuery = [BmobQuery queryWithClassName:@"Answer"];
        NSString *class = [user objectForKey:@"className"];
        NSString *className = [NSString stringWithFormat:@"%@Question",class];
        
        BmobQuery *bquery = [BmobQuery queryWithClassName:className];
        
        //要得到哪条问题
        
        [bquery whereKey:@"question" equalTo:[object objectForKey:@"question"]];
        [inQuery whereKey:@"question" matchesQuery:bquery];
        [inQuery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
            if (error) {
                NSLog(@"%@",error);
            } else if (array){
            
          for (BmobObject *object in array) {
                   
                    [self.commentArray addObject:object];
          
           }
                
                commentBlock();
            }
        }];
        
        
    }
}

//回复某个人的方法
-(void)commentSomeone:(NSString *)answer commentee:(NSString *)commentee
{
    //同样要加关联的
    BmobUser *user = [BmobUser getCurrentUser];
    if (user) {
        
        //得到哪条问题
        NSInteger which = [[NSUserDefaults standardUserDefaults] integerForKey:@"answer"];
        BmobObject *object1 = self.dataArray[which];
        
    
        
        BmobObject *object = [BmobObject objectWithClassName:@"Answer"];
        
        
        
        [object setObject:[user objectForKey:@"name"] forKey:@"commenter"];
        [object setObject:commentee forKey:@"commentee"];
        [object setObject:answer forKey:@"answer"];
        BmobRelation *relation = [[BmobRelation alloc] init];
        [relation addObject:object1];
        [object addRelation:relation forKey:@"question"];
        
        
        [object saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
            if (isSuccessful) {
                //创建成功后会返回objectId，updatedAt，createdAt等信息
                //创建对象成功，打印对象值
               
                
                //发送通知
                NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
                [center postNotificationName:@"comment" object:self];
                
                NSLog(@"保存成功");
            } else if (error){
                //发生错误后的动作
                NSLog(@"%@",error);
            } else {
                NSLog(@"Unknow error");
            }
        }];

        
        
    }
}
//删除评论的方法
-(void)deleteComment:(NSInteger)which
{
   
      BmobObject *object =  self.commentArray[which];
    [object deleteInBackgroundWithBlock:^(BOOL isSuccessful, NSError *error) {
        if (isSuccessful) {
            //删除成功后的动作
            NSLog(@"successful");
        } else if (error){
            NSLog(@"%@",error);
        } else {
            NSLog(@"UnKnow error");
        }
    }];
    
    
}

//刷新新的评论的方法
-(void)refreshComment
{
    
//    //查找新的评论然后加进数组
//    
//    //1记录最后一条的时间
//    BmobObject *timeObject = self.commentArray[self.commentArray.count - 1];
//    NSDate *date =  timeObject.createdAt;
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"yy-MM-dd HH:mm:ss"];
//    NSString *time = [formatter stringFromDate:date];
//    
//    NSDictionary *condiction1 = @{@"createdAt":@{@"$gt":@{@"__type": @"Date", @"iso":time}}};
//    
//    NSArray *condictonArray = @[condiction1];
//    
//    //创建查找
//    BmobQuery *query = [BmobQuery queryWithClassName:@"Answer"];
//    [query addTheConstraintByAndOperationWithArray:condictonArray];
//    
//    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
//        if (error) {
//            NSLog(@"%@",error);
//        } else if (array){
//            
//            for (BmobObject *object in array) {
//                
//                NSLog(@"%@",[object objectForKey:@"answer"]);
//                
//            }
//            
//       
//        }
//    }];

    BmobUser *user = [BmobUser getCurrentUser];
    if (user) {
        
        NSInteger number =[[NSUserDefaults standardUserDefaults] integerForKey:@"answer"];
        BmobObject *object = self.dataArray[number];
        
        
        
        BmobQuery *inQuery = [BmobQuery queryWithClassName:@"Answer"];
        NSString *class = [user objectForKey:@"className"];
        NSString *className = [NSString stringWithFormat:@"%@Question",class];
        
        BmobQuery *bquery = [BmobQuery queryWithClassName:className];
        
        //要得到哪条问题
        BmobObject *timeObject = self.commentArray[self.commentArray.count - 1];
            NSDate *date =  timeObject.createdAt;
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yy-MM-dd HH:mm:ss"];
            NSString *time = [formatter stringFromDate:date];
        NSLog(@"%@",time);
            NSDictionary *condiction1 = @{@"createdAt":@{@"$gt":@{@"__type": @"Date", @"iso":time}}};
        
        
            NSArray *condictonArray = @[condiction1];
        [bquery addTheConstraintByAndOperationWithArray:condictonArray];
        
        [bquery whereKey:@"question" equalTo:[object objectForKey:@"question"]];
        [inQuery whereKey:@"question" matchesQuery:bquery];
        [inQuery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
            if (error) {
                NSLog(@"%@",error);
            } else if (array){
                
                NSLog(@"suceessful");
                for (BmobObject *object in array) {
                    
                    [self.commentArray addObject:object];
                    NSLog(@"object");
                }
                
              
            }
        }];
        
        
    }

    
}

-(NSMutableArray *)commentArray
{
    if (_commentArray == nil) {
        _commentArray = [[NSMutableArray alloc] init];
    }
    return  _commentArray;
}

-(NSMutableArray *)refreshArray
{
    if (_refreshArray == nil) {
        _refreshArray = [[NSMutableArray alloc] init];
    }
    return _refreshArray;
}

@end
