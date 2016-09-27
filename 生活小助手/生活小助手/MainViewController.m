//
//  MainViewController.m
//  生活小助手
//
//  Created by qianfeng on 15/11/20.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "MainViewController.h"
#import "TabBarViewController.h"
#import "DrawerViewController.h"
#import "MJExtension.h"
#import "OptionViewController.h"
#import "AppDelegate.h"
#import "UIView+ProgressView.h"
#import "UserInfo.h"




@interface MainViewController () < UITableViewDataSource , UITableViewDelegate  >
{
    DrawerViewController *VC ;
    
    OptionViewController *option ;
}
@property (nonatomic,strong) UITableView *table;

@property (nonatomic,strong) MJModelName *MJmodel;

@property (nonatomic,strong) TabBarViewController *drawer;

@property (nonatomic,strong) NSArray *datalist;

@property (nonatomic,assign) NSInteger index;

//@property (nonatomic,strong) ;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
    UserInfo *info = [UserInfo sharedUserInformation];
    
    info.userId = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
    
    info.m_auth = [[NSUserDefaults standardUserDefaults] objectForKey:@"pass"];
    
    UIImageView *image = [[UIImageView alloc]initWithFrame:self.view.bounds];
    
    image.image = [UIImage imageNamed:@"Mian_background"];
    
    [self.view addSubview:image];
    
    [self.view sendSubviewToBack:image];
    
    AppDelegate *delegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
    
    
     VC=(DrawerViewController *)delegate.window.rootViewController;
    
    option=(OptionViewController *)VC.leftViewController;

    
    self.navigationController.navigationBar.translucent = NO;
    
    _drawer = (TabBarViewController *)self.navigationController.tabBarController;
    
    [self loadData];
    
    [self configUI];
    
    [self navigationBySetting];
}

-(void)navigationBySetting
{
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.669 green:1.000 blue:0.448 alpha:1.000];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(Drawer)];
    
     [self.view showJUHUAWithBool:YES];
    
   VC.view.userInteractionEnabled = NO ;
}
-(void)Drawer
{
    if(!VC.isOpen)
    {
        [VC openLeftDrawer];
    }
    else
    {
        [VC closeDrawer];
        
    }
}


-(void)loadData
{
    
    AFHTTPRequestOperationManager *manage = [AFHTTPRequestOperationManager manager] ;
    
    manage.requestSerializer = [AFHTTPRequestSerializer serializer] ;
    
    manage.responseSerializer = [AFHTTPResponseSerializer serializer] ;
    
    [manage GET:Main_API parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString *str = [operation.responseString substringWithRange:NSMakeRange(7, operation.responseString.length-8)];
        
        _MJmodel = [[MJModelName alloc]mj_setKeyValues:str];
        
        [_MJmodel parseForAry:_MJmodel.classtype];
        
        _datalist = _MJmodel.firstModelAry ;
        
         [self creatsScrollView];
        
        [_table reloadData];
        
        [self.view showJUHUAWithBool:NO];
        
        VC.view.userInteractionEnabled = YES ;
        
        [_table.header endRefreshing];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error.localizedDescription);
    }];
}
-(void)configUI
{
  
    _table = [[UITableView alloc]init];
    
    _table.frame = CGRectMake(0,0, WIDEMAX, HEIGHRMAX-64-44);
    
    _table.delegate = self ;
    
    _table.dataSource = self ;
    
    _table.backgroundColor = [UIColor clearColor];

    _table.showsVerticalScrollIndicator = NO ;
    
    _table.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        {
            [self loadData];
        }
    }];
    
    _table.separatorStyle = UITableViewCellSeparatorStyleNone ;
    
    [self.view addSubview:_table];
    
    
    
}

-(void)creatsScrollView
{
    UIScrollView *scroll = [[UIScrollView alloc]init];
    
    scroll.frame = CGRectMake(0, 0, WIDEMAX, 200);
    
    NSDictionary *dic1 = [_MJmodel.ads objectForKey:@"1"] ;
    NSDictionary *dic2 = [_MJmodel.ads objectForKey:@"2"] ;
    
    NSArray *arry = @[dic1,dic2];
    
    for (int i = 0; i < 2; i++) {
        
        UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0 + WIDEMAX*i, WIDEMAX, 200)];
        
        [imageview sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HTTP_API,[arry[i] objectForKey:@"adfile"]]]];
        
        [scroll addSubview:imageview];
    }
    
    self.table.tableHeaderView = scroll ;
    
    scroll.showsHorizontalScrollIndicator = NO ;
    
    scroll.bounces = NO ;
    
    scroll.contentSize = CGSizeMake(WIDEMAX*2, 0);
    
    [_table reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _datalist.count ;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cellId";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if(!cell)
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HTTP_API,[_datalist[indexPath.row] objectForKey:@"appico"]]] placeholderImage:[UIImage imageNamed:@"quancheng"]];
    
    cell.imageView.layer.cornerRadius = 22 ;
    cell.imageView.layer.masksToBounds = YES ;
    
    cell.backgroundColor = [UIColor clearColor];
    
    cell.textLabel.text = [_datalist[indexPath.row] objectForKey:@"classname"];
    
    cell.textLabel.textColor = [UIColor colorWithRed:0.000 green:1.000 blue:0.200 alpha:1.000];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(!VC.isOpen)
    {
        [VC openLeftDrawer];
    }
    
    [option changDictionAry:_datalist[indexPath.row]];
    
    _index = indexPath.row ;
    
}

-(UITableViewCellAccessoryType)tableView:(UITableView *)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath
{
    return  UITableViewCellAccessoryCheckmark;
}

-(void)viewDidAppear:(BOOL)animated
{
    
    UIImageView *imageview = [[UIImageView alloc]init];
    
    imageview.bounds = CGRectMake(0, 0, 70, 70);
    
    imageview.center = CGPointMake(WIDEMAX/2,10) ;
    
    imageview.image = [UIImage imageNamed:@"tabbar_np_default"];
    
    [self.tabBarController.tabBar addSubview:imageview];
    
    UIImageView *image = [[UIImageView alloc]init];
    
    image.bounds = CGRectMake(0, 0, 48, 48);
    
    image.center = CGPointMake(WIDEMAX/2,13);
    
    image.image = [UIImage imageNamed:@"ic_public_btn_add"];
    
    [self.tabBarController.tabBar addSubview:image];
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [VC closeDrawer];
    
    for (UIView *obj in VC.view.subviews) {
        
        if([obj isKindOfClass:[UISwipeGestureRecognizer class]])
        {
            NSLog(@"-----------------fsdaf----------------");
        }
        
        NSLog(@"%@",[VC class]);
    }
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
