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
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.backView.frame=self.bounds;
    self.padding=_padding;
}
-(void)setPadding:(CGFloat)padding
{
    _padding=padding;
    self.backView.left=padding;
    self.backView.top=padding;
    self.backView.width=self.width-padding*2;
    self.backView.height=self.height-padding*2;
}

@end
