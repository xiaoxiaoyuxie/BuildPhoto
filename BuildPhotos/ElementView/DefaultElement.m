//
//  DefaultElement.m
//  SplicePhotoDemo
//
//  Created by 杨永强 on 2017/4/30.
//  Copyright © 2017年 杨永强. All rights reserved.
//

#import "DefaultElement.h"
#import "UIView+CLKAddition.h"

@implementation DefaultElement

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)init
{
    self=[super init];
    if (self) {
        self.backScrollView=[[UIScrollView alloc] initWithFrame:self.bounds];
        [self.backScrollView addSubview:self.backView]; //改变层级关系
        [self addSubview:self.backScrollView];
    }
    return self;
}

-(void)setPadding:(CGFloat)padding
{
    [super setPadding:padding];
    self.backScrollView.left=padding;
    self.backScrollView.top=padding;
    self.backScrollView.width=self.width-padding*2;
    self.backScrollView.height=self.height-padding*2;
}
-(void)setRadius:(CGFloat)radius
{
    self.backScrollView.layer.cornerRadius=radius;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    [self.backView sizeToFit];
    [self scaleImageView];
    self.backScrollView.contentSize=self.backView.size;
    self.padding=self.padding;
}
- (void)scaleImageView
{
    if (self.type==SmallHRectangleType||self.type==MiddleHRectangleType) {
        self.backView.height=(self.backView.height*self.backScrollView.width)/self.backView.width;
        self.backView.width=self.backScrollView.width;
    }else if (self.type==SmallVRectangleType||self.type==MiddleVRectangleType){
        self.backView.width=(self.backView.width*self.backScrollView.height)/self.backView.height;
        self.backView.height=self.backScrollView.height;
    }else
    {
        if (self.backView.width>self.backView.height) {
            
            self.backView.width=(self.backView.width*self.backScrollView.height)/self.backView.height;
            self.backView.height=self.backScrollView.height;
        }else
        {
            
            self.backView.height=(self.backView.height*self.backScrollView.width)/self.backView.width;
            self.backView.width=self.backScrollView.width;
        }
    }

}
@end
