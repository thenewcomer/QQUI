//
//  messagesModel.h
//  QQUI
//
//  Created by 向元新 on 15/11/9.
//  Copyright © 2015年 向元新. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface messagesModel : NSObject

@property(nonatomic, copy) NSString *time;

@property(nonatomic, copy) NSString *message;

@property(nonatomic, assign) BOOL isMe;

@property(nonatomic, assign) BOOL hideTime;

-(instancetype)initWithDict:(NSDictionary *)dict;

+(instancetype)messagesModelWithDict:(NSDictionary *)dict;

@end
