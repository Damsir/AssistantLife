//
//  InfoBaseViewController.m
//  生活小助手
//
//  Created by qianfeng on 15/11/24.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "InfoBaseViewController.h"
#import "InfoModel.h"
#import "MJExtension.h"
#import "InfoTableViewCell.h"
#import "InformationViewController.h"
#import "Cored.h"
#import "MJRefresh.h"
#import "UIView+ProgressView.h"


@interface InfoBaseViewController () < UIPickerViewDataSource , UIPickerViewDelegate ,UITableViewDataSource , UITableViewDelegate  >
{
    InfoModel *model ;
    
    NSInteger num ;
    
    NSString *urlStr ;
    
}
@property (nonatomic,strong) NSArray *datalist;

@property (nonatomic,strong) NSArray *dataOption;

@property (nonatomic,strong) UIPickerView *pickView ;

@property (nonatomic,strong) UITableView *table;

@property (nonatomic,strong) UIView *pView;

@property (nonatomic,strong) NSArray *string;

@property (nonatomic,strong) NSTimer *timer;
@end

@implementation InfoBaseViewController
static BOOL isRuning = NO ;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
    
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:self.view.bounds];
    
    imageview.image = [UIImage imageNamed:@"b13cb4c7276ffc01df807b849e682adc"];
    
    [self.view addSubview:imageview];
    
    [self.view sendSubviewToBack:imageview];
    
    self.view.backgroundColor = [UIColor clearColor];
    
    urlStr = self.url ;
    
    [self loadData];
    
    [self tableOfView];
 
     [self.view showJUHUAWithBool:YES];
    
    self.table.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadData];
    }];
}

-(void)loadData
{
    
     [self.view showJUHUAWithBool:YES];
    AFHTTPRequestOperationManager *manage = [AFHTTPRequestOperationManager manager];
    
    manage.requestSerializer = [AFHTTPRequestSerializer serializer] ;
    
    manage.responseSerializer = [AFHTTPResponseSerializer serializer] ;
    
    [manage GET:_url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString *str = [operation.responseString substringWithRange:NSMakeRange(1, operation.responseString.length - 2)];
        
         self.datalist = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
        
        [self.table reloadData];
        
        [self.view showJUHUAWithBool:NO];
        
        [self.table.header endRefreshing];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error.localizedDescription);
    }];
    
    if(!isRuning)
    {
        [manage GET:[NSString stringWithFormat:Option_API,self.tid] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSString *str = [operation.responseString substringWithRange:NSMakeRange(1, operation.responseString.length - 2)];
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
            
            self.dataOption = [dic objectForKey:@"fields_search"];
        
            [self.view showJUHUAWithBool:NO];
            
            [self configUI];

        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            NSLog(@"%@",error.localizedDescription);
        }];
        
        isRuning = YES ;
    }
}

-(void)btnBackClick:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)configUI
{
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, WIDEMAX, 44)];
    
    backView.backgroundColor = [UIColor colorWithRed:1.000 green:1.000 blue:0.400 alpha:1.000];
    
    [self.view addSubview:backView ];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [backBtn setTitle:@"返 回" forState:UIControlStateNormal];
    
    [backBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    
    backBtn.frame = CGRectMake(10,11, 60, 20);
    
    [backBtn addTarget:self action:@selector(btnBackClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [backView addSubview:backBtn];
    
    UILabel *label = [[UILabel alloc]init];
    
    label.bounds = CGRectMake(0, 0, WIDEMAX-2*backBtn.frame.size.width, 25);
    
    label.center = CGPointMake(WIDEMAX/2, 44/2);
    
    label.textAlignment = NSTextAlignmentCenter ;
    
    label.text = self.title ;
    
    label.textColor = [UIColor whiteColor];
    
    backView.backgroundColor = [UIColor clearColor];
    
    [backView addSubview:label];
    
    UIScrollView *view = [[UIScrollView alloc]initWithFrame:CGRectMake(0, HEIGHRMAX- 40, WIDEMAX, 40)];
    
//    view.backgroundColor = [UIColor colorWithRed:0.200 green:0.600 blue:0.200 alpha:1.000];
    
    [self.view addSubview:view];
    
    CGFloat weith ;
    
    if(self.dataOption.count < 5)
    {
        weith = (WIDEMAX-40)/self.dataOption.count ;
    }
    else
    {
        weith = 80 ;
    }
    for (int i = 0; i < self.dataOption.count ; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        btn.bounds = CGRectMake(0, 0, weith, 30);
        
        btn.center = CGPointMake( i*(weith+10)+(weith/2+10) , 20);
        
        [btn setTitle:[self.dataOption[i] objectForKey:@"name"]  forState:UIControlStateNormal];
        
        [btn setTitleColor:[UIColor colorWithRed:0.600 green:0.800 blue:0.400 alpha:1.000] forState:UIControlStateNormal] ;
        
        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
        
        [view addSubview:btn];
        
        btn.tag = i+100 ;
        
        [btn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    view.contentSize = CGSizeMake((weith+10)*self.dataOption.count, 0);
    
    view.showsHorizontalScrollIndicator = NO ;
    
    view.backgroundColor = [UIColor colorWithWhite:0.600 alpha:1.000];
    
    view.bounces = NO ;
}

-(void)tableOfView
{
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, WIDEMAX, HEIGHRMAX-104)];
    
    self.table.delegate = self ;
    
    self.table.dataSource = self ;
    
    self.table.showsVerticalScrollIndicator = NO ;
    
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone ;
    
    self.table.backgroundColor = [UIColor colorWithWhite:0.500 alpha:0.300];
    
    [self.view addSubview:self.table];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datalist.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellId = [NSString stringWithFormat:@"%ld",indexPath.row];
    
    InfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId] ;
    
    if(!cell)
        cell = [[InfoTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    
    NSDictionary *dic = self.datalist[indexPath.row] ;
    
    if(![dic objectForKey:@"litpic"])
    {
        cell.imageview.image = [UIImage imageNamed:@"qwrerqwe"];
    }
    else
        [cell.imageview sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HTTP_API,[dic objectForKey:@"litpic"]]] placeholderImage:[UIImage imageNamed:@"qwrerqwe"]];
    cell.imageview.layer.cornerRadius = 15 ;
    cell.imageview.layer.masksToBounds = YES ;
    
    cell.title.text = dic[@"title"];
    cell.address.text = dic[@"description"];
    cell.quyu.text = dic[@"quyu"];
    cell.data.text = dic[@"addtime"];
    
    
    cell.backgroundColor = [UIColor clearColor];
    
    return cell ;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80 ;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    InformationViewController *inform = [[InformationViewController alloc]init];
    
    inform.dic = self.datalist[indexPath.row];
    
    inform.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal ;
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self presentViewController:inform animated:YES completion:nil];
    
}

