//
//  UIImage+CLKAddition.m
//  CLCommonExample
//
//  Created by wangdg on 14-4-15.
//  Copyright (c) 2014年 Culiu. All rights reserved.
//

#import "UIImage+CLKAddition.h"

@implementation UIImage (CLKAddition)

+ (UIImage *)imageNamed:(NSString *)name withColor:(UIColor *)color
{
    // load the image
    UIImage *img = [UIImage imageNamed:name];
    
    // begin a new image context, to draw our colored image onto
    UIGraphicsBeginImageContext(img.size);
    
    // get a reference to that context we created
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // set the fill color
    [color setFill];
    
    // translate/flip the graphics context (for transforming from CG* coords to UI* coords
    CGContextTranslateCTM(context, 0, img.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    // set the blend mode to color burn, and the original image
    CGContextSetBlendMode(context, kCGBlendModeColorBurn);
    CGRect rect = CGRectMake(0, 0, img.size.width, img.size.height);
    CGContextDrawImage(context, rect, img.CGImage);
    
    // set a mask that matches the shape of the image, then draw (color burn) a colored rectangle
    CGContextClipToMask(context, rect, img.CGImage);
    CGContextAddRect(context, rect);
    CGContextDrawPath(context,kCGPathFill);
    
    // generate a new UIImage from the graphics context we drew onto
    UIImage *coloredImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //return the color-burned image
    return coloredImg;
}

+ (UIImage *)imageForPNGNocacheWithName:(NSString *)name
{
    NSString *imageName = nil;
    // retina display
    if ([[UIScreen mainScreen] respondsToSelector:@selector(displayLinkWithTarget:selector:)] &&
        ([UIScreen mainScreen].scale == 2.0)) {
        imageName = [NSString stringWithFormat:@"%@@2x.png", name];
    } else {
        imageName = [NSString stringWithFormat:@"%@.png", name];
    }
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:imageName ofType:@""];
    NSData *data = [NSData dataWithContentsOfFile:imagePath];
    return [UIImage imageWithData:data scale:[UIScreen mainScreen].scale];
}
+(UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize
{
    //设置图片尺寸
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width*scaleSize,image.size.height*scaleSize));
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height *scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //对图片包得大小进行压缩
    NSData *imageData = UIImageJPEGRepresentation(scaledImage,0.0001);
    UIImage *m_selectImage = [UIImage imageWithData:imageData];
    return m_selectImage;
}
@end
