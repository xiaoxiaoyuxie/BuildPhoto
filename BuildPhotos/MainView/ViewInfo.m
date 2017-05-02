//
//  ViewInfo.m
//  BuildPhotos
//
//  Created by 杨永强 on 2017/5/1.
//  Copyright © 2017年 杨永强. All rights reserved.
//

#import "ViewInfo.h"

@implementation ViewInfo
-(instancetype)initWithPoint:(CGPoint)point andType:(ShowType)type
{
    self=[super init];
    if (self) {
        self.point=point;
        self.type=type;
    }
    return  self;
}
@end
