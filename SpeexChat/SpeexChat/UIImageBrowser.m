//
//  UIImageBrowser.m
//  flamegrace@hotmail.com
//
//  Created by Flame Grace on 2017/3/17.
//  Copyright © 2017年 flamegrace@hotmail.com. All rights reserved.
//

#import "UIImageBrowser.h"

@interface UIImageBrowser() <UIScrollViewDelegate>

@property (copy, nonatomic) VoidBlock hideCompleteBlock;
@property (readwrite,strong,nonatomic) UIImageView *originView;
@property (strong, nonatomic) UITapGestureRecognizer *tapGestureRecognizer;

@end


@implementation UIImageBrowser


- (UIView *)backGroundView
{
    if(!_backGroundView)
    {
        _backGroundView = [[UIScrollView alloc]initWithFrame:MainScreenBounds];
        _backGroundView.maximumZoomScale=3.0;//图片的放大倍数
        _backGroundView.minimumZoomScale=1.0;//图片的最小倍率
        _backGroundView.contentSize=CGSizeMake(MainScreenWidth, MainScreenHeight);
        _backGroundView.delegate=self;
        _backGroundView.backgroundColor=[UIColor blackColor];
        _backGroundView.alpha = 1;
    }
    return _backGroundView;
}

- (UIImageView *)imageView
{
    if(!_imageView)
    {
        _imageView = [[UIImageView alloc]init];
        [self.backGroundView addSubview:_imageView];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        _imageView.clipsToBounds = YES;
    }
    return _imageView;
}

- (UITapGestureRecognizer *)tapGestureRecognizer
{
    if(!_tapGestureRecognizer)
    {
        _tapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideImage:)];
        [self.backGroundView addGestureRecognizer:_tapGestureRecognizer];
    }
    return _tapGestureRecognizer;
}


-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView  //委托方法,必须设置  delegate
{
    
    return self.imageView;//要放大的视图
}

//展示图片
//hideCompleteBlock：图片查看器被移除后的回调，可在此回调后释放该对象
- (void)showImage:(UIImage *)originImage hideCompleteBlock:(VoidBlock )hideCompleteBlock
{
    if(originImage == nil)
    {
        return;
    }
    self.hideCompleteBlock = hideCompleteBlock;
    self.imageView.alpha = 0;
    self.imageView.image = originImage;
    self.imageView.frame = self.backGroundView.frame;
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    [window addSubview:self.backGroundView];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.imageView.alpha    = 1;
        self.backGroundView.alpha=1;
    } completion:^(BOOL finished) {
        
    }];
    
    [self tapGestureRecognizer];
}

- (void)showImageView:(UIImageView *)originView hideCompleteBlock:(__autoreleasing VoidBlock )hideCompleteBlock
{
    if(originView.image == nil)
    {
        return;
    }
    self.hideCompleteBlock = hideCompleteBlock;
    UIImage *image=originView.image;
    self.originView = originView;
    self.originView.alpha = 0;
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    CGRect oldframe=[self.originView convertRect:self.originView.bounds toView:window];
    self.imageView.frame = oldframe;
    self.imageView.image=image;
    [window addSubview:self.backGroundView];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.imageView.frame    = self.backGroundView.frame;
        self.backGroundView.alpha=1;
    } completion:^(BOOL finished) {
        
    }];
    [self tapGestureRecognizer];
}

-(void)hideImage:(UITapGestureRecognizer*)tap
{
    if(self.originView == nil)
    {
        [UIView animateWithDuration:0.3 animations:^{
            [self.backGroundView removeFromSuperview];
            self.imageView.alpha = 1;
            self.backGroundView.alpha=0;
            if(self.hideCompleteBlock)
            {
                self.hideCompleteBlock(nil);
            }
        }];
        return;
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        self.imageView.frame=[self.originView convertRect:self.originView.bounds toView:[UIApplication sharedApplication].keyWindow];
    } completion:^(BOOL finished) {
        [self.backGroundView removeFromSuperview];
        self.originView.alpha = 1;
        self.backGroundView.alpha=0;
        if(self.hideCompleteBlock)
        {
            self.hideCompleteBlock(nil);
        }
    }];
}


@end
