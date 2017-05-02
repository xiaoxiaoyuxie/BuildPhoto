//
//  SepecialElement.m
//  SplicePhotoDemo
//
//  Created by 杨永强 on 2017/4/30.
//  Copyright © 2017年 杨永强. All rights reserved.
//

#import "SepecialElement.h"
#import "UIView+CLKAddition.h"

@implementation SepecialElement

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)init
{
    self=[super init];
    if (self) {
        self.backgroundColor=[UIColor orangeColor];
        self.backView.hidden=YES;
    }
    return self;
}
-(void)setPadding:(CGFloat)padding
{
    [super setPadding:padding];
    self.backView.left=padding;
    self.backView.top=padding;
    self.backView.width=self.width-padding*2;
    self.backView.height=self.height-padding*2;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.backView.bounds=self.bounds;
    self.padding=self.padding;
}
@end
