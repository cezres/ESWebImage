//
//  ESWebImagePlaceholder.m
//  ESWebImage
//
//  Created by 翟泉 on 2016/11/11.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "ESWebImagePlaceholder.h"

@implementation ESWebImagePlaceholder

+ (UIImage *)placeholderWithSize:(CGSize)size {
    if (CGSizeEqualToSize(size, CGSizeZero)) {
        return NULL;
    }
    
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSString *bundlePath = [bundle pathForResource:@"resource" ofType:@"bundle"];
    bundle = [NSBundle bundleWithPath:bundlePath];
    NSString *imagePath = [bundle pathForResource:@"placeholder" ofType:@"png"];
    
    static UIImage *placeholder;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        placeholder = [UIImage imageWithContentsOfFile:imagePath];
    });
    
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(context, 1, 1, 1, 1.0);
    CGContextSetLineWidth(context, size.height);
    CGPoint strokeSegments[2] = {CGPointMake(0, size.height/2), CGPointMake(size.width, size.height/2)};
    CGContextStrokeLineSegments(context, strokeSegments, 2);
    
    CGRect rect;
    if (size.width / placeholder.size.width * placeholder.size.height > size.height) {
        CGFloat width = placeholder.size.width * size.height*0.5 / placeholder.size.height;
        rect = CGRectMake((size.width - width)/2,
                          size.height*0.25,
                          width,
                          size.height*0.5);
    }
    else {
        CGFloat height = placeholder.size.height * size.width*0.5 / placeholder.size.width;
        rect = CGRectMake(size.width*0.25,
                          (size.height-height)/2,
                          size.width*0.5,
                          height);
    }
    
    [placeholder drawInRect:rect];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
