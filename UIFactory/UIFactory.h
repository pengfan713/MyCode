//
//  UIfactory.h
//  Yao
//
//  Created by Geng_xiao_jun on 13-10-20.
//  Copyright (c) 2013年 sky one. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIViewExt.h"
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"

#define MyQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

#define ScreenWidth  [UIScreen mainScreen].bounds.size.width
#define ScreenHeight  [UIScreen mainScreen].bounds.size.height

#define verson [[[UIDevice currentDevice] systemVersion] floatValue]

#define KEYWINDOW [UIApplication sharedApplication].keyWindow

#define UIColorFromRGB(rgbValue) \
[UIColor colorWithRed:((rgbValue >> 16) & 0xFF)/255.f \
green:((rgbValue >> 8) & 0xFF)/255.f \
blue:(rgbValue & 0xFF)/255.f \
alpha:1.0f]

#define UIColorLAN UIColorFromRGB(0xFFFFFF)

@interface UIFactory : NSObject<UITextFieldDelegate>


+ (BOOL)isMobileNumber:(NSString *)mobileNum;

+ (BOOL)isValidateEmail:(NSString *)email;

+ (BOOL) isBlankString:(NSString *)string;

+ (BOOL) isUserBlankString:(NSString *)string;

+ (CGFloat)sizeWithString:(NSString *)string font:(UIFont *)font withSizeWidth:(CGFloat)width andHeight:(CGFloat)height;

+ (CGFloat)contentHeightWithText:(NSString*)text withFont:(float)thefont withLabelWidth:(float)width;

+ (CGFloat)contentWidthWithText:(NSString*)text withFont : (float)theFont;


@end
