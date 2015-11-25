//
//  messagesModel.m
//  QQUI
//
//  Created by 向元新 on 15/11/9.
//  Copyright © 2015年 向元新. All rights reserved.
//

#import "messagesModel.h"

@implementation messagesModel



- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}


+ (instancetype)messagesModelWithDict:(NSDictionary *)dict
{
    
    return [[self alloc]initWithDict:dict];
    
}








@end
