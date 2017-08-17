//
//  CarMessageViewProtocol.h
//  flamegrace@hotmail.com
//
//  Created by Flame Grace on 2017/2/24.
//  Copyright © 2017年 flamegrace@hotmail.com. All rights reserved.
// 语音聊天视图协议

#import <Foundation/Foundation.h>
#import "ChatModel.h"


#define Chat_LeftMargin (8.0) //左右间距
#define Chat_CornerRadius (8.0) //圆角大小
#define Chat_TextFontSize (16.0) //文字大小
#define Chat_NickTextFontSize (12.0) //昵称文字大小
#define Chat_OtherTextColor [UIColor grayColor] //文字颜色
#define Chat_MeBackGroundColor [UIColor blueColor] //背景颜色


@protocol ChatViewProtocol <NSObject>
//聊天消息
@property (strong, nonatomic) ChatModel *model;

//根据消息更新视图
- (void)updateViewByModel:(ChatModel *)model;
//根据source更新视图
- (void)updateViewForSource;
//设置来源为自己时的视图
- (void)sourceMeView;
//设置来源为其他人时的视图
- (void)sourceOtherView;


@end


@protocol ChatViewDelegate <NSObject>

@optional
//点击事件
- (void)chatView:(UIView *)chatView  clickedModel:(ChatModel *)model;
//需要重新发送该消息
- (void)chatView:(UIView *)chatView  needResendModel:(ChatModel *)model;
//需要保存此消息的更新
- (void)chatView:(UIView *)chatView  needSaveModel:(ChatModel *)model;
//需要重新识别语音消息
- (void)chatView:(UIView *)chatView  needReVoiceRecognizeModel:(ChatModel *)model;

@end
