//
//  ChatView+Broswer.m
//  flamegrace@hotmail.com
//
//  Created by Flame Grace on 2017/3/27.
//  Copyright © 2017年 flamegrace@hotmail.com. All rights reserved.
//

#import "ChatView+Broswer.h"
#import "UIImageBrowser.h"
#import <MediaPlayer/MediaPlayer.h>
#import <QuickLook/QuickLook.h>
#import "ChatImageView.h"

@implementation ChatView (Broswer)
//保存图片和视频预览器
static UIImageBrowser *imageBrowser = nil;

- (void)broswerImage:(ChatModel *)model
{
    if(model.type != ChatImage)
    {
        return;
    }
    ChatTableViewCell *cell = [self cellForModel:model];
    if(cell)
    {
        ChatImageView *imageView = (ChatImageView *)cell.messageView;
        UIImageBrowser *browser = [[UIImageBrowser alloc]init];
        imageBrowser = browser;
        [imageBrowser showImageView:imageView.prevImageView hideCompleteBlock:^(NSError *error)
         {
             imageBrowser = nil;
         }];
    }
    
}


- (void)broswerVideo:(ChatModel *)model isSupportOrientation:(BOOL *)isSupportOrientation
{
    if(model.type != ChatVideo)
    {
        return;
    }
    ChatTableViewCell *cell = [self cellForModel:model];
    if(cell)
    {
        
    }
    
}

-(void)playVideo:(NSString *)videoPath
{
    NSURL *URL = [NSURL URLWithString:videoPath];
    MPMoviePlayerViewController  * moviePlayerController = [[MPMoviePlayerViewController alloc] initWithContentURL:URL];
//    [self presentMoviePlayerViewControllerAnimated:moviePlayerController];
    moviePlayerController.moviePlayer.movieSourceType=MPMovieSourceTypeFile;
}



@end
