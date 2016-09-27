//
//  TabBarViewController.m
//  生活小助手
//
//  Created by qianfeng on 15/11/24.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "TabBarViewController.h"
#import "MainViewController.h"
#import "ClassifyViewController.h"
#import "OneSelfViewController.h"
#import "DestinationLocationViewController.h"
#import "IssueViewController.h" 
#import "DrawerViewController.h"


@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self ArrangeWithView];
    
    UIApplicationShortcutItem * itemy = [[UIApplicationShortcutItem alloc]initWithType:@"two" localizedTitle:@"打开应用" localizedSubtitle:nil icon:[UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypePlay] userInfo:nil];
    
    UIApplicationShortcutItem * itemx = [[UIApplicationShortcutItem alloc]initWithType:@"one" localizedTitle:@"定位" localizedSubtitle:nil icon:[UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeLocation] userInfo:nil];
    //    UIApplicationShortcutItem *itemz=[[UIApplicationShortcutItem alloc] initWithType:@"three" localizedTitle:@"分享应用"];
    
    [UIApplication sharedApplication].shortcutItems = @[itemx,itemy];
    
}
-(void)ArrangeWithView
{
    NSArray *str = @[@"分类",@"位置",@"发布",@"个人中心"];
    
    NSArray *images = @[@"ic_dest_info_jinnang_normal",@"ic_map_recommend",@"ic_dest_info_youji_disable",@"ic_dest_poi_star_dark_normal"];
    
    NSArray *images_press = @[@"ic_dest_info_jinnang_press",@"ic_map_recommend_pressed",@"ic_dest_info_youji_normal",@"ic_dest_poi_star_highlight_press"];
    
    NSArray *controls =@[[ClassifyViewController class],[DestinationLocationViewController class],[IssueViewController class],[OneSelfViewController class]];
    
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i < 4; i++) {
        
        UIViewController *vc = [[controls[i] alloc]init];
        
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
        
        UIImage *image = [UIImage resizableImage:images[i] andSize:CGSizeMake(30, 30)];
        UIImage *image_press = [UIImage resizableImage:images_press[i] andSize:CGSizeMake(30, 30)];
        
        vc.tabBarItem = [[UITabBarItem alloc]initWithTitle:str[i] image:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]  selectedImage:[image_press imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        
        
        [arr addObject:nav];
        
    }
    
   self.tabBar.tintColor = [UIColor colorWithRed:40.0/255 green:195.0/255 blue:140.0/255 alpha:1];
    
    MainViewController *mav = [[MainViewController alloc]init];
    
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:mav];
    
    [arr insertObject:nav atIndex:2];
    
    self.tabBar.translucent = NO ;
    
    self.tabBar.barTintColor = [UIColor colorWithRed:232.0/255 green:233.0/255 blue:232.0/255 alpha:1];
    
    self.viewControllers = arr ;
    
    self.selectedIndex = 2 ;
    
    

    
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
