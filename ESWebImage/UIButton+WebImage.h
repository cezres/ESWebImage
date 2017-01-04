//
//  UIButton+WebImage.h
//  ESWebImage
//
//  Created by 翟泉 on 2016/11/9.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "ESWebImagePlaceholder.h"

typedef void (^ESWebImageCompleted)(UIImage *image, NSError *error, NSURL *imageURL);

@interface UIButton (WebImage)

/**
 加载网络图片
 根据视图尺寸确定图片尺寸，拼接图片地址参数
 根据视图尺寸生成占位图，如果它是NULL
 
 @param URLString        图片地址
 @param placeholderImage 占位图
 @param completedBlock   完成后回调
 */
- (void)imageWithURLString:(NSString *)URLString placeholderImage:(UIImage *)placeholderImage completed:(ESWebImageCompleted)completedBlock;
- (void)imageWithURLString:(NSString *)URLString;
- (void)imageWithURLString:(NSString *)URLString placeholderImage:(UIImage *)placeholderImage;
- (void)imageWithURLString:(NSString *)URLString completed:(ESWebImageCompleted)completedBlock;


/**
 加载网络图片
 根据传入视图尺寸拼接图片地址参数
 根据传入视图尺寸生成占位图，如果它是NULL
 
 @param URLString        图片地址
 @param size             视图尺寸
 @param placeholderImage 占位图
 @param completedBlock   完成后回调
 */
- (void)imageWithURLString:(NSString *)URLString Size:(CGSize)size placeholderImage:(UIImage *)placeholderImage completed:(ESWebImageCompleted)completedBlock;
- (void)imageWithURLString:(NSString *)URLString Size:(CGSize)size;
- (void)imageWithURLString:(NSString *)URLString Size:(CGSize)size completed:(ESWebImageCompleted)completedBlock;
- (void)imageWithURLString:(NSString *)URLString Size:(CGSize)size placeholderImage:(UIImage *)placeholderImage;


@end
