//
//  CarChatImageView.m
//  flamegrace@hotmail.com
//
//  Created by Flame Grace on 2017/3/4.
//  Copyright © 2017年 flamegrace@hotmail.com. All rights reserved.
//

#import "ChatImageView.h"

@implementation ChatImageView

- (void)updateViewByModel:(ChatModel *)model
{
    [super updateViewByModel:model];
    if(model.type == ChatImage)
    {
        [self updateViewByImageModel:model];
    }
    
    if(model.type == ChatVideo)
    {
        [self updateViewByVideoModel:model];
    }
    
    self.width = self.prevImageView.width;
    self.height = self.prevImageView.height;
    [self updateViewForSource];

}

- (void)sourceOtherView
{
    [super sourceOtherView];
}

- (void)sourceMeView
{
    [super sourceMeView];
}


- (void)updateViewByImageModel:(ChatModel *)model
{
    UIImage *image = [UIImage imageWithContentsOfFile:[NSFileManager documenFullPath:model.filePath]];
    if(image)
    {
        CGSize size = image.size;
        self.prevImageView.height = size.height * 160 /size.width;
        self.prevImageView.image = image;
    }
}


- (void)updateViewByVideoModel:(ChatModel *)model
{
//    NSString *videoPath = [NSFileManager documenFullPath:model.filePath];
//    [UIImage fastGetLocalVideoFirstFrameImage:videoPath gotImageBlock:^(UIImage *image) {
//        dispatch_async(dispatch_get_main_queue(),^{
//            if(image)
//            {
//                self.prevImageView.image = image;
//            }
//            else
//            {
//                self.prevImageView.image = [UIImage imageNamed:@"video_back_ground"];
//            }
//        });
//    }];
    
    UIImageView *playIcon = [[UIImageView alloc]init];
    playIcon.image = [UIImage imageNamed:@"xcjl_shipin_bofang"];
    [self.prevImageView addSubview:playIcon];
    playIcon.translatesAutoresizingMaskIntoConstraints = NO;
    [playIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@40);
        make.width.equalTo(@40);
        make.centerY.equalTo(self.prevImageView);
        make.centerX.equalTo(self.prevImageView);
    }];
}


- (UIImageView *)prevImageView
{
    if(!_prevImageView)
    {
        _prevImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 160, 90)];
        [self addSubview:_prevImageView];
    }
    return _prevImageView;
}

@end
