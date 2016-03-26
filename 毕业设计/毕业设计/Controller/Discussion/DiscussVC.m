//
//  DiscussVC.m
//  毕业设计
//
//  Created by lanou on 16/3/21.
//  Copyright © 2016年 SK. All rights reserved.
//

#import "DiscussVC.h"
#import <BmobSDK/Bmob.h>
//#import <BmobSDK/BmobQuery.h>
#import "AppDelegate.h"
#import "AskVC.h"
#import "DataManager.h"
#import "SDTimeLineRefreshHeader.h"
#import "SDTimeLineRefreshFooter.h"
#import "SDTimeLineCell.h"

#import "SDTimeLineCellModel.h"
#import "UITableView+SDAutoTableViewCellHeight.h"
#import "UIView+SDAutoLayout.h"
#import "AskVC.h"

@interface DiscussVC () <UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource,BmobEventDelegate>
@property (nonatomic,strong) UIControl *control;

@property (nonatomic,strong) UIButton *button;

@property (nonatomic,strong) AppDelegate *delegate;

@property (nonatomic,strong) UIView *backView;

@property (nonatomic,strong) UIView *bottomView;

@property (nonatomic,strong) UIView *lineView;

@property (nonatomic,strong) UIView *lineView2;

@property (nonatomic,strong) UIView *whiteView;

@property (nonatomic,strong) NSArray *array;

@property (nonatomic,strong) UIImagePickerController *picker;

@property (nonatomic,strong) UIImageView *imageView;

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *dataArray;

@property (nonatomic,strong) BmobEvent *bmobEvent;

@property (nonatomic,strong) NSMutableArray *timeArray;
@end

@implementation DiscussVC
{
    SDTimeLineRefreshFooter *_refreshFooter;
    SDTimeLineRefreshHeader *_refreshHeader;
    CGFloat _lastScrollViewOffsetY;
}
//- (void)viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:animated];
//    
//    if (!_refreshHeader.superview) {
//        
//        _refreshHeader = [SDTimeLineRefreshHeader refreshHeaderWithCenter:CGPointMake(40, 45)];
//        _refreshHeader.scrollView = self.tableView;
//        __weak typeof(_refreshHeader) weakHeader = _refreshHeader;
//        __weak typeof(self) weakSelf = self;
//        [_refreshHeader setRefreshingBlock:^{
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
////                weakSelf.dataArray = [[weakSelf creatModelsWithCount:10] mutableCopy];
////                weakSelf.dataArray = 
//                [weakHeader endRefreshing];
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    [weakSelf.tableView reloadData];
//                });
//            });
//        }];
//        [self.tableView.superview addSubview:_refreshHeader];
//    }
//}
- (void)viewDidLoad {
    [super viewDidLoad];
 
//    self.automaticallyAdjustsScrollViewInsets = YES;
//    
    self.edgesForExtendedLayout = UIRectEdgeNone;
   
  
//   self switchTime:<#(NSDate *)#>
    
    self.title = @"有问必答";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"提问" style:UIBarButtonItemStylePlain target:self action:@selector(askQuesetion:)];
//
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

     self.delegate = [UIApplication sharedApplication].delegate;
    self.array = @[@"文字",@"从相册中选择",@"拍摄",@"取消"];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    self.backView.hidden = YES;
    [self.backView addGestureRecognizer:tap];
//    
    NSArray *arr = @[@"bear.png"];

    [[DataManager sharedDataManager] findQuestion:^{
       
        for ( BmobObject *object in [DataManager sharedDataManager].dataArray)
        {
            NSString *time = [self switchTime:object.createdAt];
            
            [self.timeArray addObject:object.createdAt];
             SDTimeLineCellModel *model = [SDTimeLineCellModel new];
            model.time = time;
            model.iconName = @"bear.png";
            model.name = [object objectForKey:@"name"];
            model.msgContent = [object objectForKey:@"question"];
            model.picNamesArray = arr;
         
            
            
           
           
            [self.dataArray addObject:model];
            
            
        }
       
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        
        
        
    }];
    
//     [self.dataArray addObjectsFromArray:[self creatModelsWithCount:10]];
 //    [self.dataArray addObjectsFromArray: [DataManager sharedDataManager].dataArray];
    
//      __weak typeof(self) weakSelf = self;
////    // 上拉加载
////    _refreshFooter = [SDTimeLineRefreshFooter refreshFooterWithRefreshingText:@"正在加载数据..."];
////    __weak typeof(_refreshFooter) weakRefreshFooter = _refreshFooter;
////    [_refreshFooter addToScrollView:self.tableView refreshOpration:^{
////        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
////            [weakSelf.dataArray addObjectsFromArray:[weakSelf creatModelsWithCount:10]];
////            [weakSelf.tableView reloadData];
////            [weakRefreshFooter endRefreshing];
//        });
//    }];

