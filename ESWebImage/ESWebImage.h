//
//  ESWebImage.h
//  ESWebImage
//
//  Created by 翟泉 on 2016/11/9.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <UIKit/UIKit.h>

//! Project version number for ESWebImage.
FOUNDATION_EXPORT double ESWebImageVersionNumber;

//! Project version string for ESWebImage.
FOUNDATION_EXPORT const unsigned char ESWebImageVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <ESWebImage/PublicHeader.h>

#import "UIImageView+WebImage.h"
#import "UIButton+WebImage.h"

@interface ESWebImage : NSObject

@property (strong, nonatomic) NSURL *baseURL;

+ (instancetype)shared;

+ (NSURL *)URLWithURLString:(NSString *)URLString imageSize:(CGSize)size;

+ (UIImage *)placeholderWithSize:(CGSize)size;

@end





