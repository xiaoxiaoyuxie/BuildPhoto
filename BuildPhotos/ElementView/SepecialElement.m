//
//  SepecialElement.m
//  SplicePhotoDemo
//
//  Created by 杨永强 on 2017/4/30.
//  Copyright © 2017年 杨永强. All rights reserved.
//

#import "SepecialElement.h"

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
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.backView.frame=self.bounds;
}
@end
