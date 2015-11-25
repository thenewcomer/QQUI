//
//  messageFrames.m
//  QQUI
//
//  Created by 向元新 on 15/11/12.
//  Copyright © 2015年 向元新. All rights reserved.
//

#import "messageFrames.h"
#import <UIKit/UIKit.h>
#import "NSString+YXNSStringExt.h"

#define tableViewMargin 0
@implementation messageFrames


- (void)setModel:(messagesModel *)model
{

        _model = model;
        CGFloat margin = 5;
        //计算每个控件的frame和每行数据的行高
        //获取屏幕宽度
        CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;

    
        //计算时间的frame，根据与前一个时间对比以确定显示或者不显示.时间用lable显示
        CGFloat timeX = 0;
        CGFloat timeY = 0;
        CGFloat timeW = screenWidth;
        CGFloat timeH = 15;
    if (model.hideTime == NO) {
            _timeFrame = CGRectMake(timeX, timeY, timeW, timeH);
    }



        //计算头像的frame
        CGFloat iconW = 30;
        CGFloat iconH = 30;
        CGFloat iconX = model.isMe == YES ? (screenWidth - iconW - margin - tableViewMargin) : margin;
        CGFloat iconY = CGRectGetMaxY(_timeFrame) + margin;
    
        _iconFrame = CGRectMake(iconX, iconY, iconW, iconH);
        //计算文本的frame
        //先计算正文的frame再计算x,y
        CGSize textSize = [model.message sizeOfTextWithMaxSize:CGSizeMake(200, MAXFLOAT) font:messageFont];
        CGFloat textH = textSize.height + messageInsectTop * 2;
        CGFloat textW = textSize.width + messageInsectLeft * 2;
        CGFloat textX = model.isMe == YES ? (iconX - margin - textW) : CGRectGetMaxX(_iconFrame);
        CGFloat textY = iconY;
        _messageFrame = CGRectMake(textX, textY, textW, textH);
    
      //行高
        CGFloat maxY = MAX(CGRectGetMaxY(_iconFrame),CGRectGetMaxY(_messageFrame));
        
        _rowHeight = maxY;


    
}




@end
