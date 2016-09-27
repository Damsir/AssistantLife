//
//  DrawViewController.h
//  抽屉
//
//  Created by qianfeng on 15/11/23.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, LeftMenuPanDirection) {
    LeftMenuPanDirectionLeft = 0,   /**< 左方向*/
    LeftMenuPanDirectionRight,      /**< 右方向*/
};

typedef NS_ENUM(NSUInteger, AnimationType) {
    AnimationTransition = 0,                /**< 只有位移动画*/
    AnimationTransitionAndScale,            /**< 位移加缩放动画*/
    AnimationTransitionAndScaleAndIncline,  /**< 位移加缩放加倾斜动画*/
};


@interface DrawViewController : UIViewController

@property (nonatomic,retain) UIViewController *rootController;
@property (nonatomic,retain)  UIViewController *leftController;
@property (nonatomic,retain)  UIViewController *rightController;
@property (nonatomic, assign)  CGFloat          rightDistance;
@property (nonatomic, assign) CGFloat          leftDistance;         /**< 左滑距离*/
@property (nonatomic, assign) CGFloat          scaleSize;           /**< 缩放大小 0-1,动画类型为**/
-(id)initWithRootControl:(UIViewController *)rootController WithLeftController:(UIViewController *)LeftController AndRightController:(UIViewController *)rightController ;
-(void)openLeftDrawer ;
-(void)colseDrawer ;
-(void)openRightDrawer ;
@end
