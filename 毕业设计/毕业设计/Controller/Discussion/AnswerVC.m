//
//  AnswerVC.m
//  毕业设计
//
//  Created by lanou on 16/3/27.
//  Copyright © 2016年 SK. All rights reserved.
//

#import "AnswerVC.h"
#import "DataManager.h"
#import "SDTimeLineRefreshHeader.h"
#import "SDTimeLineRefreshFooter.h"
#import "SDTimeLineCell.h"
#import "AskVC.h"
#import "CommentCell.h"
#import "SoloCell.h"

#import "UITableView+SDAutoTableViewCellHeight.h"
#import "UIView+SDAutoLayout.h"

@interface AnswerVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *commentArray;

@end

@implementation AnswerVC
{
    SDTimeLineRefreshFooter *_refreshFooter;
    SDTimeLineRefreshHeader *_refreshHeader;
    CGFloat _lastScrollViewOffsetY;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"评论";
    self.edgesForExtendedLayout = UIRectEdgeNone;

     self.tableView.backgroundColor = [UIColor whiteColor];
//     self.tableView.tableFooterView 
      self.tableView.tableFooterView = [self footerView];
       [[DataManager sharedDataManager] getAllAnswer:^{
            self.commentArray = [DataManager sharedDataManager].commentArray;
            
            UITableView *tableView = (UITableView *)self.tableView.tableFooterView;
            [tableView reloadData];
       }];
  
    
     
     //通知
     NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
     [center addObserver:self selector:@selector(reloadComment) name:@"comment" object:nil];
     
}

-(void)reloadComment
{
     [self.commentArray removeAllObjects];
     NSLog(@"第一次%ld",self.commentArray.count);
     [[DataManager sharedDataManager] getAllAnswer:^{
          self.commentArray = [DataManager sharedDataManager].commentArray;
               NSLog(@"第二次%ld",self.commentArray.count);
          UITableView *tableView = (UITableView *)self.tableView.tableFooterView;
          [tableView reloadData];
          
     }];
    
}

-(UITableView *)footerView
{
     
    
     UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 375, 667) style:UITableViewStylePlain];
     
     tableView.delegate = self;
     tableView.dataSource = self;
    
     tableView.separatorStyle = NO;
     return tableView;
}


-(NSMutableArray *)commentArray
{
     if (_commentArray == nil) {
          _commentArray = [[NSMutableArray alloc] init];
     }
     return _commentArray;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
     return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     if (tableView == self.tableView) {
            return 1;
     }else
     {
          
          return self.commentArray.count;
     }
  
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     
     if (tableView == self.tableView) {
          SDTimeLineCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reusepool"];
          if (cell == nil) {
               cell = [[SDTimeLineCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reusepool"];
          }
          cell.block = ^(){
             [[NSUserDefaults standardUserDefaults] setObject:@"comment" forKey:@"which"];
               AskVC *askVC = [[AskVC alloc] init];
               [self.navigationController pushViewController:askVC animated:YES];
               
               
          };
          ////// 此步设置用于实现cell的frame缓存，可以让tableview滑动更加流畅 //////
          
          cell.sd_tableView = tableView;
          cell.sd_indexPath = indexPath;
          
          ///////////////////////////////////////////////////////////////////////
          
          cell.model = self.model;
          return cell;

     }else
     {
          BmobObject *object = self.commentArray[indexPath.row];
          NSLog(@"第三次%ld",self.commentArray.count);
          if ([[object objectForKey:@"commenter"] isEqualToString:[object objectForKey:@"commentee"]] ) {
                [tableView registerNib:[UINib nibWithNibName:@"SoloCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"aaa"];
               SoloCell *cell = [tableView dequeueReusableCellWithIdentifier:@"aaa" forIndexPath:indexPath];
               cell.commenterLabel.text = [object objectForKey:@"commenter"];
               cell.contentLabel.text = [object objectForKey:@"answer"];
               cell.selectionStyle = UITableViewCellSelectionStyleBlue;
               return cell;
               
               
          }else
          {
               [tableView registerNib:[UINib nibWithNibName:@"CommentCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"bbb"];
               CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"bbb" forIndexPath:indexPath];
               
               cell.commenterLabel.text = [object objectForKey:@"commenter"];
               cell.commenteeLabel.text = [object objectForKey:@"commentee"];
               cell.contentLabel.text = [object objectForKey:@"answer"];
               cell.selectionStyle = UITableViewCellSelectionStyleBlue;

               return  cell;
          }
         
     }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
     if (tableView == self.tableView) {
          // >>>>>>>>>>>>>>>>>>>>> * cell自适应 * >>>>>>>>>>>>>>>>>>>>>>>>
          id model = self.model;
          return [self.tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[SDTimeLineCell class] contentViewWidth:[self cellContentViewWith]];
     }else
     {
          return 30;
     }
    
    
}

//点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     if (tableView != self.tableView) {
      
          BmobObject *object = [DataManager sharedDataManager].commentArray[indexPath.row];
          BmobUser *user = [BmobUser getCurrentUser];
          if ([[object objectForKey:@"commenter"] isEqualToString:[user objectForKey:@"name"]]) {
               UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"删除我的评论" preferredStyle: UIAlertControllerStyleAlert];
               UIAlertAction *action = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    //删除评论
                    [[DataManager sharedDataManager] deleteComment:indexPath.row];
                    [self.commentArray removeObjectAtIndex:indexPath.row];
                    
                    UITableView *tableView = (UITableView *)self.tableView.tableFooterView;
                    [tableView reloadData];
                    }];
               UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
               }];
               [alert addAction:action1];
               [alert addAction:action];
               
               [self presentViewController:alert animated:YES completion:^{
                    
               }];
          }else
          {
               
               [[NSUserDefaults standardUserDefaults] setInteger:indexPath.row forKey:@"row"];
               //回复的方法
               [[NSUserDefaults standardUserDefaults] setObject:@"someone" forKey:@"which"];
               AskVC *askVC = [[AskVC alloc] init];
               [self.navigationController pushViewController:askVC animated:YES];	
               
          }
     }
}


- (CGFloat)cellContentViewWith
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    // 适配ios7
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
}




-(UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 375, 667) style:UITableViewStylePlain];
        [self.view addSubview:_tableView];
    
         _tableView.delegate = self;
         _tableView.dataSource = self;
    }
    
    return _tableView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
