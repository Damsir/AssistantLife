//
//  DrawViewController.m
//  抽屉
//
//  Created by qianfeng on 15/11/23.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "DrawViewController.h"
#import "AppDelegate.h"
//抽屉打开的时候ContentView的缩放比例
#define DRAWER_OUT_SCALE 0.8
//抽屉打开时contentView的 X坐标
#define LEFT_DRAWER_OUT_CENTER_X   self.rootController.view.center.x+self.leftDistance - self.rootController.view.bounds.size.width*(1-DRAWER_OUT_SCALE)/2

//抽屉打开时 默认的contentView Y坐标
#define RIGHT_DRAWER_OUT_X  self.rootController.view.center.x-self.rightDistance + self.rootController.view.bounds.size.width*(1-DRAWER_OUT_SCALE)/2

#define CONTENT_VIEW_CENTER_Y self.rootController.view.center.y

@interface DrawViewController ()

@end

@implementation DrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self )
    {
        self.leftDistance = 250 ;
        self.rightDistance = 100 ;
    }
    
    return self ;
}
-(id)initWithRootControl:(UIViewController *)rootController WithLeftController:(UIViewController *)leftController AndRightController:(UIViewController *)rightController
{
    self = [super init];
    
    if(self)
    {
        _rootController = rootController ;
        [self setLeftController:leftController] ;
        [self setRightController:rightController];
    }
    return  self ;
}

-(void)setLeftController:(UIViewController *)leftController
{
    if(_leftController != leftController)
    {
        _leftController = leftController ;
        
        CGRect frame = leftController.view.frame ;
        
        frame.origin.x = -frame.size.width ;
        
        frame.origin.y = 0 ;
        
        leftController.view.frame = frame ;
        
        AppDelegate *delegate = [UIApplication sharedApplication].delegate ;
        
        [delegate.window addSubview:leftController.view];
    }
}
-(void)setRightController:(UIViewController *)rightController
{
    
    if(_rightController != rightController)
    {
        _rightController = rightController ;
        
        CGRect frame = rightController.view.frame ;
        
        frame.origin.x = self.view.frame.size.width ;
        
        frame.origin.y = 0 ;
        
        rightController.view.frame = frame ;
        
        AppDelegate *delegate = [UIApplication sharedApplication].delegate ;
        
        [delegate.window addSubview:rightController.view];

    }
    
}
-(void)openLeftDrawer
{
    self.rightController.view.hidden = YES ;
    self.leftController.view.hidden = NO ;
        [UIView animateWithDuration:0.5 animations:^{
            
            self.rootController.view.center = CGPointMake(LEFT_DRAWER_OUT_CENTER_X, CONTENT_VIEW_CENTER_Y);
            
            self.rootController.view.transform = CGAffineTransformMakeScale(DRAWER_OUT_SCALE, DRAWER_OUT_SCALE);
            
            self.leftController.view.frame = CGRectMake(0, 0,self.view.frame.size.width, self.leftController.view.bounds.size.height);
            
            
        }];
 
}
-(void)openRightDrawer
{
    
    self.leftController.view.hidden = YES ;

    self.rightController.view.hidden = NO ;
    [UIView animateWithDuration:0.5 animations:^{
        
        self.rootController.view.center = CGPointMake(RIGHT_DRAWER_OUT_X,CONTENT_VIEW_CENTER_Y);
        self.rootController.view.transform = CGAffineTransformMakeScale(DRAWER_OUT_SCALE, DRAWER_OUT_SCALE);
        
        self.rightController.view.frame = CGRectMake(self.view.bounds.size.width - self.rightDistance, 0,self.view.frame.size.width, self.rightController.view.bounds.size.height);
            }];

}
-(void)colseDrawer
{
    [UIView animateWithDuration:0.5 animations:^{
        self.rootController.view.transform = CGAffineTransformMakeScale(1, 1);
        self.rootController.view.center = self.view.center;
        
        self.leftController.view.frame = CGRectMake(-self.leftController.view.bounds.size.width, 0,_leftDistance, self.leftController.view.bounds.size.height);
        
        self.rightController.view.frame = CGRectMake(self.view.bounds.size.width, 0, _rightDistance, self.rightController.view.bounds.size.height);
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
