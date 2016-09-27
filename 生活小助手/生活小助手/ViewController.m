 //
//  ViewController.m
//  生活小助手
//
//  Created by qianfeng on 15/11/20.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor cyanColor];
    
    [self NetWorkTingKey];
}
-(void)NetWorkTingKey
{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    [manager startMonitoring];
    
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:
            {
                [self showMessage:@"没有网络，请检查网络是否打开"];
            }
                break;
            case AFNetworkReachabilityStatusUnknown:
            {
                
            }
                break ;
            case AFNetworkReachabilityStatusReachableViaWiFi:
            {
                
            }
                break ;
            case AFNetworkReachabilityStatusReachableViaWWAN:
            {
                [self showMessage:@"您正在使用3G/4G网络，请注意流量"];
            }
            default:
                break;
        }
        
    }];
}
-(void)showMessage:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    
    [alert show];
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
