//
//  ScanQRView.m
//  毕业设计
//
//  Created by lanou on 16/3/23.
//  Copyright © 2016年 SK. All rights reserved.
//

#import "ScanQRView.h"
#import "ZBarSDK.h"


@interface ScanQRView ()<ZBarReaderViewDelegate>

@property (nonatomic, strong)ZBarReaderView *readerView;

// 扫描边框
@property (nonatomic, strong)UIImageView *scanBoundsImageView;
// 扫描线
@property (nonatomic, strong)UIImageView *lineView;


@end

@implementation ScanQRView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        _readerView = [[ZBarReaderView alloc]init];
        _readerView.backgroundColor = [UIColor clearColor];
        _readerView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        _readerView.readerDelegate = self;
        
        // 扫描范围
        CGRect scanMaskRect = CGRectMake(20, 20, frame.size.width - 40, frame.size.height - 40);
        
        [self addSubview:_readerView];
        
        _readerView.scanCrop = [self getScanCrop:scanMaskRect readerViewBounds:_readerView.bounds];
        
        _scanBoundsImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _scanBoundsImageView.image = [UIImage imageNamed:@"扫描框"];
        [self addSubview:_scanBoundsImageView];
        
        [self loopDrawLine];
    }
    return self;
}

// 扫描有效范围?
-(CGRect)getScanCrop:(CGRect)rect readerViewBounds:(CGRect)readerViewBounds
{
    CGFloat x,y,width,height;
    
    x = rect.origin.x / readerViewBounds.size.width;
    y = rect.origin.y / readerViewBounds.size.height;
    width = rect.size.width / readerViewBounds.size.width;
    height = rect.size.height / readerViewBounds.size.height;
    
    return CGRectMake(x,y, width, height);
}

#pragma mark 扫描动画  
-(void)loopDrawLine
{  
    CGRect rect = CGRectMake(_scanBoundsImageView.frame.origin.x, _scanBoundsImageView.frame.origin.y, _scanBoundsImageView.frame.size.width, 2);  
    if (_lineView) {  
        [_lineView removeFromSuperview];  
    }  
    _lineView = [[UIImageView alloc] initWithFrame:rect];  
    [_lineView setImage:[UIImage imageNamed:@"扫描线"]];  
    [UIView animateWithDuration:3.0  
                          delay: 0.0  
                        options: UIViewAnimationOptionCurveEaseIn  
                     animations:^{  
                         //修改frame的代码写在这里  
                         _lineView.frame =CGRectMake(_scanBoundsImageView.frame.origin.x, _scanBoundsImageView.frame.origin.y +_scanBoundsImageView.frame.size.height, _scanBoundsImageView.frame.size.width, 2);  
                         [_lineView setAnimationRepeatCount:0];  
                         
                     }  
                     completion:^(BOOL finished){  
                         if (YES) {  
                             
                             [self loopDrawLine];  
                         }  
                         
                     }];  
    
    [_readerView addSubview:_lineView];  
    
}  

#pragma mark 获取扫描结果  
- (void)readerView:(ZBarReaderView *)readerView didReadSymbols:(ZBarSymbolSet *)symbols fromImage:(UIImage *)image  
{  
    // 得到扫描的条码内容  
    const zbar_symbol_t *symbol = zbar_symbol_set_first_symbol(symbols.zbarSymbolSet);  
    NSString *symbolStr = [NSString stringWithUTF8String: zbar_symbol_get_data(symbol)];  
    NSLog(@"str___________%@", symbolStr);
//    if (zbar_symbol_get_type(symbol) == ZBAR_QRCODE) {  
//        NSLog(@"是二维码"); 
//    }  
//    
//    for (ZBarSymbol *symbol in symbols) {  
//        NSLog(@"%@", symbol.data); 
//        break;  
//    }  
    
    [readerView stop];  
    [self removeFromSuperview];  
    
}  

- (void)startScan
{
    if (_readerView) {
        [_readerView start];
    }
}

- (void)stopScan
{
    if (_readerView) {
        [_readerView stop];
    }
}

@end
