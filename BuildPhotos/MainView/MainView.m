//
//  MainView.m
//  SplicePhotoDemo
//
//  Created by 杨永强 on 2017/4/30.
//  Copyright © 2017年 杨永强. All rights reserved.
//

#import "MainView.h"
#import "DefaultElement.h"
#import "SepecialElement.h"
#import "UIView+CLKAddition.h"
#import "UIImage+CLKAddition.h"
#import "ViewInfo.h"

@implementation MainView
{
    NSMutableArray *_viewArray;
    NSMutableArray *_showTypesArray;
    NSMutableArray *_subShowTypeArray;
    int _showTypeIndex;
    DefaultElement *_mainView;
    int _spliteType;
    UIView *_panBoundsView;
    CGPoint _startPoint;
    CGPoint _endPoint;
    BaseElementView *_tapView;
}

-(instancetype)initWithType:(MainType)type imageCount :(int)count padding:(CGFloat)padding radius:(CGFloat)radius paddingColor:(UIColor*)color
{
    self=[super init];
    if (self) {
        _imageCount=count;
//        if (_imageCount<2) {
//            _imageCount=2; //最少为两张
//        }
        _mainType=type;
        _padding=padding;
        _radius=radius;
        _paddingColor=color;
        _viewArray=[NSMutableArray array];
        _mainView=[[DefaultElement alloc] init];
        
        _panBoundsView=[[UIView alloc] init];
        _panBoundsView.backgroundColor=[UIColor clearColor];
        [self addSubview:_panBoundsView];
        
        self.clipsToBounds=YES;
        [self getTypesArray];
        

    }
    return self;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}
