//
//  messagesFrame.m
//  QQUI
//
//  Created by 向元新 on 15/11/9.
//  Copyright © 2015年 向元新. All rights reserved.
//

#import "messagesFrame.h"
//#import <UIKit/UIKit.h>
//#import "NSString+YXNSStringExt.h"


@implementation messagesFrame
//
//- (void)setModel:(messagesModel *)model
//{
//    _model = model;
//    CGFloat margin = 5;
//    //计算每个控件的frame和每行数据的行高
//    //获取屏幕宽度
//    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
//    
//    
//    //计算时间的frame，根据与前一个时间对比以确定显示或者不显示.时间用lable显示
//    CGFloat timeX = 0;
//    CGFloat timeY = 0;
//    CGFloat timeW = screenWidth;
//    CGFloat timeH = 15;
//    
//    _timeFrame = CGRectMake(timeX, timeY, timeW, timeH);
//    //计算头像的frame
//    CGFloat iconW = 30;
//    CGFloat iconH = 30;
//    CGFloat iconX = model.isMe == YES ? screenWidth - iconW - margin : margin;
//    CGFloat iconY = CGRectGetMaxY(_timeFrame) + margin;
//    
//    _iconFrame = CGRectMake(iconX, iconY, iconW, iconH);
//    //计算文本的frame
//    //先计算正文的frame再计算x,y
//    CGSize textSize = [model.message sizeOfTextWithMaxSize:CGSizeMake(200, MAXFLOAT) font:messageFont];
//    CGFloat textH = textSize.height;
//    CGFloat textW = textSize.width;
//    CGFloat textX = model.isMe == YES ? (screenWidth - iconW - margin - textW) : CGRectGetMaxX(_iconFrame);
//    CGFloat textY = iconY;
//    _messageFrame = CGRectMake(textX, textY, textW, textH);
//    
//  //行高
//    CGFloat maxY = MAX(CGRectGetMaxY(_iconFrame),CGRectGetMaxY(_messageFrame));
//    
//    _rowHeight = maxY;
//}
//




@end
