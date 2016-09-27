//
//  DrawerViewController.m
//  day05-06-自制抽屉
//
//  Created by Aaron on 15/4/18.
//  Copyright (c) 2015年 Aaron. All rights reserved.
//

#import "DrawerViewController.h"
#import "TabBarViewController.h"
#import "MainViewController.h"

//抽屉打开的时候ContentView的缩放比例
#define DRAWER_OUT_SCALE 0.8
//抽屉打开时contentView的 X坐标
#define LEFT_DRAWER_OUT_CENTER_X   self.view.center.x+self.leftDrawerWidth - self.rootViewController.view.bounds.size.width*(1-DRAWER_OUT_SCALE)/2
//抽屉打开时 默认的contentView Y坐标
#define RIGHT_DRAWER_OUT_X  self.rootViewController.view.center.x-self.rightDrawerWidth + self.rootViewController.view.bounds.size.width*(1-DRAWER_OUT_SCALE)/2
#define CONTENT_VIEW_CENTER_Y self.rootViewController.view.center.y

//打开抽屉模式
typedef enum
{
    LEFT_DRAWER_OPEN,
    RIGHT_DRAWER_OPEN
}DrawerOpenType;

@interface DrawerViewController ()
@property (nonatomic,strong) UIViewController *rootViewController;
@end

@implementation DrawerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        NSLog(@"init with nib");
        // Custom initialization
        //初始化默认设置
        self.leftDrawerWidth = 200;
        self.rightDrawerWidth = 100;

    }
    return self;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark -- 设置抽屉控制器
- (id) initWithRootViewController:(UIViewController *)rootViewController
{
    if(self = [super init])
    {
        //设置根视图
        [self setRootViewController:rootViewController];
    }
    return self;
}


- (id) initWithRootViewController:(UIViewController *)rootViewController  andLeftViewController:(UIViewController *)leftViewController andRightViewController:(UIViewController *)rightViewController
{
     if(self = [super init])
     {
         _isOpen= NO ;
         //设置左侧抽屉
        [self setLeftViewController:leftViewController];
        //设置右侧抽屉
        [self setRightViewController:rightViewController];
        //设置根视图
        [self setRootViewController:rootViewController];
         
         [self gesturesweip];
     }
    return self;
}

#pragma mark  设置左侧抽屉
-(void)setLeftViewController:(UIViewController *)leftViewController
{
    if(_leftViewController != leftViewController)
    {
        _leftViewController = leftViewController;
        if([leftViewController respondsToSelector:@selector(setDrawer:)])
        {
            //将抽屉设置到左侧视图
            [leftViewController performSelector:@selector(setDrawer:) withObject:self];
        }

        [self.view addSubview:leftViewController.view];
        CGRect frame = leftViewController.view.frame;
        frame.origin.x = -frame.size.width;
        frame.origin.y = 0;
        leftViewController.view.frame = frame;
    }
}


#pragma mark 设置右侧抽屉
-(void)setRightViewController:(UIViewController *)rightViewController
{
    if(_rightViewController != rightViewController)
    {
        _rightViewController = rightViewController;
        if([rightViewController respondsToSelector:@selector(setDrawer:)])
        {
            [rightViewController performSelector:@selector(setDrawer:) withObject:self];
        }

        [self.view addSubview:rightViewController.view];
        CGRect frame = rightViewController.view.frame;
        frame.origin.x = self.view.bounds.size.width;
        frame.origin.y = 0;
        rightViewController.view.frame = frame;
    }
}


#pragma mark 设置根视图
-(void)setRootViewController:(UIViewController *)rootViewController
{
    if(_rootViewController != rootViewController)
    {
        _rootViewController = rootViewController;
        if([rootViewController respondsToSelector:@selector(setDrawer:)])
        {
            [rootViewController performSelector:@selector(setDrawer:) withObject:self];
        }

        [self.view addSubview:rootViewController.view];
        rootViewController.view.frame = self.view.bounds;
    }
}



