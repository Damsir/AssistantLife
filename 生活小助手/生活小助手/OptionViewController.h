//
//  OptionViewController.h
//  生活小助手
//
//  Created by qianfeng on 15/11/23.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "ViewController.h"
#import "MJModelName.h"
#import "AppDelegate.h"



@interface OptionViewController : UIViewController < UITableViewDataSource , UITableViewDelegate >
@property (nonatomic,copy)  NSMutableString *str;

@property (nonatomic,strong) UITableView *table;

@property (nonatomic,strong) NSArray *ary ;

-(void)changDictionAry:(NSDictionary *)dic ;



@end
