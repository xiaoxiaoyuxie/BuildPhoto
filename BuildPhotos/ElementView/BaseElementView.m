//
//  BaseElementView.m
//  SplicePhotoDemo
//
//  Created by 杨永强 on 2017/4/30.
//  Copyright © 2017年 杨永强. All rights reserved.
//

#import "BaseElementView.h"
#import "UIView+CLKAddition.h"
#import "MainView.h"

@implementation BaseElementView

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        self.backView=[[UIImageView alloc] initWithFrame:self.bounds];
        self.backView.userInteractionEnabled=YES;
        
        [self addSubview:self.backView];
        UILongPressGestureRecognizer *longP=[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
        longP.delegate=self;
                                             
        [self addGestureRecognizer:longP];
        
        UIPanGestureRecognizer *pan=[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(viewPaning:)];
        pan.delegate=self;
        [self addGestureRecognizer:pan];
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}
- (void)tapAction:(UITapGestureRecognizer *)tap{
    NSLog(@"点击方块");
    
    [self.superview bringSubviewToFront:self];
    [self zoomOutAnimation];
    UIAlertController *alertVC=[UIAlertController alertControllerWithTitle:@"选择功能" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *deleteAction=[UIAlertAction actionWithTitle:@"删除图片" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"%@",action.title);
    }];
    [alertVC addAction:deleteAction];
    UIAlertAction *replaceAction=[UIAlertAction actionWithTitle:@"替换图片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"%@",action.title);
    }];
    [alertVC addAction:replaceAction];
    UIAlertAction *addTopLabel=[UIAlertAction actionWithTitle:@"添加页首" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"%@",action.title);
    }];
    [alertVC addAction:addTopLabel];
    UIAlertAction *addBottomLabel=[UIAlertAction actionWithTitle:@"添加页尾" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"%@",action.title);
    }];
    [alertVC addAction:addBottomLabel];
    UIAlertAction *cancelAction=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"%@",action.title);
    }];
    [alertVC addAction:cancelAction];
    [[self getViewController] presentViewController:alertVC animated:YES completion:nil];
    
}
-(void)viewPaning:(UIPanGestureRecognizer*)pan{ //将拖动手势转移到父视图,因为本视图并不移动,真正移动的是父视图的选择框
    MainView *view=(MainView*)self.superview;
    [view viewPaning:pan];
}
-(void)longPress:(UILongPressGestureRecognizer*)longPress{
    switch (longPress.state) {
        case UIGestureRecognizerStateBegan:
        {
            self.canPan=YES;
            NSLog(@"可以拖动");
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            self.canPan=NO;
            NSLog(@"不可以拖动");
        }
            break;
        case UIGestureRecognizerStateCancelled:
        {
            
        }
            break;
        case UIGestureRecognizerStatePossible:
        {
            
        }
            break;
            
        default:
            break;
    }
}

-(void)setCanPan:(BOOL)canPan
{
    _canPan=canPan;
    MainView *view=(MainView*)self.superview;
    [view setPanType:canPan view:self];
}
-(void)setRadius:(CGFloat)radius
{
    self.backView.layer.cornerRadius=radius;
}
-(void)zoomInAnimation
{
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    
    animation.duration = 0.2;// 动画时间
    
    NSMutableArray *values = [NSMutableArray array];
    
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.8, 0.8, 1.0)]];
    
    // 这三个数字，我只研究了前两个，所以最后一个数字我还是按照它原来写1.0；前两个是控制view的大小的；
    
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.5, 1.5, 1.0)]];
    
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 1.0)]];
        
    animation.values = values;
    
    [self.layer addAnimation:animation forKey:nil];
}
-(void)zoomOutAnimation
{
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    
    animation.duration = 0.2;// 动画时间
    
    NSMutableArray *values = [NSMutableArray array];
    
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
    
    // 这三个数字，我只研究了前两个，所以最后一个数字我还是按照它原来写1.0；前两个是控制view的大小的；
    
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.7, 0.7, 1.0)]];
    
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 1.0)]];
    
    animation.values = values;
    
    [self.layer addAnimation:animation forKey:nil];
}
+ (CGSize)getSizeWithType:(ShowType)type
{
    switch (type) {
        case SmallSquareType:
            return CGSizeMake(80, 80);
            break;
        case MiddleSquareType:
            return CGSizeMake(160, 160);
            break;
        case BigSquareType:
            return CGSizeMake(320, 320);
            break;
        case SmallVRectangleType:
            return CGSizeMake(80, 160);
            break;
        case SmallHRectangleType:
            return CGSizeMake(160, 80);
            break;
        case MiddleVRectangleType:
            return CGSizeMake(160, 320);
            break;
        case MiddleHRectangleType:
            return CGSizeMake(320, 160);
            break;
        case BigSquare_MiddleHRectangleType:
            return CGSizeMake(320, 480);
            break;
            
        default:
            return CGSizeMake(80, 80);
            break;
    }
}
-(void)setType:(ShowType)type
{
    _type=type;
    self.size=[BaseElementView getSizeWithType:_type];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
