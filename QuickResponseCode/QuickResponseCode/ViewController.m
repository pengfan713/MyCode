//
//  ViewController.m
//  The VIP club
//
//  Created by PengFan on 16/5/24.
//  Copyright © 2016年 PengFan. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "DrawView.h"

@interface ViewController ()<AVCaptureMetadataOutputObjectsDelegate>
{
    AVCaptureSession *session;
    NSTimer *timer;
}

@property (strong, nonatomic) UIImageView *boxImage;

@property (strong, nonatomic) UIImageView *scanImage;
//展示layer
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *videoPreviewLayer;

@end

@implementation ViewController


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self prepareScan];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:0.1]];
}

-(void)prepareScan
{
    //获取摄像设备
    AVCaptureDevice * device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //创建输入流
    AVCaptureDeviceInput * input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    //创建输出流
    AVCaptureMetadataOutput * output = [[AVCaptureMetadataOutput alloc]init];
    //设置代理 在主线程里刷新
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    //初始化链接对象
    session = [[AVCaptureSession alloc]init];
    //高质量采集率
    [session setSessionPreset:AVCaptureSessionPresetHigh];
    
    [session addInput:input];
    [session addOutput:output];
//
   // [output setRectOfInterest: CGRectMake (( 124 )/ ScreenHeight ,(( ScreenWidth - 220 )/ 2 )/ ScreenWidth , 220 / ScreenHeight , 220 / ScreenWidth )];
    //设置扫码支持的编码格式(如下设置条形码和二维码兼容)
//    output.metadataObjectTypes=@[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    [output setMetadataObjectTypes:[NSArray arrayWithObjects:AVMetadataObjectTypeQRCode,AVMetadataObjectTypeCode39Code,AVMetadataObjectTypeCode128Code,AVMetadataObjectTypeCode39Mod43Code,AVMetadataObjectTypeEAN13Code,AVMetadataObjectTypeEAN8Code,nil]];
    
    AVCaptureVideoPreviewLayer * layer = [AVCaptureVideoPreviewLayer layerWithSession:session];
    layer.videoGravity=AVLayerVideoGravityResizeAspectFill;
    layer.frame = self.view.layer.bounds;
    

    [self.view.layer addSublayer:layer];

    DrawView *drawView = [[DrawView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:drawView];
    
    //设置扫描范围
    CGFloat width = ScreenWidth-120;
    CGFloat y = ScreenHeight/2-width/2-64;
    CGRect cropRect = CGRectMake(60, y, width, width);
    CGSize size = self.view.bounds.size;
    CGFloat p1 = size.height/size.width;
    CGFloat p2 = 1920./1080.;  //使用了1080p的图像输出
    if (p1 < p2) {
        CGFloat fixHeight = self.view.bounds.size.width * 1920. / 1080.;
        CGFloat fixPadding = (fixHeight - size.height)/2;
        output.rectOfInterest = CGRectMake((cropRect.origin.y + fixPadding)/fixHeight,
                                                  cropRect.origin.x/size.width,
                                                  cropRect.size.height/fixHeight,
                                                  cropRect.size.width/size.width);
    } else {
        CGFloat fixWidth = self.view.bounds.size.height * 1080. / 1920.;
        CGFloat fixPadding = (fixWidth - size.width)/2;
        output.rectOfInterest = CGRectMake(cropRect.origin.y/size.height,
                                                  (cropRect.origin.x + fixPadding)/fixWidth,
                                                  cropRect.size.height/size.height,
                                                  cropRect.size.width/fixWidth);
    }
    
    //扫描框
    
    _boxImage = [[UIImageView alloc] initWithFrame:cropRect];
    _boxImage.image = [UIImage imageNamed:@"Sweep_pic"];
    [self.view addSubview:_boxImage];
    
    //扫描线
    _scanImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _boxImage.bounds.size.width, 4)];
    _scanImage.image = [UIImage imageNamed:@"Sweep_t"];
    [_boxImage addSubview:_scanImage];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:0.01f target:self selector:@selector(moveScanLayer) userInfo:nil repeats:YES];
    [timer fire];
    
    //开始捕获
    [session startRunning];
    
}

- (void)moveScanLayer
{
    CGRect frame = _scanImage.frame;
    if (_boxImage.frame.size.height == _scanImage.frame.origin.y) {
        frame.origin.y = 0;
        _scanImage.frame = frame;
    }else{
        frame.origin.y += 1;
        [UIView animateWithDuration:0.01 animations:^{
            _scanImage.frame = frame;
        }];
    }
}

-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [timer invalidate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
