//
//  UIImage+CLKAddition.h
//  CLCommonExample
//
//  Created by wangdg on 14-4-15.
//  Copyright (c) 2014年 Culiu. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface UIImage (CLKAddition)

/**
 Creates and returns a image object using the specified image and color.
 
 @author Chadwick Wood
 @sa https://coffeeshopped.com/2010/09/iphone-how-to-dynamically-color-a-uiimage
 
 @param name The image name
 @param color The image color
 
 @return A image with the specified color.
 */
+ (UIImage *)imageNamed:(NSString *)name withColor:(UIColor *)color;

/**
 Returns the image object associated with the specified filename.
 The image will not be cached
 
 @param name The image name
 
 @return The image object
 */
+ (UIImage *)imageForPNGNocacheWithName:(NSString *)name;

@end