//    
//
    
    //通知
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(notification:) name:@"refresh" object:nil];
    //计时器 刷新时间
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(refreshTime) userInfo:nil repeats:YES];
    [timer fire];
    
    
}

//收到通知执行的方法
-(void)notification:(NSNotification *)notification
{
    NSArray *arr = @[@"bear.png"];
    [[DataManager sharedDataManager] refreshQuestion:^{
        for ( BmobObject *object in [DataManager sharedDataManager].refreshArray)
        {
            NSString *time = [self switchTime:object.createdAt];

            SDTimeLineCellModel *model = [SDTimeLineCellModel new];
            model.iconName = @"bear.png";
            model.time = time;
            model.name = [object objectForKey:@"name"];
            model.msgContent = [object objectForKey:@"question"];
            model.picNamesArray = arr;
            [self.timeArray insertObject:object.createdAt atIndex:0];
            
            [self.dataArray insertObject:model atIndex:0];
            
        }
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
          
            [self.tableView reloadData];
        });
        
        
    }];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    
}

//计时器的方法
-(void)refreshTime
{
    for (int i = 0 ; i < self.timeArray.count; i++) {
        NSDate *date = self.timeArray[i];
        NSString *time = [self switchTime:date];
        SDTimeLineCellModel *model = self.dataArray[i];
        model.time = time;
        [self.dataArray replaceObjectAtIndex:i withObject:model];
    }
    [self.tableView reloadData];
}


//计算 发表时间
-(NSString *)switchTime:(NSDate *)date
{
    
    NSDate *currentTime = [NSDate date];
      NSTimeInterval timeInterval = [currentTime timeIntervalSinceDate:date];
       if (timeInterval < 60) {
            NSString *secondTime = @"1分钟前";
           return secondTime;
        }else if (timeInterval < 3600)
        {
            double minute = timeInterval / 60.0;
            NSString *minuteTime = [NSString stringWithFormat:@"%0.f分钟前",minute];
            return minuteTime;
        }else
        {
            double hour = timeInterval / 3600.0;
            NSString *hourTime = [NSString stringWithFormat:@"%0.f小时前",hour];
            return hourTime;
        }
    
}

//
//-(void)listenTableChange:(BmobActionType)actionType tableName:(NSString *)tableName
//{
//    
//}
//-(void)listen{
//    //创建BmobEvent对象
//    self.bmobEvent = [BmobEvent defaultBmobEvent];
//    //设置代理
//    self.bmobEvent.delegate = self;
//    //启动连接
//    [self.bmobEvent start];
//}
//
//
////可以进行监听或者取消监听事件
//-(void)bmobEventCanStartListen:(BmobEvent *)event{
//    //监听Post表更新
//    [_bmobEvent listenTableChange:BmobActionTypeUpdateTable tableName:@"lanou08Question"];
//}
////接收到得数据
//-(void)bmobEvent:(BmobEvent *)event didReceiveMessage:(NSString *)message{
////    打印数据
//    NSLog(@"didReceiveMessage:%@",message);
//    NSLog(@"表更新了");
//}
////

-(NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc] init];
        
    }
    return _dataArray;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    SDTimeLineCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    if (cell == nil) {
        cell = [[SDTimeLineCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier:@"reuse"];
    }
    cell.timeLabel.text = @"一分钟前";
    cell.indexPath = indexPath;
    __weak typeof(self) weakSelf = self;
    if (!cell.moreButtonClickedBlock) {
        [cell setMoreButtonClickedBlock:^(NSIndexPath *indexPath) {
            SDTimeLineCellModel *model = weakSelf.dataArray[indexPath.row];
            model.isOpening = !model.isOpening;
            [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }];
    }
    
    ////// 此步设置用于实现cell的frame缓存，可以让tableview滑动更加流畅 //////
    
    cell.sd_tableView = tableView;
    cell.sd_indexPath = indexPath;
    
    ///////////////////////////////////////////////////////////////////////
    cell.block = ^(){
        AskVC *asdVC = [[AskVC alloc] init];
        [self.navigationController pushViewController:asdVC animated:YES];
        
    };
    
    cell.model = self.dataArray[indexPath.row];
    return cell;
    
}


//cell的点击方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // >>>>>>>>>>>>>>>>>>>>> * cell自适应 * >>>>>>>>>>>>>>>>>>>>>>>>
    id model = self.dataArray[indexPath.row];
    return [self.tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[SDTimeLineCell class] contentViewWidth:[self cellContentViewWith]];
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
        
    }
    
    return _tableView;
}

-(void)tapAction
{
    self.backView.hidden = YES;
    
    self.bottomView.hidden = YES;
    self.lineView.hidden = YES;
    self.lineView2.hidden = YES;
    self.whiteView.hidden = YES;
    self.button.hidden = YES;
    self.tabBarController.tabBar.hidden = NO;
    
}
-(UIView *)backView
{
    if (_backView == nil) {
       _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 465 * self.delegate.autorY)];
        [self.view addSubview:_backView];
        _backView.backgroundColor = [UIColor blackColor];
        _backView.alpha = 0.4;
        [self.view addSubview:_backView];
        
    }
    return _backView;
}

