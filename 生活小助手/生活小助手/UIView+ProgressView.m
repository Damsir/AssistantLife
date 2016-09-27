//
//  UIView+ProgressView.m
//  UICollectionViewAndHttp
//
//  Created by smith on 15/11/3.
//  Copyright © 2015年 smith. All rights reserved.
//

#import "UIView+ProgressView.h"

#define VIEW_TAG  9909

@implementation UIView (ProgressView)
    NSTimer *timer ;
- (void)showJUHUAWithBool:(BOOL)isShow
{
    if (isShow)
    {
        UIView * backView = [self viewWithTag:VIEW_TAG] ;
        if (backView)
        {
            return ;
        }
        //第一个层级
        backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)] ;
        backView.tag = VIEW_TAG ;
        [self addSubview:backView] ;
        
        
        [self bringSubviewToFront:backView];
        
        //第二个层级 是用来做透明度用的
        UIView  *subBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)] ;
        
        subBackView.backgroundColor = [UIColor blackColor] ;
        
        subBackView.alpha = 0.5f ;
        
        [backView addSubview:subBackView] ;
        
        //第三层级 菊花
    
//        UIView * blackView = [[UIView alloc] initWithFrame:CGRectMake(100, 300, self.frame.size.width-200, 100)] ;
//        blackView.layer.cornerRadius = 10 ;
//        blackView.backgroundColor = [UIColor blackColor] ;
//        [backView addSubview:blackView] ;
//
//        UIActivityIndicatorView * activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge] ;
//        activity.center = CGPointMake(blackView.frame.size.width/2, blackView.frame.size.height/2) ;
//        [activity startAnimating] ;
//        [blackView addSubview:activity] ;
        
        UIImageView *imageview = [[UIImageView alloc]init];
        
         [self timer];
        
        imageview.tag = 999 ;
        
        imageview.bounds = CGRectMake(0, 0, 60, 60);
        imageview.center = CGPointMake(backView.frame.size.width/2, backView.frame.size.height/2) ;
        
        imageview.image = [UIImage imageNamed:@"skala"];
        
       
        
        [backView addSubview:imageview];
        
    }
    else
    {
        UIView * backView = [self viewWithTag:VIEW_TAG] ;
        [backView removeFromSuperview] ;
    }
}

-(void)timer
{
    timer = [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(animation) userInfo:nil repeats:YES];
}

-(void)animation
{
    
    UIImageView *imageview = (id)[self viewWithTag:999];
    static BOOL is= YES ;
    if(is)
    {
        [UIView animateWithDuration:0.5 animations:^{
            imageview.transform = CGAffineTransformMakeRotation(M_PI);
        }];
        is = NO ;
    }
    else
    {
        [UIView animateWithDuration:0.5 animations:^{
            imageview.transform = CGAffineTransformMakeRotation(0);
        }];
        is = YES ;
    }
    
   
}


@end
