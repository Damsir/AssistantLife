//
//  InformationViewController.m
//  生活小助手
//
//  Created by qianfeng on 15/11/25.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "InformationViewController.h"
#import "errorCode.h"
#import "UIView+ProgressView.h"
#import "UserInfo.h"
#import "UIImage+New.h"
#import "PostDicData.h"


@interface InformationViewController () < UITableViewDataSource , UITableViewDelegate,PostDicDataDelegate,UMSocialUIDelegate >

@property (nonatomic,strong) UITableView *table;

@property (nonatomic,strong) NSDictionary *datalist;

@property (nonatomic,strong) UIView *headview;

@property (nonatomic,strong) UIView *footView;

@property (nonatomic,strong) NSString *isOpen ;

@end

@implementation InformationViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSArray *array = [defaults arrayForKey:@"skim"];
    
    NSMutableArray *arr = [NSMutableArray arrayWithArray:array];
    
    [arr addObject:self.dic[@"id"]];
    
    [defaults setObject:arr forKey:@"skim"];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
     [self loadData] ;
    
    [self configUI];
    
    [self.view showJUHUAWithBool:YES];
    
    UserInfo *info = [UserInfo sharedUserInformation];
    
   if(info.userId != nil)
   {
        NSDictionary *dic = @{@"c":@"member",@"a":@"my_shoucan_check",@"appapi":@"1",@"aid":[self.dic objectForKey:@"id"],@"user":info.userId,@"pass":info.m_auth};
        
        PostDicData *postdata = [[PostDicData alloc]initWithURL:shoucang_API andDic:dic];
        
        postdata.delegate = self ;
   }
    else
    {
        [self configView:_headview];
    }
    
}
-(void)recieveData:(NSDictionary *)dicData
{
    self.isOpen = dicData[@"info"];
    
    [self configView:_headview];
}

-(void)loadData{
    
    AFHTTPRequestOperationManager *manage = [AFHTTPRequestOperationManager manager] ;
    
    manage.requestSerializer = [AFHTTPRequestSerializer serializer] ;
    
    manage.responseSerializer = [AFHTTPResponseSerializer serializer] ;
    
    NSString *str =[NSString stringWithFormat:Information_API,[self.dic objectForKey:@"id"]];
    
    [manage GET:str parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString *str = [operation.responseString substringWithRange:NSMakeRange(1, operation.responseString.length - 2)];
        
        _datalist = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
        
        [self btnFootView];
        
        [self.table reloadData];
        
        [self.view showJUHUAWithBool:NO];
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}


-(void)configUI{
    
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, 20, WIDEMAX, HEIGHRMAX-30-20) style:UITableViewStyleGrouped];
    
    self.table.delegate = self ;
    
    self.table.dataSource = self ;
    
    self.table.showsVerticalScrollIndicator = NO ;
    
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone ;
    
    [self.view addSubview:self.table];
    
    self.table.bounces = NO ;
    
    _headview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDEMAX, 40)];
    
    _headview.backgroundColor = [UIColor whiteColor];
    
    _headview.alpha = 0.5 ;
    
    self.table.tableHeaderView = _headview ;
    
    self.footView = [[UIView alloc]initWithFrame:CGRectMake(0,HEIGHRMAX - 40, WIDEMAX, 40)];
    
    self.footView.backgroundColor = [UIColor colorWithRed:0.200 green:0.400 blue:0.800 alpha:1.000];
    
    [self.view addSubview:self.footView];
    
}


