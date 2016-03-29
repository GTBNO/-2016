//
//  AskVC.m
//  毕业设计
//
//  Created by lanou on 16/3/24.
//  Copyright © 2016年 SK. All rights reserved.
//

#import "AskVC.h"
#import "DataManager.h"
@interface AskVC ()<UITextFieldDelegate>

@property (nonatomic,strong) NSString *which;

@end

@implementation AskVC



-(void)viewWillAppear:(BOOL)animated
{
     self.which = [[NSUserDefaults standardUserDefaults] objectForKey:@"which"];
    
    if ( [self.which isEqualToString:@"ask"]) {
        self.title =@"问题";
    }else if ([self.which isEqualToString:@"comment"])
    {
        self.title  = @"回复";
    }else
    {
       self.title = @"回复";
    }
    
    

}


- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    [self.textView becomeFirstResponder];
//    self.textView.scrollEnabled = NO;
//    self.textView.editable = NO;
    self.textView.showsVerticalScrollIndicator = NO;
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发表" style: UIBarButtonItemStylePlain target:self action:@selector(sendAction:)];
   
    
  
}
-(void)sendAction:(UIBarButtonItem *)barButton
{
    if ([self.which isEqualToString:@"ask"]) {
        [[DataManager sharedDataManager] questionWith:self.textView.text];
        
        [self.navigationController popViewControllerAnimated:YES];
    }else if([self.which isEqualToString:@"comment"])
    {
        [[DataManager sharedDataManager] commentQuestion:self.textView.text];
        [self.navigationController popViewControllerAnimated:YES];
        //怎么让它同步更新
    }else
    {
        NSInteger row = [[NSUserDefaults standardUserDefaults] integerForKey:@"row"];
       BmobObject *object = [DataManager sharedDataManager].commentArray[row];
        
        [[DataManager sharedDataManager] commentSomeone:self.textView.text commentee:[object objectForKey:@"commenter"]];
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    
    
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
