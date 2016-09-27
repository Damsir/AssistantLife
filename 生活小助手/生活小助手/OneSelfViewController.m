//
//  OneSelfViewController.m
//  生活小助手
//
//  Created by qianfeng on 15/12/4.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "OneSelfViewController.h"
#import "MyViewController.h"
#import "CollectViewController.h"
#import "AlterViewController.h"
#import "SkimViewController.h"
#import "ResumeViewController.h"



@interface OneSelfViewController () < UITableViewDataSource , UITableViewDelegate ,UIAlertViewDelegate >

@property (nonatomic,strong) UITableView *tableview;

@property (nonatomic,strong) UIView *lauchView;

@property (nonatomic,assign) BOOL isLauch;

@property (nonatomic,strong) NSArray *arr;

@end

@implementation OneSelfViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
     NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    self.isLauch = [defaults boolForKey:@"Mycontro"];
    
    if(!self.isLauch)
    {
        [self launch];
    }
    else
    {
        [self configUI];
        
        [defaults setBool:YES forKey:@"launch"];
        
    }
    
}
-(void)launch
{
    self.lauchView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    self.lauchView.backgroundColor = [UIColor colorWithWhite:0.900 alpha:1.000];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [btn setTitle:@"请登录" forState:UIControlStateNormal];
    
    btn.bounds = CGRectMake(0, 0, 100, 30);
    
    btn.center = CGPointMake(WIDEMAX/2.0, HEIGHRMAX/2.0);
    
    [self.lauchView addSubview:btn];
    
    [self.view addSubview:self.lauchView];
    
    [btn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
}
-(void)BtnClick:(UIButton *)sender
{
    MyViewController *my = [[MyViewController alloc]init];
    
    [self.navigationController pushViewController:my animated:YES];
}
-(void)configUI
{
    
    self.tabBarController.tabBar.hidden = NO ;
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, WIDEMAX, HEIGHRMAX-104) style:UITableViewStylePlain];
    
    self.tableview.backgroundColor = [UIColor colorWithWhite:0.800 alpha:1.000];
    
    [self.view addSubview:self.tableview];
    
    self.tableview.delegate = self ;
    
    self.tableview.dataSource = self ;
    
    self.arr = @[@"我的发布",@"我的收藏",@"我的浏览",@"修改资料",@"退出登录"];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 20, WIDEMAX, 44)];
    
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc]init];
    
    label.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
    
    label.bounds = CGRectMake(0, 0, 200, 35);
    
    label.center = CGPointMake(view.frame.size.width/2.0, view.frame.size.height/2.0);
    
    label.textAlignment = NSTextAlignmentCenter ;

    label.font = [UIFont boldSystemFontOfSize:25];
    
    label.textColor = [UIColor blueColor];
    
    [view addSubview:label];
    
    [self.view addSubview:view];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arr.count ;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid = @"table";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    
    if(!cell)
        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellid];
    
    cell.textLabel.text = self.arr[indexPath.row];
    
    return cell ;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    switch (indexPath.row) {
        case 0:
            
            break;
        case 1:
        {
            CollectViewController *cvc = [[CollectViewController alloc]init];
            
            [self.navigationController pushViewController:cvc animated:YES];
        }
            break;
        case 2:
        {
            
            SkimViewController *skim = [[SkimViewController alloc]init];
            
            [self.navigationController pushViewController:skim animated:YES];
            
        }
            break;
        case 3:
        {
            AlterViewController *alter = [[AlterViewController alloc]init];
            
            [self.navigationController pushViewController:alter animated:YES];
        }
            break;
            case 4:
        {
            UIAlertView *alerw = [[UIAlertView alloc]initWithTitle:@"提示" message:@"是否退出登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            
            [defaults removeObjectForKey:@"user"];
            [defaults removeObjectForKey:@"pass"];
            
            [defaults setBool:NO forKey:@"Mycontro"];
           
            
            [alerw show];
        }
            break;
        default:
            break;
    }
    
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60 ;
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1)
    {
        [self releaveOflaunch];
    }
}
-(void)releaveOflaunch
{
    MyViewController *my = [[MyViewController alloc]init];

    [self.navigationController pushViewController:my animated:YES];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    self.tabBarController.hidesBottomBarWhenPushed = YES ;
    
    self.navigationController.navigationBar.hidden = NO ;
}
-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.hidesBottomBarWhenPushed = NO ;
    
    self.navigationController.navigationBar.hidden = YES ;
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
