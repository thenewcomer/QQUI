//
//  QQUIMessageCell.m
//  QQUI
//
//  Created by 向元新 on 15/11/11.
//  Copyright © 2015年 向元新. All rights reserved.
//

#import "QQUIMessageCell.h"


@interface QQUIMessageCell()

@property(nonatomic, weak)UILabel *timeLabel;
@property(nonatomic, weak)UIImageView *iconImage;
@property(nonatomic, weak)UIButton *textBtn;

@end




@implementation QQUIMessageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
   if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //创建子控件
        //时间label
        UILabel *lblTime = [[UILabel alloc]init];
       //设置文字居中
       lblTime.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:lblTime];
        _timeLabel = lblTime;
        
        //头像
        UIImageView *imgIcon = [[UIImageView alloc]init];
        [self.contentView addSubview:imgIcon];
        _iconImage = imgIcon;
        
        //文字
        UIButton *btnText = [[UIButton alloc]init];
        btnText.titleLabel.font = messageFont;
       //设置文字颜色
//       [btnText setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
       //设置文字可以换行
       btnText.titleLabel.numberOfLines = 0;
        [self.contentView addSubview:btnText];
        _textBtn = btnText;
        
        
    }
    self.backgroundColor = [UIColor clearColor];
    return self;
    
}


- (void)setFrames:(messageFrames *)frames
{
    _frames = frames;
    //获取frame里的数据
    messagesModel *model = frames.model;

    _timeLabel.text = model.time;
    _timeLabel.frame = frames.timeFrame;
    
    //根据消息是谁发布的来选择显示的头像
    if (model.isMe == YES) {
        _iconImage.image = [UIImage imageNamed:@"me_icon"];
    }else
    {
        _iconImage.image = [UIImage imageNamed:@"you_icon"];
    }
    _iconImage.frame = frames.iconFrame;
    

    [self.textBtn setTitle:model.message forState:UIControlStateNormal];
    //根据消息是谁发布的来选择信息显示的背景图片
    if (model.isMe == YES) {
        _textBtn.imageView.image = [UIImage imageNamed:@"me"];
        [_textBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }else
    {
        _textBtn.imageView.image = [UIImage imageNamed:@"you"];
        [_textBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    _textBtn.frame = frames.messageFrame;
    _textBtn.contentEdgeInsets = UIEdgeInsetsMake(messageInsectTop, messageInsectLeft, messageInsectTop, messageInsectLeft);
    //根据消息是不是自己发的来判断汽包种类
    if (model.isMe == YES) {
        UIImage *imageMe = [UIImage imageNamed:@"me"];
        imageMe = [imageMe stretchableImageWithLeftCapWidth:imageMe.size.width * 0.5 topCapHeight:imageMe.size.height * 0.5];
        [self.textBtn setBackgroundImage:imageMe forState:UIControlStateNormal];
    }else
    {
        UIImage *imageYou = [UIImage imageNamed:@"you"];
        imageYou = [imageYou stretchableImageWithLeftCapWidth:imageYou.size.width * 0.5 topCapHeight:imageYou.size.height * 0.5];
        [self.textBtn setBackgroundImage:imageYou forState:UIControlStateNormal];
    }
}


- (void)awakeFromNib {
    // Initialization code
    

    
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
    
    
    
    // Configure the view for the selected state
}

@end
