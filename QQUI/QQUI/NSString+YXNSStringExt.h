//
//  NSString+YXNSStringExt.h
//  QQUI
//
//  Created by 向元新 on 15/11/11.
//  Copyright © 2015年 向元新. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (YXNSStringExt)

//对象方法
- (CGSize)sizeOfTextWithMaxSize:(CGSize)maxSize font:(UIFont *)font;


//类方法
+ (CGSize)sizeWithText:(NSString *)text maxSize:(CGSize)maxSize font:(UIFont *)font;


@end
