//
//  UIfactory.m
//  Yao
//
//  Created by Geng_xiao_jun on 13-10-20.
//  Copyright (c) 2013年 sky one. All rights reserved.
//

#import "UIFactory.h"


@implementation UIFactory

#pragma mark - 验证手机号
+ (BOOL)isMobileNumber:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188,1705
     * 联通：130,131,132,152,155,156,185,186,1709
     * 电信：133,1349,153,180,189,1700
     */
    //    NSString * MOBILE = @"^1((3//d|5[0-35-9]|8[025-9])//d|70[059])\\d{7}$";//总况
    
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188，1705
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d|705)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186,1709
     17         */
    NSString * CU = @"^1((3[0-2]|5[256]|8[56])\\d|709)\\d{7}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189,1700
     22         */
    NSString * CT = @"^1((33|53|8[09])\\d|349|700)\\d{7}$";
    
    
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    
    //    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    NSPredicate *regextestphs = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",PHS];
    
    if (([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES)
        || ([regextestphs evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

#pragma mark - 验证邮箱地址
+(BOOL)isValidateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

#pragma mark - 获取当前时间
+(NSString*)getTimeByString:(long )number{

    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd"];
 
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:number];
 
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
   

    return confromTimespStr;

}

#pragma mark - 判断字符串是否为空
+(BOOL) isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }

    return NO;
}
+(BOOL) isUserBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

#pragma mark - 根据传入字符串返回ViewFrame
+(CGFloat)sizeWithString:(NSString *)string
                    font:(UIFont *)font
           withSizeWidth:(CGFloat)width
               andHeight:(CGFloat)height {
    
    CGRect rect = [string boundingRectWithSize:CGSizeMake(width, MAXFLOAT)//限制最大的宽度和高度
                                       options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin//采用换行模式
                                    attributes:@{NSFontAttributeName: font}//传人的字体字典
                                       context:nil];
    
    
    return width == 0 ? rect.size.width : rect.size.height;
}

+(CGFloat)contentHeightWithText:(NSString*)text withFont:(float)thefont withLabelWidth:(float)width
{
    NSInteger ch;
    
    UIFont *font = [UIFont systemFontOfSize:thefont];
    
    CGSize size = CGSizeMake(width, MAXFLOAT);
    
    if (verson >= 7.0)
    {
        NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName,nil];
        
        size = [text boundingRectWithSize:size  options:NSStringDrawingUsesLineFragmentOrigin attributes:tdic context:nil].size;
    }
    else
    {
        size = [text sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
        
    }
    
    ch = size.height;
    
    return ch;
}
+ (CGFloat)contentWidthWithText:(NSString*)text withFont : (float)theFont
{
    NSInteger ch;
    
    UIFont *font = [UIFont systemFontOfSize:theFont];
    
    CGSize size = CGSizeMake(MAXFLOAT, 20);
    
    if (verson >= 7.0)
    {
        NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName,nil];
        
        size = [text boundingRectWithSize:size  options:NSStringDrawingUsesLineFragmentOrigin attributes:tdic context:nil].size;
    }
    else
    {
        size = [text sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
        
    }
    
    ch = size.width;
    
    return ch;
}


@end
