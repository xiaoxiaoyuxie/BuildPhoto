//
//  ViewInfo.h
//  BuildPhotos
//
//  Created by 杨永强 on 2017/5/1.
//  Copyright © 2017年 杨永强. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BaseElementView.h"

@interface ViewInfo : NSObject
@property (nonatomic,assign)CGPoint point;
@property (nonatomic,assign)ShowType type;
-(instancetype)initWithPoint:(CGPoint)point andType:(ShowType)type;
@end
