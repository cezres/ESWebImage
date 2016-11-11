//
//  UIButton+WebImage.m
//  ESWebImage
//
//  Created by 翟泉 on 2016/11/9.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "UIButton+WebImage.h"
#import <objc/runtime.h>
#import <UIButton+WebCache.h>

@implementation UIButton (WebImage)

+ (void)load; {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL originalSelector = @selector(layoutSubviews);
        SEL swizzledSelector = @selector(wi_layoutSubviews);
        Method originalMethod = class_getInstanceMethod([self class], originalSelector);
        Method swizzledMethod = class_getInstanceMethod([self class], swizzledSelector);
        if (class_addMethod([self class],originalSelector,method_getImplementation(swizzledMethod),method_getTypeEncoding(swizzledMethod))) {
            class_replaceMethod([self class],swizzledSelector,method_getImplementation(originalMethod),method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}
- (void)wi_layoutSubviews; {
    [self wi_layoutSubviews];
    
    if (self.wi_urlString) {
        [self imageWithURLString:self.wi_urlString Size:self.frame.size placeholderImage:self.wi_placeholderImage completed:self.wi_completedBlock];
        self.wi_urlString = NULL;
        self.wi_completedBlock = NULL;
        self.wi_placeholderImage = NULL;
    }
}


- (void)imageWithURLString:(NSString *)URLString; {
    [self imageWithURLString:URLString completed:NULL];
}
- (void)imageWithURLString:(NSString *)URLString placeholderImage:(UIImage *)placeholderImage; {
    [self imageWithURLString:URLString placeholderImage:placeholderImage completed:NULL];
}
- (void)imageWithURLString:(NSString *)URLString completed:(ESWebImageCompleted)completedBlock; {
    [self imageWithURLString:URLString placeholderImage:NULL completed:completedBlock];
}
- (void)imageWithURLString:(NSString *)URLString placeholderImage:(UIImage *)placeholderImage completed:(ESWebImageCompleted)completedBlock; {
    if (CGSizeEqualToSize(self.frame.size, CGSizeZero)) {
        [self layoutIfNeeded];
    }
    if (CGSizeEqualToSize(self.frame.size, CGSizeZero)) {
        self.wi_urlString = URLString;
        self.wi_placeholderImage = placeholderImage;
        self.wi_completedBlock = completedBlock;
    }
    else {
        self.wi_urlString = NULL;
        self.wi_completedBlock = NULL;
        self.wi_placeholderImage = NULL;
        [self imageWithURLString:URLString Size:self.frame.size placeholderImage:placeholderImage completed:completedBlock];
    }
}



- (void)imageWithURLString:(NSString *)URLString Size:(CGSize)size; {
    [self imageWithURLString:URLString Size:size placeholderImage:NULL completed:NULL];
}
- (void)imageWithURLString:(NSString *)URLString Size:(CGSize)size completed:(ESWebImageCompleted)completedBlock; {
    [self imageWithURLString:URLString Size:size placeholderImage:NULL completed:completedBlock];
}
- (void)imageWithURLString:(NSString *)URLString Size:(CGSize)size placeholderImage:(UIImage *)placeholderImage; {
    [self imageWithURLString:URLString Size:size placeholderImage:placeholderImage completed:NULL];
}
- (void)imageWithURLString:(NSString *)URLString Size:(CGSize)size placeholderImage:(UIImage *)placeholderImage completed:(ESWebImageCompleted)completedBlock; {
    CGSize imageSize = CGSizeMake(size.width * [UIScreen mainScreen].scale, size.height * [UIScreen mainScreen].scale);
    if (!URLString) {
        URLString = @"";
    }
    if (!placeholderImage) {
        placeholderImage = [ESWebImagePlaceholder placeholderWithSize:imageSize];
    }
    if (![URLString hasPrefix:@"http"]) {
        URLString = [@"http://img.d2c.cn" stringByAppendingPathComponent:URLString];
        URLString = [URLString stringByAppendingString:@"!/format/webp"];
        if (!CGSizeEqualToSize(imageSize, CGSizeZero)) {
            URLString = [URLString stringByAppendingFormat:@"/both/%dx%d", (int)imageSize.width, (int)imageSize.height];
        }
    }
    [self sd_setImageWithURL:[NSURL URLWithString:URLString] forState:UIControlStateNormal placeholderImage:placeholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        completedBlock(image, error, imageURL);
    }];
}




- (NSString *)wi_urlString {
    return objc_getAssociatedObject(self, @"wi_urlString");
}
- (void)setWi_urlString:(NSString *)wi_urlString {
    objc_setAssociatedObject(self, @"wi_urlString", wi_urlString, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (ESWebImageCompleted)wi_completedBlock {
    return objc_getAssociatedObject(self, @"wi_completedBlock");
}
- (void)setWi_completedBlock:(ESWebImageCompleted)wi_completedBlock {
    objc_setAssociatedObject(self, @"wi_completedBlock", wi_completedBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (UIImage *)wi_placeholderImage {
    return objc_getAssociatedObject(self, @"wi_placeholderImage");
}
- (void)setWi_placeholderImage:(UIImage *)wi_placeholderImage {
    objc_setAssociatedObject(self, @"wi_placeholderImage", wi_placeholderImage, OBJC_ASSOCIATION_COPY_NONATOMIC);
}


@end