-(void)configView:(UIView *)view{

    CGRect rect[3] = {{ 5 , 25 , 30 , 30 },{ WIDEMAX-80,25,30,30 },{ WIDEMAX - 40 , 25 , 30, 30 }};
    
    NSArray *iconAry = @[ @"ic_onway_guide_back" , @"ic_share_gray_small" , @"xing" ];
    
    
    for (int i = 0 ; i < 3 ; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        btn.frame = rect[i] ;
        
        [btn setBackgroundImage:[ UIImage imageNamed:iconAry[i] ] forState:UIControlStateNormal];
        
        btn.tag = 110 + i;
        
        if(i == 2)
        {
            [btn setBackgroundImage:[UIImage imageNamed:@"xing1"] forState:UIControlStateSelected];
            
            if([self.isOpen isEqualToString:@"ok"])
            {
                btn.selected = YES ;
            }
            
        }
        
        [btn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside] ;
        
        [self.view addSubview:btn];

    }
    
    UILabel *title = [[UILabel alloc]init];
    
    title.textAlignment = NSTextAlignmentCenter ;
    
    title.font =[UIFont systemFontOfSize:30];
    
    title.bounds = CGRectMake(0, 0, 70, 32);
    
    title.center = CGPointMake(WIDEMAX/2, 20) ;
    
    title.text = @"详情";
    
    title.textColor = [UIColor blueColor];
    
    [view addSubview:title];
    
}

-(void)BtnClick:(UIButton *)sender{

    if(sender.tag == 110)
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
    if(sender.tag == 112)
    {
        UserInfo *info = [UserInfo sharedUserInformation];
        
        NSDictionary *dic = @{@"c":@"member",@"a":@"shoucang_add",@"appapi":@"1",@"aid":[self.dic objectForKey:@"id"],@"user":info.userId,@"pass":info.m_auth};
        
        [self loadData:shoucang_API andDic:dic andbut:sender];
        
    }
    if(sender.tag == 111)
    {
        [self shareView];
    }
    
}

-(void)shareView
{
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"56679982e0f55a82ee00155c"
                                      shareText:@"我正在使用生活小助手,这款软件真是太棒了！！！！"
                                     shareImage:[UIImage imageNamed:@"icon"]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToWechatFavorite,nil]
                                       delegate:self];
}


-(void)loadData:(NSString *)url andDic:(NSDictionary *)dic andbut:(UIButton *)sender;
{
    
    AFHTTPRequestOperationManager *manage = [AFHTTPRequestOperationManager manager];
    
    manage.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    manage.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manage POST:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString *str = [operation.responseString substringWithRange:NSMakeRange(1, operation.responseString.length-2)];
        
        NSDictionary *dics = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
        
        NSString *mess = nil ;
        
        if([dics[@"info"] isEqualToString:@"ok"])
        {
            mess = @"收藏成功" ;
            
            sender.selected = YES ;
 
        }
        
        else if([dics[@"info"] isEqualToString:@"no"])
        {
            mess = @"已取消收藏" ;
            
            sender.selected = NO ;
            
        }
        
        else
        {
            mess = @"请登录后操作" ;
        }
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:mess delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        [alert show];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error.localizedDescription);
        
    }];
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 4 ;
}



-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    if (section == 0)
        {
            return nil ;
        }
    
    else if(section == 1)
        {
            UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,WIDEMAX , 20)];
            
            title.text = [NSString stringWithFormat:@"%@%@",@"  ",[self.dic objectForKey:@"title"]];
            
            title.font = [UIFont boldSystemFontOfSize:20];
            
            title.numberOfLines = 2 ;
            
                return title ;
        }
    else if(section == 2)
        {
            UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, WIDEMAX, 20)];
            
            title.text = @"  Decribution ";
            
            title.font = [UIFont boldSystemFontOfSize:20] ;
            
            return title ;
        }
    else
        {
            UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, WIDEMAX, 20)];
            
            title.text = @"  相关信息 " ;
            
            title.font = [UIFont boldSystemFontOfSize:20] ;
            
            return title ;
        }
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    switch (section)
    {
        case 1:
            return [self.datalist[@"fields"] count]+1 ;
            break;
            
        case 2:
            return 1 ;
            break ;
            
        case 3:
            return [self.datalist[@"newtwo"] count] ;
            break ;
        default:
            return 1 ;
            break;
    }
}