-(void)BtnClick:(UIButton *)sender
{
    self.index = 0 ;
    
        num = sender.tag - 100 ;
    
    self.string = [self.dataOption[num] objectForKey:@"options"];
    
    self.pickView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, HEIGHRMAX, WIDEMAX, 115)];
    
    self.pView = [[UIView alloc]initWithFrame:CGRectMake(0, HEIGHRMAX, WIDEMAX, 35)];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.pickView.frame = CGRectMake(0, HEIGHRMAX-115, WIDEMAX, 115);
        self.pView.frame = CGRectMake(0, HEIGHRMAX-150, WIDEMAX, 35);
    }];
    
    self.pickView.delegate = self ;
    self.pickView.dataSource = self ;
    
    self.pickView.backgroundColor = [UIColor colorWithRed:0.000 green:0.600 blue:0.800 alpha:0.800];
    self.pView.backgroundColor = [UIColor colorWithRed:0.000 green:0.600 blue:0.800 alpha:0.800];
    
    [self.view addSubview:self.pickView];
    [self.view addSubview:self.pView];
    
    
    
    NSArray *arr = @[@"取消",@"确定"];
    
    for (int i = 0; i < 2 ; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        btn.frame = CGRectMake(20+i*(WIDEMAX - 80), 2.5, 40, 30);
        
        [self.pView addSubview:btn];
        
        btn.tag = 1000+i ;
        
        [btn addTarget:self action:@selector(BtnPickerClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    
}
-(void)BtnPickerClick:(UIButton *)sender
{
    if(sender.tag == 1001)
    {
        if(self.index == 0 )
        {
            NSLog(@"fds");
            self.url = [NSString stringWithFormat:@"%@",urlStr] ;
        }
        else
            self.url = [NSString stringWithFormat:@"%@&%@=%ld",urlStr,[self.dataOption[num] objectForKey:@"field"],self.index];
        
        [self loadData];
    }
    [UIView animateWithDuration:0.3 animations:^{
        self.pickView.frame = CGRectMake(0, HEIGHRMAX, WIDEMAX, 0);
        self.pView.frame = CGRectMake(0, HEIGHRMAX, WIDEMAX, 0);
    }];
    
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1 ;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.string.count ;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.string[row];
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.index = row ;
    NSLog(@"%ld",row) ;
}
-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *pickerLabel = (UILabel *)view ;
    
    if(!pickerLabel)
    {
        pickerLabel = [[UILabel alloc]init];
        
        pickerLabel.textColor = [UIColor redColor];
        
        pickerLabel.textAlignment = NSTextAlignmentCenter ;
        
    }
    
    pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    
    return pickerLabel ;
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    isRuning = NO ;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [UIView animateWithDuration:0.3 animations:^{
        self.pickView.frame = CGRectMake(0, HEIGHRMAX, WIDEMAX, 0);
        self.pView.frame = CGRectMake(0, HEIGHRMAX, WIDEMAX, 0);
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
