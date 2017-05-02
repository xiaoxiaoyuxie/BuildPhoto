//
//  MainView.h
//  SplicePhotoDemo
//
//  Created by 杨永强 on 2017/4/30.
//  Copyright © 2017年 杨永强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseElementView.h"
typedef NS_ENUM(NSInteger, MainType) {
    SquareType,
    RectangleType
};

@interface MainView : UIView<UIGestureRecognizerDelegate>
@property (nonatomic,assign)NSInteger imageCount;
@property (nonatomic,assign)CGFloat padding;
@property (nonatomic,assign)CGFloat radius;
@property (nonatomic,strong)UIColor *paddingColor;
@property (nonatomic,assign)MainType mainType;
-(instancetype)initWithType:(MainType)type imageCount :(int)count padding:(CGFloat)padding radius:(CGFloat)radius paddingColor:(UIColor*)color;
- (void)nextShowType;
- (void)lastShowType;
- (void)setPanType:(BOOL)canPan view:(BaseElementView*)tapView;
-(void)viewPaning:(UIPanGestureRecognizer*)pan;
@end