-(void)setPanType:(BOOL)canPan view:(DefaultElement*)tapView
{
    _tapView=tapView;
    if (canPan) {
        _panBoundsView.layer.borderColor=[UIColor blueColor].CGColor;
        _panBoundsView.layer.borderWidth=3;
        _panBoundsView.frame=tapView.frame;
        [self bringSubviewToFront:_panBoundsView];
        tapView.backScrollView.scrollEnabled=NO;
    }else
    {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{ //为了等动画结束
            _panBoundsView.layer.borderColor=[UIColor clearColor].CGColor;
            _panBoundsView.layer.borderWidth=0;
            _panBoundsView.frame=CGRectMake(0, 0, 0, 0);
        });
        tapView.backScrollView.scrollEnabled=YES;
    }
}
-(void)viewPaning:(UIPanGestureRecognizer*)pan{
    NSLog(@"视图正在拖动");
    CGPoint point = [pan translationInView:self];
//    return;
    _panBoundsView.center = CGPointMake(_panBoundsView.center.x + point.x, _panBoundsView.center.y + point.y);
    [pan setTranslation:CGPointMake(0, 0) inView:self];
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
        {
            _startPoint=_tapView.origin;
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            for (DefaultElement *view in _viewArray) {
                if (CGRectContainsPoint(view.frame, _panBoundsView.center)&&_tapView&&view!=_tapView) {
                    [UIView animateWithDuration:0.2 animations:^{
                        _panBoundsView.frame=view.frame;
                        ShowType tempType=view.type;
                        _endPoint=view.origin;
                        view.frame=_tapView.frame;
                        view.type=_tapView.type;
                        [view layoutSubviews];
                        _tapView.frame=_panBoundsView.frame;
                        _tapView.type=tempType;
                        [_tapView layoutSubviews];
                        [_tapView zoomInAnimation];
                        [view zoomOutAnimation];
                    }];
                    return;
                }
            }
            _tapView=nil;
            [UIView animateWithDuration:0.2 animations:^{
                _panBoundsView.origin=_startPoint;
            }];
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
-(void)reSetMainView
{
    [_viewArray removeAllObjects];
    _mainView.origin=CGPointZero;
    if (_mainType==SquareType) {
        _mainView.type=BigSquareType;
        self.width=self.height=320;
    }else
    {
        _mainView.type=BigSquare_MiddleHRectangleType;
        self.width=320;
        self.height=self.width/2*3;
    }
    
    [_viewArray addObject:_mainView];
    [self removeAllSubviews];
    _panBoundsView=[[UIView alloc] init];
    _panBoundsView.backgroundColor=[UIColor clearColor];
    [self addSubview:_panBoundsView];
    [self spliteView:_mainView withType:_spliteType];
}
-(void)setImageCount:(NSInteger)imageCount
{
    _imageCount=imageCount;
    [self reSetMainView];
    [self getTypesArray];
}
- (void)getTypesArray
{
    _showTypesArray=[NSMutableArray array];
    _spliteType=0;
    for (int i=1; i<6; i++) {
        _subShowTypeArray=[NSMutableArray array];
        _spliteType=i;
        [_viewArray removeAllObjects];
        _mainView.origin=CGPointZero;
        if (_mainType==SquareType) {
            _mainView.type=BigSquareType;
            self.width=self.height=320;
        }else
        {
            _mainView.type=BigSquare_MiddleHRectangleType;
            self.width=320;
            self.height=self.width/2*3;
        }
        
        [_viewArray addObject:_mainView];
        [self spliteView:_mainView withType:_spliteType];
        [_showTypesArray addObject:_subShowTypeArray];
        
    }
    [self layoutSubview];
}
- (void)layoutSubview
{
    DefaultElement *view;
    [UIView beginAnimations:@"FrameAni" context:nil];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationRepeatCount:1];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    int maxWidth = 0;
    int maxHeight = 0;
    for (int i=0; i<_viewArray.count; i++) {
        view=_viewArray[i];
        if (![self.subviews containsObject:view]) {
            [self addSubview:view];
        }
        if (_showTypesArray.count) {
            ViewInfo *info=_showTypesArray[_showTypeIndex][i];
            if (info) {
                view.origin=info.point;
                view.type=info.type;
                if (view.right>maxWidth) {
                    maxWidth=view.right;
                }
                if (view.bottom>maxHeight) {
                    maxHeight=view.bottom;
                }
            }
        }
        
        UIImage *image=[UIImage imageNamed:[NSString stringWithFormat:@"%d",i+1]];
        image=[UIImage scaleImage:image toScale:0.4];  //图片压缩
        view.backView.image=image;
        view.padding=self.padding;
        view.radius=self.radius;
        view.backView.clipsToBounds=YES;
        [view zoomInAnimation];
    }
    [UIView commitAnimations];
    self.width=maxWidth;
    self.height=maxHeight;
    self.center=self.superview.center;
}
-(void)setMainType:(MainType)mainType
{
    _mainType=mainType;
    [self reSetMainView];
    [self getTypesArray];
}
- (void)nextShowType
{
    _showTypeIndex++;
    if (_showTypeIndex==_showTypesArray.count) {
        _showTypeIndex=0;
    }
    [self layoutSubview];
}
- (void)lastShowType
{
    _showTypeIndex--;
    if (_showTypeIndex<0) {
        _showTypeIndex=(int)_showTypesArray.count-1;
    }
    [self layoutSubview];
}
-(void)setPadding:(CGFloat)padding
{
    _padding=padding;
    [self layoutSubview];
}
-(void)setRadius:(CGFloat)radius
{
    _radius=radius;
    [self layoutSubview];
}
-(void)setPaddingColor:(UIColor *)paddingColor
{
    _paddingColor=paddingColor;
    self.backgroundColor=paddingColor;
}


- (void)spliteView:(BaseElementView *)view withType:(int)type
{
    BaseElementView *newView;
    //    if (_imageCount==1) {
    //        _imageCount=2;
    //        newView=[[SepecialElement alloc] init];
    //    }else
    //    {
    newView=[[DefaultElement alloc] init];
    //    }
    if (_viewArray.count==_imageCount) { //跳出递归
        return;
    }
    switch (view.type) {
            
        case BigSquare_MiddleHRectangleType:
        {
            if (type==1) {
                view.type= BigSquareType;
                newView.origin=CGPointMake(view.left, view.bottom);
                newView.type=MiddleHRectangleType;
            }else
            {
                
                view.type=MiddleHRectangleType;
                newView.origin=CGPointMake(view.left, view.bottom);
                newView.type=BigSquareType;
                if (type==4) {
                    view.type= BigSquareType;
                    newView.origin=CGPointMake(view.left, view.bottom);
                    newView.type=MiddleHRectangleType;
                }
            }
            
            if (_viewArray.count==1) {
                ViewInfo *info=[[ViewInfo alloc] initWithPoint:view.origin andType:view.type];
                [_subShowTypeArray addObject:info];
            }
            
            ViewInfo *info=[_subShowTypeArray lastObject];
            info.type=view.type;
            
            info=[[ViewInfo alloc] initWithPoint:newView.origin andType:newView.type];
            [_subShowTypeArray addObject:info];
        }
            break;
        case BigSquareType:
        {
            if (type==2) {
                view.type=MiddleHRectangleType;
                newView.origin=CGPointMake(view.left, view.bottom);
                newView.type=MiddleHRectangleType;
            }else
                
            {
                view.type=MiddleVRectangleType;
                newView.origin=CGPointMake(view.right, view.top);
                newView.type=MiddleVRectangleType;
                if (type!=4) {
                    view.type=MiddleVRectangleType;
                    newView.origin=CGPointMake(view.right, view.top);
                    newView.type=MiddleVRectangleType;
                }
                
            }
            
            
            if (_viewArray.count==1) {
                ViewInfo *info=[[ViewInfo alloc] initWithPoint:view.origin andType:view.type];
                [_subShowTypeArray addObject:info];
            }
            
            ViewInfo *info=[_subShowTypeArray lastObject];
            info.type=view.type;
            
            info=[[ViewInfo alloc] initWithPoint:newView.origin andType:newView.type];
            [_subShowTypeArray addObject:info];
        }
            break;
        case MiddleVRectangleType:
        {
            view.type=MiddleSquareType;
            newView.origin=CGPointMake(view.left, view.bottom);
            newView.type=MiddleSquareType;
            
            ViewInfo *info=[_subShowTypeArray lastObject];
            info.type=view.type;
            
            info=[[ViewInfo alloc] initWithPoint:newView.origin andType:newView.type];
            [_subShowTypeArray addObject:info];
        }
            break;
        case MiddleHRectangleType:
        {
            view.type=MiddleSquareType;
            newView.origin=CGPointMake(view.right, view.top);
            newView.type=MiddleSquareType;
            
            ViewInfo *info=[_subShowTypeArray lastObject];
            info.type=view.type;
            
            info=[[ViewInfo alloc] initWithPoint:newView.origin andType:newView.type];
            [_subShowTypeArray addObject:info];
        }
            break;
        case MiddleSquareType:
        {
            if (type==3) {
                view.type=SmallHRectangleType;
                newView.origin=CGPointMake(view.left, view.bottom);
                newView.type=SmallHRectangleType;
            }else
            {
                
                view.type=SmallVRectangleType;
                newView.origin=CGPointMake(view.right, view.top);
                newView.type=SmallVRectangleType;
                if (type==4) {
                    view.type=SmallHRectangleType;
                    newView.origin=CGPointMake(view.left, view.bottom);
                    newView.type=SmallHRectangleType;
                }
            }
            
            
            ViewInfo *info=[_subShowTypeArray lastObject];
            info.type=view.type;
            
            info=[[ViewInfo alloc] initWithPoint:newView.origin andType:newView.type];
            [_subShowTypeArray addObject:info];
        }
            break;
            
        case SmallVRectangleType:
        {
            view.type=SmallSquareType;
            newView.origin=CGPointMake(view.left, view.bottom);
            newView.type=SmallSquareType;
            
            ViewInfo *info=[_subShowTypeArray lastObject];
            info.type=view.type;
            
            info=[[ViewInfo alloc] initWithPoint:newView.origin andType:newView.type];
            [_subShowTypeArray addObject:info];
        }
            break;
        case SmallHRectangleType:
        {
            view.type=SmallSquareType;
            newView.origin=CGPointMake(view.right, view.top);
            newView.type=SmallSquareType;
            
            ViewInfo *info=[_subShowTypeArray lastObject];
            info.type=view.type;
            
            info=[[ViewInfo alloc] initWithPoint:newView.origin andType:newView.type];
            [_subShowTypeArray addObject:info];
        }
            break;
            
        case SmallSquareType:
        {
            DefaultElement *view=[self getMaxViewWithType:type];
            ViewInfo *info=[[ViewInfo alloc] initWithPoint:view.origin andType:view.type];
            [_subShowTypeArray addObject:info];
            [self spliteView:view withType:type];
        }
            break;
            
        default:
            
            break;
    }
    
    if (_viewArray.count<_imageCount) {
        
        [_viewArray addObject:newView];
    }
    //    if (type==4) {
    //        [self spliteView:view withType:type];
    //    }else
    //    {
    [self spliteView:newView withType:type];
    //    }
}
 //获取剩余最大视图
- (DefaultElement *)getMaxViewWithType:(int)type
{
    int maxIndex = 0;
    DefaultElement * returnView;
    for (DefaultElement * view in _viewArray) {
        if (view.type>maxIndex) {
            maxIndex=view.type;
            if (type==5) {
                break;
            }
        }
    }
    for (DefaultElement * view in _viewArray) {
        if (maxIndex==view.type) {
            returnView = view;
            break;
        }
    }
    [self removeMaxTypeWithView:returnView];
    return returnView;
}
//  从样式列表中移除最大视图的 frame
- (void)removeMaxTypeWithView:(DefaultElement *)view
{
    for (ViewInfo *info in _subShowTypeArray) {
        CGSize size=[BaseElementView getSizeWithType:view.type];
        if (info.point.x==view.left&&info.point.y==view.top&&size.width==view.width&&size.height==view.height) {
            [_subShowTypeArray removeObject:info];
            break;
        }
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
