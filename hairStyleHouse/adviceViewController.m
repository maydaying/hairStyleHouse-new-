//
//  adviceViewController.m
//  hairStyleHouse
//
//  Created by jeason on 14-1-20.
//  Copyright (c) 2014年 jeason. All rights reserved.
//

#import "adviceViewController.h"
#import "AppDelegate.h"
#import "SBJson.h"

#import "MobClick.h"
@interface adviceViewController ()

@end

@implementation adviceViewController
@synthesize _hidden;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UILabel * Lab= [[UILabel alloc] initWithFrame:CGRectMake(160, 7, 100, 30)];
    Lab.text = @"反馈意见";
    Lab.textAlignment = NSTextAlignmentCenter;
    Lab.font = [UIFont systemFontOfSize:16];
    Lab.textColor = [UIColor blackColor];
    self.navigationItem.titleView =Lab;
    [self refreashNav];
    _adviceText.layer.cornerRadius = 5;//设置那个圆角的有多圆
    _adviceText.layer.borderWidth =1;//设置边框的宽度，当然可以不要
    _adviceText.layer.borderColor = [[UIColor colorWithRed:212.0/256.0 green:212.0/256.0 blue:212.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    _adviceText.layer.masksToBounds = YES;//设为NO去试试
    
    _adviceButton.layer.cornerRadius = 5;//设置那个圆角的有多圆
    _adviceButton.layer.borderWidth =1;//设置边框的宽度，当然可以不要
    _adviceButton.layer.borderColor = [[UIColor colorWithRed:212.0/256.0 green:212.0/256.0 blue:212.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    _adviceButton.layer.masksToBounds = YES;//设为NO去试试
    // Do any additional setup after loading the view from its nib.
}



#pragma mark - View lifecycle

-(void) viewDidAppear:(BOOL)animated
{
    NSString* cName = [NSString stringWithFormat:@"反馈意见"];
    [MobClick beginLogPageView:cName];
    
}

-(void) viewDidDisappear:(BOOL)animated
{
    NSString* cName = [NSString stringWithFormat:@"反馈意见"];
    [MobClick endLogPageView:cName];
}

-(void)refreashNav
{
    UIButton * leftButton=[[UIButton alloc] init];
    leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton.layer setMasksToBounds:YES];
    [leftButton.layer setCornerRadius:3.0];
    [leftButton.layer setBorderWidth:1.0];
    [leftButton.layer setBorderColor: CGColorCreate(CGColorSpaceCreateDeviceRGB(),(CGFloat[]){ 0, 0, 0, 0 })];//边框颜色
    [leftButton setImage:[UIImage imageNamed:@"返回.png"]  forState:UIControlStateNormal];
    leftButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [leftButton setBackgroundColor:[UIColor clearColor]];
    [leftButton setTitleColor:[UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [leftButton addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
    leftButton.frame = CGRectMake(0,28, 24, 26);
    UIBarButtonItem *leftButtonItem=[[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem=leftButtonItem;
    
    
}
-(void)leftButtonClick
{
    if ([_hidden isEqualToString:@"yes"])
    {
        self.navigationController.navigationBar.hidden=YES;
        
    }
    else
    {
        self.navigationController.navigationBar.hidden=NO;
        
    }
    
    [self.navigationController popViewControllerAnimated:NO];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)adviceButtonClick:(id)sender
{
    if ([_adviceText.text isEqualToString:@""])
    {
        UIAlertView * alert =[[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入反馈意见" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    ASIFormDataRequest* request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:@"http://wap.faxingw.cn/index.php?g=wap&m=members&a=feedback"]];
    request.delegate=self;
//    request.tag=3;
    [request setPostValue:appDele.uid forKey:@"uid"];
        [request setPostValue:appDele.secret forKey:@"secret"];
    [request setPostValue:_adviceText.text forKey:@"content"];
    
    [request startAsynchronous];
    }

}
-(void)requestFinished:(ASIHTTPRequest *)request
{
    
    NSLog(@"%@",request.responseString);
    NSData*jsondata = [request responseData];
    NSString*jsonString = [[NSString alloc]initWithBytes:[jsondata bytes]length:[jsondata length]encoding:NSUTF8StringEncoding];
            jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
            jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
            jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    SBJsonParser* jsonP=[[SBJsonParser alloc] init];
    NSDictionary* dic=[jsonP objectWithString:jsonString];
    NSLog(@"反馈意见dic:%@",dic);
    if ([[dic objectForKey:@"code"] isEqualToString:@"101"]) {
        UIAlertView * alert =[[UIAlertView alloc] initWithTitle:@"提示" message:@"反馈意见提交成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        [self leftButtonClick];
    }
    else
    {
        UIAlertView * alert =[[UIAlertView alloc] initWithTitle:@"提示" message:@"反馈意见提交失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }
    //    AppDelegate *appDel = (AppDelegate*)[UIApplication sharedApplication].delegate;//调用appdel
}

-(void)requestFailed:(ASIHTTPRequest *)request
{
    UIAlertView * alert =[[UIAlertView alloc] initWithTitle:@"提示" message:@"请求超时" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
}
@end