#pragma mark -- 属性设值方法
#pragma mark 设置抽屉背景
-(void)setBackgroundImage:(UIImage *)backgroundImage
{
    if(_backgroundImage != backgroundImage)
    {
        _backgroundImage = backgroundImage;
        self.view.backgroundColor = [UIColor colorWithPatternImage:backgroundImage];
    }
}


-(void)gesturesweip
{
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGestureClick:)];
    
    [self.leftViewController.view addGestureRecognizer:pan];
    
    for (int i = 0; i < 4; i++)
    {
        UISwipeGestureRecognizer *swip = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipGestureClick:)];
        
        swip.direction = UISwipeGestureRecognizerDirectionRight << i ;

        [self.leftViewController.view addGestureRecognizer:swip];

    }
    
}

-(void)swipGestureClick:(UISwipeGestureRecognizer *)gesture
{
    if(gesture.direction == UISwipeGestureRecognizerDirectionRight)
    {
        [UIView animateWithDuration:0.5 animations:^{
            self.leftViewController.view.frame = CGRectMake(0, 0, self.leftViewController.view.bounds.size.width, self.leftViewController.view.bounds.size.height);
            self.rootViewController.view.transform = CGAffineTransformMakeScale(DRAWER_OUT_SCALE, DRAWER_OUT_SCALE);
            
            self.rootViewController.view.center = CGPointMake(LEFT_DRAWER_OUT_CENTER_X, CONTENT_VIEW_CENTER_Y);
            
        }];
    }
    if(gesture.direction == UISwipeGestureRecognizerDirectionLeft)
    {
        [self closeDrawer];
    }
}

-(void)panGestureClick:(UIPanGestureRecognizer *)gesture
{
    CGPoint piont = [gesture translationInView:self.view];
    
    CGPoint center = self.leftViewController.view.center ;
    
    CGPoint center1 = self.rootViewController.view.center ;
    
    if(center.x + piont.x >= WIDEMAX/2.0)
    {
         self.leftViewController.view.frame = CGRectMake(0, 0, self.leftViewController.view.bounds.size.width, self.leftViewController.view.bounds.size.height);
         self.rootViewController.view.center = CGPointMake(LEFT_DRAWER_OUT_CENTER_X, CONTENT_VIEW_CENTER_Y);
    }
   else if (center1.x + piont.x <= WIDEMAX/2.0 ) {
    
        self.rootViewController.view.center = self.view.center;
        
        self.leftViewController.view.frame = CGRectMake(-self.leftViewController.view.bounds.size.width, 0, self.leftViewController.view.bounds.size.width, self.leftViewController.view.bounds.size.height);

    }
    else
    {
        
        self.leftViewController.view.center = CGPointMake(center.x + piont.x,HEIGHRMAX/2);
        self.rootViewController.view.center = CGPointMake(center1.x + piont.x , HEIGHRMAX/2);

    }
    self.rootViewController.view.transform = CGAffineTransformMakeScale(0.8 + 0.2 *((LEFT_DRAWER_OUT_CENTER_X-center1.x-piont.x)/(LEFT_DRAWER_OUT_CENTER_X-WIDEMAX/2.0)),0.8 + 0.2 *((LEFT_DRAWER_OUT_CENTER_X-center1.x-piont.x)/(LEFT_DRAWER_OUT_CENTER_X-WIDEMAX/2.0)));
    self.leftViewController.view.center = CGPointMake(center.x + piont.x,HEIGHRMAX/2);

    if(gesture.state == UIGestureRecognizerStateEnded)
    {
        if(center.x + piont.x < WIDEMAX/4 && center1.x + piont.x < (WIDEMAX-WIDEMAX/4))
        {
            [self closeDrawer];
        }
        else
        {
            [UIView animateWithDuration:0.5 animations:^{
                self.leftViewController.view.frame = CGRectMake(0, 0, self.leftViewController.view.bounds.size.width, self.leftViewController.view.bounds.size.height);
                self.rootViewController.view.transform = CGAffineTransformMakeScale(DRAWER_OUT_SCALE, DRAWER_OUT_SCALE);

                self.rootViewController.view.center = CGPointMake(LEFT_DRAWER_OUT_CENTER_X, CONTENT_VIEW_CENTER_Y);

            }];
            
        }
       

    }
    
    [gesture setTranslation:CGPointZero inView:self.view];

}