-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    if(section == 0)
        return 0 ;
    if(section == 1)
        return [[NSString stringWithFormat:@"%@%@",@"  ",[self.dic objectForKey:@"title"]] boundingRectWithSize:CGSizeMake(WIDEMAX, MAXFLOAT) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size.height;
    else
        return 17 ;
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0 ;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    if(indexPath.section == 0)
    {
        if([[self.datalist objectForKey:@"m_img"] count])
            return 250;
        else
            return 0 ;
    }
    else if(indexPath.section == 1)
    {
        return 30 ;
    }
    else if(indexPath.section == 2)
    {
        errorCode *code = [[errorCode alloc]init];
        
        if([[self.datalist objectForKey:@"info"] objectForKey:@"fangyuan_ms"] != nil)
            [code analysisByErrorCode:[[self.datalist objectForKey:@"info"] objectForKey:@"fangyuan_ms"]];
        
        CGRect rect = [code.data boundingRectWithSize:CGSizeMake(WIDEMAX, MAXFLOAT) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil];
        
            return rect.size.height ;
    }
    else
    {
            return 60 ;
    }
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    NSString *cellId = [NSString stringWithFormat:@"cell%ld",indexPath.section];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    

    
    if(!cell)
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone ;
    
    [self costomCell:cell andAtIndexPath:indexPath];
    
    return cell ;
    
    
}

-(void)costomCell:(UITableViewCell *)cell andAtIndexPath:(NSIndexPath *)indexPath{

    if(indexPath.section == 0)
    {
       [cell.contentView addSubview:[self scrollViewByHeader]] ;
    }
    else if(indexPath.section == 1)
    {
        if(self.datalist.count)
            [self appromiateByTable:cell andAtIndexPath:indexPath] ;
    }
    else if(indexPath.section == 2)
    {
        [self descributionAndInformation:cell];
    }
    else
    {
        [self relateWithLoadLinkAndCell:cell andAtIndexPath:indexPath];
    }
}

-(void)relateWithLoadLinkAndCell:(UITableViewCell *)cell andAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < 2) {
      
        cell.imageView.image = [UIImage imageNamed:@"qwrerqwe"];
        
        cell.textLabel.text = [self.datalist[@"newtwo"][indexPath.row] objectForKey:@"title"] ;
        
        cell.detailTextLabel.text = [self.datalist[@"newtwo"][indexPath.row] objectForKey:@"addtime"];
        
    }
  
    
    
}

