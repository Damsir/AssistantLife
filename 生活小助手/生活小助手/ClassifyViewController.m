//
//  ClassifyViewController.m
//  生活小助手
//
//  Created by qianfeng on 15/11/20.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "ClassifyViewController.h"
#import "AFNetworking.h"
#import "ClassifyModel.h"
#import "MJModelName.h"
#import "Classifymodels.h"
#import "MJExtension.h"
#import "InfoBaseViewController.h"


@interface ClassifyViewController () < UISearchBarDelegate , UICollectionViewDataSource ,UICollectionViewDelegate  >

@property (nonatomic,strong) UICollectionView *collection;

@property (nonatomic,strong) NSArray *datalist;

@end

@implementation ClassifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.barTintColor = [UIColor lightGrayColor];
    
    [self loadData];
    
    [self configUI];
    
}

-(void)loadData
{
    AFHTTPRequestOperationManager *manage = [AFHTTPRequestOperationManager manager];
    
    manage.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    manage.responseSerializer = [AFHTTPResponseSerializer serializer] ;
    
//    [manage GET:classify_API parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *str = [operation.responseString substringWithRange:NSMakeRange(1, operation.responseString.length-2)];
//        
//        NSArray *list=[classifyClassname arrayOfModelsFromData:[str dataUsingEncoding:NSUTF8StringEncoding]  error:nil];
//        
//        self.datalist = list ;
//        
//        [self.collection reloadData];
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//    }];
    
    [manage GET:classify_API parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString *str = [operation.responseString substringWithRange:NSMakeRange(1, operation.responseString.length-2)];
    
        NSArray *list=[classifyClassname arrayOfModelsFromData:[str dataUsingEncoding:NSUTF8StringEncoding]  error:nil];
        
        self.datalist = list ;
        
        [self.collection reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error.localizedDescription);
        
    }];
}


-(void)configUI
{
    self.navigationItem.title = @"分类";
    
    CGSize size = CGSizeMake((WIDEMAX-30)/2.0, 40);
    
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc]init];
    
    flow.itemSize = size ;
    
    flow.minimumLineSpacing = 10 ;
    
    flow.minimumInteritemSpacing = 5 ;
    
    flow.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    flow.headerReferenceSize = CGSizeMake(20, 80);
    
    self.collection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, WIDEMAX, HEIGHRMAX-64) collectionViewLayout:flow];
    
    self.collection.backgroundColor = [UIColor colorWithWhite:0.800 alpha:0.500];
    
    [self.collection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellid"];
    
    [self.collection registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"lulu"];
    
    self.collection.delegate = self ;
    
    self.collection.dataSource = self ;
    
    self.collection.showsVerticalScrollIndicator = NO ;
    
    [self.view addSubview:self.collection];
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    classifyClassname *model = self.datalist[section] ;
    
    return  model.c.count ;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor colorWithWhite:0.800 alpha:1.000];
    
    NSArray *views=[cell.contentView subviews];
    
    for (UIView *view in views) {
        
        [view removeFromSuperview];
    }
    
    
    UIView *view = [[UIView alloc]init];
    
    view.backgroundColor =[UIColor whiteColor];
    
    view.frame = CGRectMake(1,1, cell.frame.size.width-2, cell.frame.size.height-2);
    
    [cell.contentView addSubview:view];
    
    [cell.contentView sendSubviewToBack:view];
    
    UILabel *label = [[UILabel alloc]initWithFrame:view.bounds];
    
    classifyClassname *model = self.datalist[indexPath.section];
   
    classifyinfoModel *name = model.c[indexPath.row] ;
    
    label.text = name.classname;
    
    
    
    label.textColor = [UIColor blackColor];
    
//    label.text = @"asfd";
    
    label.textAlignment = NSTextAlignmentCenter ;
    
    label.font = [UIFont fontWithName:@"Helvetica Neue" size:15];
    
    [view addSubview:label];
    
    return cell ;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    classifyClassname *model = self.datalist[indexPath.section];
    
    UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"lulu" forIndexPath:indexPath];
    
    NSArray *arr = [view subviews];
    
    for (id obj in arr) {
        
        [obj removeFromSuperview];
        
    }
    
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 60, 60)];
    
//    imageview.backgroundColor = [UIColor blueColor];
    
    imageview.layer.cornerRadius = 30 ;
    
    imageview.layer.masksToBounds = YES ;
    
    [imageview sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",http_APi,model.appico]] placeholderImage:[UIImage imageNamed:@"sunshine-icon"]];
    
    [view addSubview:imageview];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imageview.frame)+10,imageview.frame.origin.y + 15 , 200, 30)];
    
//    label.backgroundColor = [UIColor blueColor];
    
    label.text = model.classname ;
    
    label.textColor = [UIColor blackColor];
    
    [view addSubview:label];
    
    
    return view;
    
    
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 5 ;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
  
    
     InfoBaseViewController *info = [[InfoBaseViewController alloc]init];
    
    classifyClassname *model = self.datalist[indexPath.section];
    
    classifyinfoModel *name = model.c[indexPath.row] ;
    
    info.tid = name.tid ;
    
    info.url = [NSString stringWithFormat:Info_API,name.pid,name.tid];

    info.title = name.classname ;
    
    [self presentViewController:info animated:YES completion:nil];
    
    
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
