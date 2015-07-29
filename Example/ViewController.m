//
//  ViewController.m
//  Example
//
//  Created by 塔利班 on 15/5/22.
//  Copyright (c) 2015年 联创智融. All rights reserved.
//

#import "ViewController.h"
#import "ZCTradeView.h"
#import "UIAlertView+Quick.h"

@interface ViewController ()<ZCTradeViewDelegate,UIAlertViewDelegate>

@property (nonatomic,strong)ZCTradeView *zctView;
@property (nonatomic,copy)NSString *str;
@end

@implementation ViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    _str = @"111111";
}

- (IBAction)showTradeView:(id)sender
{
    [self text];
}

-(void)text
{
    __block ViewController *blockSelf = self;
    self.zctView = [ZCTradeView tradeView];
    
    [self.zctView showInView:self.view.window];
    self.zctView.delegate = self;
    self.zctView.finish = ^(NSString *passWord){
        
        NSLog(@"  passWord %@ ",passWord);
        
        [blockSelf.zctView hidenKeyboard];
        
        if ([passWord isEqualToString:blockSelf.str]) {
            NSLog(@"密码成功");
            
            return ;
        }else{
   
            UIAlertView *al = [[UIAlertView alloc]initWithTitle:@"支付密码错误" message:nil delegate:blockSelf cancelButtonTitle:@"重试" otherButtonTitles:@"忘记密码", nil];
            [al show];
            NSLog(@"密码错误");
        }
    };
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        
        [self text];
        
        NSLog(@" buttonIndex 重试");
    }else if (buttonIndex == 1)
    {
        [self.zctView hidenKeyboard];
        UIViewController *vc = [[UIViewController alloc]init];
        vc.view.backgroundColor = [UIColor redColor];
        [self.navigationController pushViewController:vc animated:YES];
        NSLog(@" buttonIndex 忘了密码");
    }
}

// 取消
-(void)tradeView:(ZCTradeView *)tradeInputView cancleBtnClick:(UIButton *)cancleBtnClick
{
    NSLog(@"取消");
}

@end
