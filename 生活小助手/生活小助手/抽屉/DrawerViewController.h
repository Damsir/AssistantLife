//
//  DrawerViewController.h
//  day05-06-自制抽屉
//
//  Created by Aaron on 15/4/18.
//  Copyright (c) 2015年 Aaron. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawerViewController : UIViewController
{
    @private
    //主界面根视图
    UIViewController *_rootViewController;
}

@property (nonatomic,assign) BOOL isOpen;

//抽屉背景
@property (nonatomic,strong) UIImage *backgroundImage;
//设置左抽屉
@property (nonatomic,strong) UIViewController *leftViewController;
//设置右抽屉
@property (nonatomic,strong) UIViewController *rightViewController;
//左侧抽屉宽度
//默认:250
@property (nonatomic,assign) CGFloat leftDrawerWidth;
//右侧抽屉宽度
//默认:100
@property (nonatomic,assign) CGFloat rightDrawerWidth;
//构造方法
//只初始化ContentView
- (id) initWithRootViewController:(UIViewController *)rootViewController;
//初始化ContentView LeftView RightView
- (id) initWithRootViewController:(UIViewController *)rootViewController  andLeftViewController:(UIViewController *)leftViewController andRightViewController:(UIViewController *)rightViewController;
//左侧抽屉打开
-(void)openLeftDrawer;
//右抽屉打开
-(void)openRightDrawer;
//抽屉关闭
-(void)closeDrawer;
@end

//抽屉子控制器协议
//需要在子控制器实现synthesize
@protocol DrawerChildViewController <NSObject>
@required
@property (nonatomic,weak) DrawerViewController *drawer;
@end

//抽屉代理协议
//用于实现抽屉工作过程中的自定义处理
@protocol DrawerChildViewControllerDelegate <NSObject>
@required

@optional
-(BOOL)drawer:(DrawerViewController *)drawer leftViewShouldOpen:(UIViewController *)leftViewController ;
-(BOOL)drawer:(DrawerViewController *)drawer rightViewShouldOpen:(UIViewController *)rightViewController ;

-(void)drawer:(DrawerViewController *)drawer leftDrawerWillOpen:(UIViewController *)leftViewController;
-(void)drawer:(DrawerViewController *)drawer leftDrawerDidOpen:(UIViewController *)leftViewController;
-(void)drawer:(DrawerViewController *)drawer leftDrawerWillClose:(UIViewController *)leftViewController;
-(void)drawer:(DrawerViewController *)drawer leftDrawerDidClose:(UIViewController *)leftViewController;

-(void)drawer:(DrawerViewController *)drawer rightDrawerWillOpen:(UIViewController *)rightViewController;
-(void)drawer:(DrawerViewController *)drawer rightDrawerDidOpen:(UIViewController *)rightViewController;
-(void)drawer:(DrawerViewController *)drawer rightDrawerWillClose:(UIViewController *)rightViewController;
-(void)drawer:(DrawerViewController *)drawer rightDrawerDidClose:(UIViewController *)rightViewController;


@end
