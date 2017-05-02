//
//  UIColor+CLKAddition.h
//  CLCommonExample
//
//  Created by wangdg on 14-4-15.
//  Copyright (c) 2014年 Culiu. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface UIColor (CLKAddition)

/**
 Creates and returns a color object using the specified hexadecimal int.
 
 @param aRGB The hexadecimal int like 0x121212
 
 @return The color object.
 */
+ (UIColor *)colorWithRGB:(int)aRGB;

/**
 Creates and returns a color object using the specified hexadecimal int and opacity.
 
 @param aRGB The hexadecimal int like 0x121212
 @param aAlpha The opacity value of the color object, specified as a value from 0.0 to 1.0.
 
 @return The color object.
 */
+ (UIColor *)colorWithRGB:(int)aRGB WithAlpha:(CGFloat)aAlpha;

@end
