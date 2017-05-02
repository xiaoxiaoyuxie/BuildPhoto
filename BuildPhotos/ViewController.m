//
//  ViewController.m
//  BuildPhotos
//
//  Created by 杨永强 on 2017/5/1.
//  Copyright © 2017年 杨永强. All rights reserved.
//

#import "ViewController.h"

#import "MainView.h"
#import "UIView+CLKAddition.h"

@interface ViewController ()

@end

@implementation ViewController
{
    MainView *_mainView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(statusBarOrientationChange:)name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
    // Do any additional setup after loading the view, typically from a nib.
    _mainView=[[MainView alloc] initWithType:RectangleType imageCount:10 padding:5 radius:10 paddingColor:[UIColor whiteColor]];
    [self.view addSubview:_mainView];
    UIBarButtonItem *bar0=[[UIBarButtonItem alloc] initWithTitle:@"样式>" style:UIBarButtonItemStyleDone target:self action:@selector( nextShowType)];
    UIBarButtonItem *bar1=[[UIBarButtonItem alloc] initWithTitle:@"<样式" style:UIBarButtonItemStyleDone target:self action:@selector(lastShowType)];
    UIBarButtonItem *bar2=[[UIBarButtonItem alloc] initWithTitle:@"圆角" style:UIBarButtonItemStyleDone target:self action:@selector(reSetRadius)];
    UIBarButtonItem *bar3=[[UIBarButtonItem alloc] initWithTitle:@"间距" style:UIBarButtonItemStyleDone target:self action:@selector(reSetpadding)];
    UIBarButtonItem *bar4=[[UIBarButtonItem alloc] initWithTitle:@"颜色" style:UIBarButtonItemStyleDone target:self action:@selector(reSetColor)];
    UIBarButtonItem *bar5=[[UIBarButtonItem alloc] initWithTitle:@"数量" style:UIBarButtonItemStyleDone target:self action:@selector(reSetImageNumber)];
    UIBarButtonItem *bar6=[[UIBarButtonItem alloc] initWithTitle:@"宽窄" style:UIBarButtonItemStyleDone target:self action:@selector(reMainType)];
    [self.navigationItem setRightBarButtonItems:@[bar0,bar1,bar2,bar3,bar4,bar5,bar6]];
    
}
- (void)statusBarOrientationChange:(NSNotification *)notification{
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationLandscapeRight) // home键靠右
    {
        //
        _mainView.mainType=SquareType;
    }
    if (orientation ==UIInterfaceOrientationLandscapeLeft) // home键靠左
    {
    //
        _mainView.mainType=SquareType;
    }
    if (orientation == UIInterfaceOrientationPortrait)
    {
        //
        _mainView.mainType=RectangleType;
    }
    if (orientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        //
        _mainView.mainType=RectangleType;
    }
}
- (void)reSetImageNumber{
    _mainView.imageCount=arc4random()%10+2;
}
- (void)lastShowType{
    [_mainView lastShowType];
}
- (void)nextShowType{
    [_mainView nextShowType];
}
- (void)reSetpadding
{
    _mainView.padding+=3;
    if (_mainView.padding>9) {
        _mainView.padding=0;
    }
}
- (void)reSetRadius
{
    _mainView.radius+=10;
    if (_mainView.radius>30) {
        _mainView.radius=0;
    }
}
- (void)reSetColor
{
    UIColor *color=_mainView.paddingColor;
    if (color==[UIColor blackColor]) {
        _mainView.paddingColor=[UIColor whiteColor];
    }else
    {
        _mainView.paddingColor=[UIColor blackColor];
    }
}
- (void)reMainType
{
    _mainView.mainType=_mainView.mainType?SquareType:RectangleType;
    [self viewWillLayoutSubviews];
}
-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    _mainView.center=self.view.center;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
