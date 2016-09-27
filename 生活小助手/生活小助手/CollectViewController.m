//
//  CollectViewController.m
//  生活小助手
//
//  Created by qianfeng on 15/12/4.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "CollectViewController.h"
#import "InformationViewController.h"
#import "UIView+ProgressView.h"

@interface CollectViewController () < UITableViewDataSource , UITableViewDelegate ,PostDataDelegate >

@property (nonatomic,strong) UITableView *table ;

@property (nonatomic,strong) NSArray *data;

@end

@implementation CollectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    self.view.frame = CGRectMake(0, 0, WIDEMAX, HEIGHRMAX);

    [self configUI];
    
}

-(void)recieveData:(NSArray *)dicData
{
    self.data = dicData ;
    
    [self.table reloadData];
}
-(void)configUI
{
    
    NSDictionary *dic = @{@"c":@"member",@"a":@"my_shoucang",@"appapi":@"1",@"user":[[NSUserDefaults standardUserDefaults]objectForKey:@"user"] ,@"pass":[[NSUserDefaults standardUserDefaults]objectForKey:@"pass"]};
    
    PostData *postdata = [[PostData alloc]initWithURL:shoucang_API andDic:dic];
    
    postdata.delegate = self ;
    
    self.automaticallyAdjustsScrollViewInsets = NO ;
    
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, WIDEMAX, HEIGHRMAX-64) style:UITableViewStylePlain];
    
    self.table.delegate = self ;
    self.table.dataSource = self ;
    
    self.table.showsVerticalScrollIndicator = NO ;
    
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone ;
    
    [self.view addSubview:self.table];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *string = @"collect";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:string];
    
    if(!cell)
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:string];
    
    NSDictionary *dic = self.data[indexPath.row];
    
    cell.textLabel.text = dic[@"title"];
    cell.detailTextLabel.text = dic[@"addtime"];

    return cell ;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    InformationViewController *info = [[InformationViewController alloc]init];
    
    NSDictionary *dics = self.data[indexPath.row];
    
    info.dic = @{@"id":dics[@"aid"],@"title":dics[@"title"]};
    
    info.modalTransitionStyle = UIModalTransitionStyleCoverVertical ;
    
    [self presentViewController:info animated:YES completion:nil];
    
}

-(void)viewWillAppear:(BOOL)animated
{
//    if([self.method isEqual:@"collect"])
//    {
//        self.datalist =[[NSUserDefaults standardUserDefaults] objectForKey:[[NSUserDefaults standardUserDefaults] objectForKey:@"user"]];
//    }
//    if([self.method isEqual:@"skim"])
//    {
//        NSArray *arr = [[NSUserDefaults standardUserDefaults] objectForKey:@"skim"];
//        
//        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//        
//        for (id obj in arr) {
//            
//            [dic setObject:@"1" forKey:obj];
//        }
//        
//        self.datalist = dic;
//        
//        UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//        
//        btn.bounds = CGRectMake(0, 0, 60, 20);
//        
//        
//        [btn setTitle:@"清除浏览" forState:UIControlStateNormal];
//        
//        [btn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
//        
//        
//        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
//    }
    
    [self configUI];
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
