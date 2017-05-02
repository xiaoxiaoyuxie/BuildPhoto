//
//  UIColor+CLKAddition.m
//  CLCommonExample
//
//  Created by wangdg on 14-4-15.
//  Copyright (c) 2014年 Culiu. All rights reserved.
//

#import "UIColor+CLKAddition.h"

@implementation UIColor (CLKAddition)

+ (UIColor *)colorWithRGB:(int)aRGB
{
    int sRed   = (aRGB >> 16) & 0xff;
    int sGreen = (aRGB >>  8) & 0xff;
    int sBlue  = (aRGB      ) & 0xff;
    
    return [UIColor colorWithRed:((CGFloat)sRed / 0xff) green:((CGFloat)sGreen / 0xff) blue:((CGFloat)sBlue / 0xff) alpha:1.0];
}

+ (UIColor *)colorWithRGB:(int)aRGB WithAlpha:(CGFloat)aAlpha
{
    int sRed   = (aRGB >> 16) & 0xff;
    int sGreen = (aRGB >>  8) & 0xff;
    int sBlue  = (aRGB      ) & 0xff;
	
    return [UIColor colorWithRed:((CGFloat)sRed / 0xff) green:((CGFloat)sGreen / 0xff) blue:((CGFloat)sBlue / 0xff) alpha:aAlpha];
}

@end
