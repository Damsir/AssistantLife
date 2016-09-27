//
//  RegiViewController.m
//  生活小助手
//
//  Created by qianfeng on 15/12/4.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "RegiViewController.h"
#import "OneSelfViewController.h"
#import "UserInfo.h"

@interface RegiViewController ()

@end

@implementation RegiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDEMAX, HEIGHRMAX)];
    
    imageview.image = [UIImage imageNamed:@"Launching"];
    
    [self.view addSubview:imageview];
    
    self.view.frame = CGRectMake(0, 0, WIDEMAX, HEIGHRMAX);
    
    self.navigationController.navigationBar.hidden = NO ;
    

    [self configUI];
}

-(void)configUI
{
  
    NSArray *arr = @[@"用户名",@"密   码",@"确认密码",@"邮   箱"];
    
    NSArray *place1 = @[@"字母与数字组合", @"6-12数字与字母" , @"重新输入密码" , @"找回密码用的"];
    
    for (int i = 0; i < 4; i++) {
        
        UITextField *field = [[UITextField alloc]init];
        
        field.bounds = CGRectMake(0, 0, WIDEMAX * 0.4, 28);
        
        field.center = CGPointMake(WIDEMAX/1.8, 114 + i * 50);
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(field.frame.origin.x-100, field.frame.origin.y, WIDEMAX * 0.3, 28)];
        
        field.tag = 999 + i ;
        
        label.textColor = [UIColor whiteColor];
        
        label.textAlignment = NSTextAlignmentCenter ;
        
        label.text = arr[i];
        
        field.placeholder = place1[i];
        
        field.borderStyle = UITextBorderStyleRoundedRect ;
        
        [self.view addSubview:field];
        
        [self.view addSubview:label];
    }
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn.bounds = CGRectMake(0, 0, 100, 30);
    
    btn.center = CGPointMake(WIDEMAX/2.0, 320);
    
    [btn setTitle:@"完成注册" forState:UIControlStateNormal];
    
    btn.backgroundColor = [UIColor blueColor];
    
    [self.view addSubview:btn];
                     
    [btn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn1.bounds = CGRectMake(0, 0, 100, 30);
    
    btn1.center = CGPointMake(WIDEMAX/2.0, btn.center.y + 50);
    
    [btn1 setTitle:@"返   回" forState:UIControlStateNormal];
    
    btn1.backgroundColor = [UIColor blueColor];
    
    [self.view addSubview:btn1];
    
    [btn1 addTarget:self action:@selector(Btn1Click:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)BtnClick:(UIButton *)sender
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"c":@"member",@"a":@"reg"}];
    
    NSArray *str = @[@"user",@"pass",@"pass1",@"email"];
    
    for (int i= 0 ; i < 4; i++) {
        
        UITextField *filed = (id)[self.view viewWithTag:(i + 999)];
        
        [dic setObject:filed.text forKey:str[i]];
    }
   
    [self loadData:regis_API andDic:dic];
    
}
-(void)Btn1Click:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)loadData:(NSString *)url andDic:(NSDictionary *)dic
{
    
    AFHTTPRequestOperationManager *manage = [AFHTTPRequestOperationManager manager];
    
    manage.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    manage.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manage POST:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString *str = [operation.responseString substringWithRange:NSMakeRange(1, operation.responseString.length-2)];
        
        NSDictionary *dics = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
        
        if([dics[@"info"] isEqualToString:@"ok"])
        {
            OneSelfViewController *osvc = [[OneSelfViewController alloc]init];
            
             NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            
            [defaults setBool:YES forKey:@"Mycontro"];
            
            [self.navigationController pushViewController:osvc animated:YES];
            
            UserInfo *info = [UserInfo sharedUserInformation];
            
            info.userId = dic[@"user"];
            
            info.m_auth = dic[@"pass"];
            
            [defaults setObject:info.userId forKey:@"user"];
            
            [defaults setObject:info.m_auth forKey:@"pass"];
            
        }
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:dics[@"info"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        [alert show];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error.localizedDescription);
        
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
