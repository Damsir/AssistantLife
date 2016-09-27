//
//  issueView.h
//  生活小助手
//
//  Created by qianfeng on 15/12/10.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol issueView <NSObject>
-(void)fresh;
@end

@interface issueView : UIView

@property (nonatomic,strong) UILabel *label;

@property (nonatomic,assign) BOOL isOpen;

@property (nonatomic,strong) UIImageView *imageview;

@property (nonatomic,copy) void (^openGroup)();

@property (nonatomic,retain)  id <issueView> delegate;

@end
