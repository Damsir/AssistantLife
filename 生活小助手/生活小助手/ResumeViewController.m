//
//  ResumeViewController.m
//  生活小助手
//
//  Created by qianfeng on 15/12/9.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "ResumeViewController.h"

@interface ResumeViewController ()

@property (nonatomic,strong) UIWebView *webView;

@end

@implementation ResumeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self configUI];
}
-(void)configUI
{
    self.webView = [[UIWebView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://kuaidianwo.com/index.php?c=member&a=send_resume&go=1&user=%@&pass=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"user"],[[NSUserDefaults standardUserDefaults] objectForKey:@"pass"]]]];
    
    [self.webView loadRequest:request];
    
    [self.view addSubview:self.webView];
    
    
    
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