-(UIView *)bottomView
{
    if (_bottomView == nil) {
       _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 465 *self.delegate.autorY , [UIScreen mainScreen].bounds.size.width, 210 * self.delegate.autorY)];
        [self.view addSubview:_bottomView];
        _bottomView.backgroundColor = [UIColor whiteColor];
    }
    return  _bottomView;
}

-(UIView *)lineView
{
    if (_lineView == nil) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, (200 * self.delegate.autorY / 4), [UIScreen mainScreen].bounds.size.width, 1)];
            _lineView.backgroundColor = [UIColor grayColor];
            [_bottomView addSubview:_lineView];
    }
    return _lineView;
}
-(UIView *)lineView2
{
    if (_lineView2 == nil) {
        _lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, (200 * self.delegate.autorY / 4) * 2, [UIScreen mainScreen].bounds.size.width, 1)];
        _lineView2.backgroundColor = [UIColor grayColor];
        [_bottomView addSubview:_lineView2];

    }
    return _lineView2;
}
-(UIView *)whiteView
{
    
    if (_whiteView == nil) {
        _whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, (200 * self.delegate.autorY / 4) * 3, [UIScreen mainScreen].bounds.size.width, 10)];
        _whiteView.backgroundColor =[UIColor grayColor];
        [_bottomView addSubview:_whiteView];
    }
    return _whiteView;
    
}

-(UIButton *)button
{
    if (_button == nil) {
        for (int i = 0; i < 4; i++) {
            
                        if (i < 3) {
            
                            _button = [UIButton buttonWithType:UIButtonTypeSystem];
                            _button.frame = CGRectMake(0,  (200 * _delegate.autorY / 4)*i, [UIScreen mainScreen].bounds.size.width, 200 * _delegate.autorY / 4);
                            [_bottomView addSubview:_button];
                            [_button setTitle:_array[i] forState: UIControlStateNormal];
                            [_button setTintColor:[UIColor blackColor]];
                            _button.tag = 10+i;
                            [_button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            
                        }else
                        {
                            _button = [UIButton buttonWithType:UIButtonTypeSystem];
                            _button.frame = CGRectMake(0,(200 * _delegate.autorY / 4)*i + 10, [UIScreen mainScreen].bounds.size.width, 200 * _delegate.autorY / 4);
                            [_bottomView addSubview:_button];
                            [_button setTitle:_array[i] forState: UIControlStateNormal];
                            [_button setTintColor:[UIColor blackColor]];
                            _button.tag = 13;
                            [_button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
                            
                        }
    }
        
    }
    return _button;
}

//相册
-(UIImagePickerController *)picker
{
    if (_picker == nil) {
        _picker = [[UIImagePickerController alloc] init];
    
     
        _picker.editing = YES;
       _picker.delegate = self;
   
    }
    return _picker;
}

//发表按钮的方法
-(void)buttonAction:(UIButton *)button
{
    switch (button.tag) {
        case 10:
        {
            [[NSUserDefaults standardUserDefaults] setObject:@"ask" forKey:@"which"];
            
            AskVC *askVC = [[AskVC alloc] init];
            [self.navigationController pushViewController:askVC animated:YES];
           
            [self tapAction];
        }
            break;
        case 11:
        {
            
                UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
               self.picker.sourceType = sourceType;
            [self presentViewController:self.picker animated:YES completion:^{
                [self tapAction];
            }];
        }
            
            break;
        case 12:
        
            break;
        case 13:
            self.backView.hidden = YES;
            
            self.bottomView.hidden = YES;
            self.lineView.hidden = YES;
            self.lineView2.hidden = YES;
            self.whiteView.hidden = YES;
            self.button.hidden = YES;
            self.tabBarController.tabBar.hidden = NO;
            break;
            
        default:
            break;
    }
}

//代理方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    NSLog(@"%@",info);
//    NSData *data = [NSData dataWithContentsOfURL:info[@"UIImagePickerControllerReferenceURL"]];
    self.imageView.image = info[@"UIImagePickerControllerOriginalImage"];
   
    [self dismissViewControllerAnimated:YES completion:^{
           }];

    

}
//相册的方法
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"被取消了");
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
//提问按钮的方法
-(void)askQuesetion:(UIBarButtonItem *)BarButton
{
    
    self.backView.hidden = NO;
    self.bottomView.hidden = NO;
    self.lineView.hidden = NO;
    self.lineView2.hidden = NO;
    self.whiteView.hidden = NO;
    self.button.hidden = NO;
    self.tabBarController.tabBar.hidden = YES;

}

-(NSMutableArray *)timeArray
{
    if (_timeArray == nil) {
        _timeArray = [[NSMutableArray alloc] init];
    }
    return _timeArray;
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
