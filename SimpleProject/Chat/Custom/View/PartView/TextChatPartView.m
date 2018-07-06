//
//  ChatTextPartView.m
//  SpeexChat
//
//  Created by Flame Grace on 2017/11/22.
//  Copyright © 2017年 Flame Grace. All rights reserved.
//

#import "TextChatPartView.h"

@implementation TextChatPartView

- (instancetype)initWithConfig:(ChatViewConfig *)config
{
    if (self = [super initWithConfig:config]) {
        _edgeInset = UIEdgeInsetsMake(12, 8.5, 12, 8.5);
        _textLabelMaxWidth = Chat_MainScreenWidth - 60 - 17 -17;
    }
    return self;
}

- (void)updateViewByModel:(id<ChatModelProtocol>)model
{
    [super updateViewByModel:model];
    self.textLabel.text = model.message;
    CGSize size =  [self.textLabel.text boundingRectWithSize:CGSizeMake(_textLabelMaxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.textLabel.font} context:nil].size;
    
    self.textLabel.frame = CGRectMake(_edgeInset.left, _edgeInset.top, size.width, size.height);
    
    CGRect frame = self.frame;
    frame.size.width = size.width + _edgeInset.left + _edgeInset.right;
    frame.size.height = size.height + _edgeInset.top + _edgeInset.bottom;
    self.frame = frame;
    [self updateViewForSource];
}

- (void)setEdgeInset:(UIEdgeInsets)edgeInset
{
    _edgeInset = edgeInset;
    [self updateViewByModel:self.model];
}

- (void)setTextLabelMaxWidth:(CGFloat)textLabelMaxWidth
{
    _textLabelMaxWidth = textLabelMaxWidth;
    [self updateViewByModel:self.model];
}

- (void)sourceOtherView
{
    [super sourceOtherView];
    self.textLabel.textColor = self.config.otherTextColor;
}

- (void)sourceMeView
{
    [super sourceMeView];
    self.textLabel.textColor = self.config.meTextColor;
}


- (UILabel *)textLabel
{
    if(!_textLabel)
    {
        _textLabel = [[UILabel alloc]init];
        _textLabel.numberOfLines = 0;
        _textLabel.font = [UIFont systemFontOfSize:self.config.textFontSize];
        [self addSubview:_textLabel];
    }
    return _textLabel;
}

@end
