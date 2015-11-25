//
//  NSString+YXNSStringExt.m
//  QQUI
//
//  Created by 向元新 on 15/11/11.
//  Copyright © 2015年 向元新. All rights reserved.
//

#import "NSString+YXNSStringExt.h"

@implementation NSString (YXNSStringExt)



- (CGSize)sizeOfTextWithMaxSize:(CGSize)maxSize font:(UIFont *)font
{
    NSDictionary *attr = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size;
}


+ (CGSize)sizeWithText:(NSString *)text maxSize:(CGSize)maxSize font:(UIFont *)font
{
    
   return  [text sizeOfTextWithMaxSize:maxSize font:font];
}


@end
