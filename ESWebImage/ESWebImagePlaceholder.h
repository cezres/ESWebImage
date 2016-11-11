//
//  ESWebImagePlaceholder.h
//  ESWebImage
//
//  Created by 翟泉 on 2016/11/11.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ESWebImageCompleted)(UIImage *image, NSError *error, NSURL *imageURL);

@interface ESWebImagePlaceholder : NSObject

+ (UIImage *)placeholderWithSize:(CGSize)size;

@end
