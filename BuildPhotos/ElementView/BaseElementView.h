//
//  BaseElementView.h
//  SplicePhotoDemo
//
//  Created by 杨永强 on 2017/4/30.
//  Copyright © 2017年 杨永强. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger ,ShowType) {
    SmallSquareType,        //小正方
    SmallVRectangleType,    //小竖方
    SmallHRectangleType,    //小横方
    MiddleSquareType,       //中正方
    MiddleVRectangleType,   //中竖方
    MiddleHRectangleType,   //中横方
    BigSquareType,           //大正方
    BigSquare_MiddleHRectangleType    //大正方+中横方
};

@interface BaseElementView : UIView <UIGestureRecognizerDelegate>
@property (nonatomic,assign)ShowType type;
@property (nonatomic,assign)BOOL canPan;
@property (nonatomic,strong)UIImageView *backView;
+ (CGSize)getSizeWithType:(ShowType)type;
-(void)zoomAnimation;
@end