-(void)btnFootView
{
    
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    
//    btn.frame = CGRectMake(5, 5, 80, 30);
//    
//    [btn setTitle:@"申请职位" forState:UIControlStateNormal];
//    
//    btn.backgroundColor = [UIColor blueColor];
//    
//    [btn addTarget:self action:@selector(sqBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    
//    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    
//    [self.footView addSubview:btn];
    
    UIButton *btnPhone = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btnPhone.frame = CGRectMake(WIDEMAX-80, 5, 30, 30);
    
    [btnPhone setImage:[UIImage resizableImage:@"ic_dest_poi_phone" andSize:CGSizeMake(200, 200)] forState:UIControlStateNormal];
    
    [btnPhone addTarget:self  action:@selector(phoneBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.footView addSubview:btnPhone];
    
    UIButton *btnemail = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btnemail.frame = CGRectMake(WIDEMAX-40, 5, 30, 30);
    
    [btnemail setImage:[UIImage resizableImage:@"ic_dest_info_qanda_normal" andSize:CGSizeMake(200, 200)] forState:UIControlStateNormal];
    
    [btnemail addTarget:self  action:@selector(emailBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.footView addSubview:btnemail];

}

-(void)sqBtnClick:(UIButton *)sender
{
    
    
}
-(void)phoneBtnClick:(UIButton *)sender
{
    UIApplication *delegate = [UIApplication sharedApplication] ;
    NSString *tle =[[self.datalist objectForKey:@"info"] objectForKey:@"phone"];
    [delegate openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",tle]]];
}
-(void)emailBtnClick:(UIButton *)sender
{
    UIApplication *delegate = [UIApplication sharedApplication] ;
    NSString *tle =[[self.datalist objectForKey:@"info"] objectForKey:@"phone"];
    [delegate openURL:[NSURL URLWithString:[NSString stringWithFormat:@"sms://%@",tle]]];
}
-(void)descributionAndInformation:(UITableViewCell *)cell{

    
    errorCode *code = [[errorCode alloc]init];

    
    if([[self.datalist objectForKey:@"info"] objectForKey:@"fangyuan_ms"] != nil)
        [code analysisByErrorCode:[[self.datalist objectForKey:@"info"] objectForKey:@"fangyuan_ms"]];
    
    cell.textLabel.text = code.data;
    
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    
    cell.textLabel.numberOfLines = 0 ;
    
    cell.textLabel.textColor = [UIColor lightGrayColor];
    
}

-(void)appromiateByTable:(UITableViewCell *)cell andAtIndexPath:(NSIndexPath *)indexPath{

    if(indexPath.row == 0)
    {
        UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 20, 20)];
        
        imageview.image = [UIImage imageNamed:@"ic_deal_time"];
        
        [cell.contentView addSubview:imageview];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imageview.frame)+5, 5,100, 20)];
        
        label.text = [self.datalist[@"info"] objectForKey:@"addtime"];
        
        label.font = [UIFont fontWithName:@"Courier" size:15];
        
        [cell.contentView addSubview:label];
        
        UIImageView *imageview1 = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(label.frame)+20, 5, 20, 20)];
        
        imageview1.image = [UIImage imageNamed:@"ic_bbs_read"];
        
        [cell.contentView addSubview:imageview1];
        
        UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imageview1.frame)+5, 5, 140, 20)];
        
        label1.text = [NSString stringWithFormat:@"已有%@人浏览",[self.datalist[@"info"] objectForKey:@"hits"]];
        
        label1.font = [UIFont fontWithName:@"Courier" size:15];
        
        [cell.contentView addSubview:label1];
        
    }
    
    else
    {
        NSMutableString *str2 = [NSMutableString string] ;
        
        NSDictionary *diction = self.datalist[@"info"];
        
        NSArray *fields = self.datalist[@"fields"];

        cell.textLabel.textColor = [UIColor blackColor];
        
        if(diction[[fields[indexPath.row-1] objectForKey:@"fields"]] == nil){
                    [str2 appendString:@"未知"];
        }
        else
        {
            str2 = diction[[fields[indexPath.row-1] objectForKey:@"fields"]] ;
        }
        
        NSString *str1 = [NSString stringWithFormat:@"%@: %@",[fields[indexPath.row-1] objectForKey:@"fieldsname"],str2] ;
        
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@",str1]];

        [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithWhite:0.400 alpha:1.000] range:[str1 rangeOfString:str2]] ;
        
        [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:[str1 rangeOfString:str2]];

        cell.textLabel.attributedText = str;
        
            cell.textLabel.adjustsFontSizeToFitWidth = YES ;
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 3)
    {
        self.dic =  self.datalist[@"newtwo"][indexPath.row];
        
        [self viewDidLoad];
    }
    
    
}




















-(UIScrollView *)scrollViewByHeader{

    NSArray *dics = [self.datalist objectForKey:@"m_img"];
    UIScrollView *scroll ;
    if(dics.count)
         scroll= [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WIDEMAX, 250)];
    else
        scroll = nil ;
    scroll.backgroundColor = [UIColor colorWithRed:0.000 green:0.800 blue:1.000 alpha:1.000];
    
    for (int i = 0 ; i < dics.count ; i++) {
        
        UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(WIDEMAX * i, 0, WIDEMAX, scroll.frame.size.height)];
        
       NSString *str = [NSString stringWithFormat:@"%@%@",http_APi,[dics[i] firstObject]];
        
        [imageview sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"9d55c3f42bd151674bfd5e40e5fd4780"]];
        
        [scroll addSubview:imageview] ;
        
    }
    
    scroll.contentSize = CGSizeMake(WIDEMAX * dics.count, 0) ;
    
    scroll.pagingEnabled = YES ;
    
    return scroll ;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.table reloadData];
}








//-(void)viewDidAppear:(BOOL)animated{
//
//    [self.table reloadData];
//}




























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
