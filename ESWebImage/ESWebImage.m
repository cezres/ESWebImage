//
//  ESWebImage.m
//  ESWebImage
//
//  Created by 翟泉 on 2017/1/4.
//  Copyright © 2017年 云之彼端. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ESWebImage.h"

@implementation ESWebImage

+ (instancetype)shared {
    static id object;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        object = [[ESWebImage alloc] init];
    });
    return object;
}

+ (NSURL *)URLWithURLString:(NSString *)URLString imageSize:(CGSize)size {
    CGSize imageSize = CGSizeMake(size.width * [UIScreen mainScreen].scale, size.height * [UIScreen mainScreen].scale);
    if ([URLString hasPrefix:@"http"]) {
        return [NSURL URLWithString:URLString];
    }
    else {
        URLString = [NSString stringWithFormat:@"%@!/format/webp", URLString];
        if (size.width > 0 && size.height > 0) {
            URLString = [URLString  stringByAppendingFormat:@"/both/%dx%d", (int)imageSize.width, (int)imageSize.height];
        }
        return [NSURL URLWithString:URLString relativeToURL:[ESWebImage shared].baseURL];
    }
}

+ (UIImage *)placeholderWithSize:(CGSize)size {
    if (CGSizeEqualToSize(size, CGSizeZero)) {
        return NULL;
    }
    CGSize imageSize = CGSizeMake(size.width * [UIScreen mainScreen].scale, size.height * [UIScreen mainScreen].scale);
    
    static UIImage *placeholder;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSBundle *bundle = [NSBundle bundleForClass:[self class]];
        NSString *bundlePath = [bundle pathForResource:@"resource" ofType:@"bundle"];
        bundle = [NSBundle bundleWithPath:bundlePath];
        NSString *imagePath = [bundle pathForResource:@"placeholder" ofType:@"png"];
        placeholder = [UIImage imageWithContentsOfFile:imagePath];
    });
    
    UIGraphicsBeginImageContext(imageSize);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(context, 1, 1, 1, 1.0);
    CGContextSetLineWidth(context, imageSize.height);
    CGPoint strokeSegments[2] = {CGPointMake(0, imageSize.height/2), CGPointMake(imageSize.width, imageSize.height/2)};
    CGContextStrokeLineSegments(context, strokeSegments, 2);
    
    CGRect rect;
    if (imageSize.width / placeholder.size.width * placeholder.size.height > imageSize.height) {
        CGFloat width = placeholder.size.width * imageSize.height*0.5 / placeholder.size.height;
        rect = CGRectMake((imageSize.width - width)/2,
                          imageSize.height*0.25,
                          width,
                          imageSize.height*0.5);
    }
    else {
        CGFloat height = placeholder.size.height * imageSize.width*0.5 / placeholder.size.width;
        rect = CGRectMake(imageSize.width*0.25,
                          (imageSize.height-height)/2,
                          imageSize.width*0.5,
                          height);
    }
    [placeholder drawInRect:rect];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end