#pragma mark -- 抽屉方法实现
#pragma mark 获取抽屉是否能抽出
-(BOOL)shouldContentViewController:(UIViewController *)contentViewController openDrawer:(DrawerOpenType)openType
{
    if(openType == LEFT_DRAWER_OPEN)
    {
        if([contentViewController respondsToSelector:@selector(drawer:leftViewShouldOpen:)])
        {
            return (BOOL)[contentViewController performSelector:@selector(drawer:leftViewShouldOpen:) withObject:self withObject:self.leftViewController];
        }
    }
    else if(openType == RIGHT_DRAWER_OPEN)
    {
        if([contentViewController respondsToSelector:@selector(drawer:rightViewShouldOpen:)])
        {
            return (BOOL)[contentViewController performSelector:@selector(drawer:rightViewShouldOpen:) withObject:self withObject:self.rightViewController];
        }
    }
    return YES;

}

#pragma mark 打开左边抽屉
-(void)openLeftDrawer
{
    if(!_isOpen){
        if([self shouldContentViewController:self.rootViewController openDrawer:LEFT_DRAWER_OPEN])
        {
            _isOpen= YES ;
            NSLog(@"可以打开抽屉");
            [UIView animateWithDuration:0.5 animations:^{
                self.rootViewController.view.center = CGPointMake(LEFT_DRAWER_OUT_CENTER_X, CONTENT_VIEW_CENTER_Y);
                self.rootViewController.view.transform = CGAffineTransformMakeScale(DRAWER_OUT_SCALE, DRAWER_OUT_SCALE);

                self.leftViewController.view.frame = CGRectMake(0, 0, self.leftViewController.view.bounds.size.width, self.leftViewController.view.bounds.size.height);
            }];
        }
    }
    else
    {
       
        NSLog(@"不能打开抽屉");
    }
}

#pragma mark 打开右边抽屉
-(void)openRightDrawer
{
    if (!_isOpen ) {
        
        if([self shouldContentViewController:self.rootViewController openDrawer:RIGHT_DRAWER_OPEN])
        {
            NSLog(@"可以打开抽屉");
            [UIView animateWithDuration:0.5 animations:^{

                self.rootViewController.view.center = CGPointMake(RIGHT_DRAWER_OUT_X,CONTENT_VIEW_CENTER_Y);
                self.rootViewController.view.transform = CGAffineTransformMakeScale(DRAWER_OUT_SCALE, DRAWER_OUT_SCALE);

                self.rightViewController.view.frame = CGRectMake(self.view.bounds.size.width - self.rightDrawerWidth, 0, self.rightViewController.view.bounds.size.width, self.rightViewController.view.bounds.size.height);
            }];
        }
    }
    else
    {
       
        NSLog(@"不能打开抽屉");
    }
}

#pragma mark 关闭抽屉
-(void)closeDrawer
{
    _isOpen = NO ;
    [UIView animateWithDuration:0.5 animations:^{
        self.rootViewController.view.transform = CGAffineTransformMakeScale(1, 1);
        self.rootViewController.view.center = self.view.center;

        self.leftViewController.view.frame = CGRectMake(-self.leftViewController.view.bounds.size.width, 0, self.leftViewController.view.bounds.size.width, self.leftViewController.view.bounds.size.height);

        self.rightViewController.view.frame = CGRectMake(self.view.bounds.size.width, 0, self.rightViewController.view.bounds.size.width, self.rightViewController.view.bounds.size.height);
    }];
}



@end
