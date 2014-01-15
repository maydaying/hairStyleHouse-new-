//
//  beaspeakViewController.m
//  hairStyleHouse
//
//  Created by jeason on 13-11-27.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import "beaspeakViewController.h"
#import "AppDelegate.h"
#import "ASIFormDataRequest.h"
#import "SBJson.h"
#import "UIImageView+WebCache.h"
@interface beaspeakViewController ()

@end

@implementation beaspeakViewController
@synthesize dresserOrCommen;
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
    [self refreashNavLab];
    [self refreashNav];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    if ([dresserOrCommen isEqualToString:@"dresser"]) {
        myTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
    }
    else
    {
    
    topImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height+25, 320, 40)];
    topImage.backgroundColor = [UIColor whiteColor];
    topImage.layer.cornerRadius = 5;//设置那个圆角的有多圆
    topImage.layer.borderWidth =1;//设置边框的宽度，当然可以不要
    topImage.layer.borderColor = [[UIColor colorWithRed:154.0/256.0 green:154.0/256.0 blue:154.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    topImage.layer.masksToBounds = YES;//设为NO去试试
    //    [topImage setImage:[UIImage imageNamed:@"最新发型.png"]];
    
    oneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    oneButton.frame = CGRectMake(0, self.navigationController.navigationBar.frame.size.height+25, 320/2, 40);
    oneButton.backgroundColor = [UIColor clearColor];
    [oneButton setTitleColor:[UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    
    [oneButton addTarget:self action:@selector(oneButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    twoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    twoButton.frame = CGRectMake(320/2,self.navigationController.navigationBar.frame.size.height+25, 320/2, 40);
    twoButton.backgroundColor = [UIColor clearColor];
    
    [twoButton setTitleColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    [twoButton addTarget:self action:@selector(twoButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    [oneButton setTitle:@"当前预约" forState:UIControlStateNormal];
    [twoButton setTitle:@"历史预约" forState:UIControlStateNormal];
    
    
    
    
    
    [self.view addSubview:topImage];
    [self.view addSubview:oneButton];
    [self.view addSubview:twoButton];

    
     myTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 110, self.view.bounds.size.width, self.view.bounds.size.height-self.navigationController.navigationBar.frame.size.height-self.tabBarController.tabBar.frame.size.height-70) style:UITableViewStylePlain];
    }
    dresserArray =[[NSMutableArray alloc] init];
    dresserArray1 =[[NSMutableArray alloc] init];

    nowOrhistory = YES;
    
    //    myTableView.allowsSelection=NO;
    [myTableView setSeparatorInset:UIEdgeInsetsZero];
    myTableView.dataSource=self;
    myTableView.delegate=self;
    myTableView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:myTableView];
    
    [self getData];
}

-(void)oneButtonClick
{
    [oneButton setTitleColor:[UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    [twoButton setTitleColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    nowOrhistory = YES;
    [myTableView reloadData];
   
    
}
-(void)twoButtonClick
{
    [oneButton setTitleColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    [twoButton setTitleColor:[UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    nowOrhistory = NO;
    [myTableView reloadData];

    
}

-(void)leftButtonClick
{
    self.navigationController.navigationBar.hidden=YES;
    [self.navigationController popViewControllerAnimated:NO];
    
}
-(void)refreashNav
{
    UIButton * leftButton=[[UIButton alloc] init];
    leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton.layer setMasksToBounds:YES];
    [leftButton.layer setCornerRadius:3.0];
    [leftButton.layer setBorderWidth:1.0];
    [leftButton.layer setBorderColor: CGColorCreate(CGColorSpaceCreateDeviceRGB(),(CGFloat[]){ 0, 0, 0, 0 })];//边框颜色
    [leftButton setTitle:@"返回" forState:UIControlStateNormal];
    leftButton.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [leftButton setBackgroundColor:[UIColor colorWithRed:214.0/256.0 green:78.0/256.0 blue:78.0/256.0 alpha:1.0]];
    [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [leftButton addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
    leftButton.frame = CGRectMake(12,20, 60, 25);
    UIBarButtonItem *leftButtonItem=[[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem=leftButtonItem;
}

-(void)refreashNavLab
{
    UILabel * Lab= [[UILabel alloc] initWithFrame:CGRectMake(160, 10, 100, 30)];
    Lab.text = @"预约列表";
    Lab.textAlignment = NSTextAlignmentCenter;
    Lab.font = [UIFont systemFontOfSize:16];
    Lab.textColor = [UIColor blackColor];
    self.navigationItem.titleView =Lab;
}


-(void)getData
{
        AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    ASIFormDataRequest* request;
    if ([dresserOrCommen isEqualToString:@"dresser"]) {
        request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:@"http://wap.faxingw.cn/index.php?m=Reserve&a=reserve_run"]];
        request.delegate=self;
        request.tag=1;
        [request setPostValue:appDele.uid forKey:@"uid"];
        [request startAsynchronous];
    }
    else
    {
    
        request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:@"http://wap.faxingw.cn/index.php?m=Reserve&a=current"]];
        request.delegate=self;
        request.tag=11;
        [request setPostValue:appDele.uid forKey:@"uid"];
        [request startAsynchronous];

        
         ASIFormDataRequest* request1=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:@"http://wap.faxingw.cn/index.php?m=Reserve&a=history"]];
        request1.delegate=self;
        request1.tag=1;
        [request1 setPostValue:appDele.uid forKey:@"uid"];
        [request1 startAsynchronous];
    }
    
}


-(void)requestFinished:(ASIHTTPRequest *)request
{
//    if (dresserArray!=nil) {
//        [dresserArray removeAllObjects];
//    }
    if (request.tag==1)
    {
        NSLog(@"%@",request.responseString);
        NSData*jsondata = [request responseData];
        NSString*jsonString = [[NSString alloc]initWithBytes:[jsondata bytes]length:[jsondata length]encoding:NSUTF8StringEncoding];
        SBJsonParser* jsonP=[[SBJsonParser alloc] init];
        NSDictionary* dic=[jsonP objectWithString:jsonString];
        NSLog(@"预约列表dic:%@",dic);
        
        if ([[dic objectForKey:@"order_list"] isKindOfClass:[NSString class]])
        {
            
        }
        else if ([[dic objectForKey:@"order_list"] isKindOfClass:[NSArray class]])
        {
            dresserArray = [dic objectForKey:@"order_list"];
            
        }
        [self freashView];
    }
    
    if (request.tag==11)
    {
        NSLog(@"%@",request.responseString);
        NSData*jsondata = [request responseData];
        NSString*jsonString = [[NSString alloc]initWithBytes:[jsondata bytes]length:[jsondata length]encoding:NSUTF8StringEncoding];
        SBJsonParser* jsonP=[[SBJsonParser alloc] init];
        NSDictionary* dic=[jsonP objectWithString:jsonString];
        NSLog(@"预约列表dic:%@",dic);
        
        if ([[dic objectForKey:@"order_list"] isKindOfClass:[NSString class]])
        {
            
        }
        else if ([[dic objectForKey:@"order_list"] isKindOfClass:[NSArray class]])
        {
            dresserArray1 = [dic objectForKey:@"order_list"];
            
        }
        [self freashView];
    }
}

-(void)requestFailed:(ASIHTTPRequest *)request
{
    UIAlertView * alert =[[UIAlertView alloc] initWithTitle:@"提示" message:@"请求超时" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
}

-(void)freashView
{
    [myTableView reloadData];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([dresserOrCommen isEqualToString:@"dresser"]) {
        return dresserArray.count;
    }
    else
    {
        if (nowOrhistory==YES)//当前预约
        {
            return 1;
        }
        else
            
        {
        return dresserArray.count;
        }
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return   100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID=@"cell";
    beaspeakCell *cell=(beaspeakCell*)[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil) {
        cell=[[beaspeakCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    NSInteger row =[indexPath row];
    if ([dresserOrCommen isEqualToString:@"dresser"]) {
        [cell setCell:[dresserArray objectAtIndex:row] andIndex:row];
    }
    else
    {
        if (nowOrhistory==YES)
        {
//            [cell setCell:[dresserArray1 objectAtIndex:row] andIndex:row];
        }
        else
            
        {
            [cell setCell:[dresserArray objectAtIndex:row] andIndex:row];
        }
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([dresserOrCommen isEqualToString:@"dresser"]) {
        deaspeakDresser =nil;
        deaspeakDresser =[[beaspeakDresserViewController alloc] init];
        deaspeakDresser.orderId = [[dresserArray objectAtIndex:[indexPath row] ] objectForKey:@"id"];
        NSLog(@"orderId:%@",deaspeakDresser.orderId);
        
        [self.navigationController pushViewController:deaspeakDresser animated:NO];
    }
    else
    {
        if (nowOrhistory==YES)//当前预约
        {
            
        }
        else
            
        {
            deaspeakDresser =nil;
            deaspeakDresser =[[beaspeakDresserViewController alloc] init];
            deaspeakDresser.orderId = [[dresserArray objectAtIndex:[indexPath row] ] objectForKey:@"id"];
            [self.navigationController pushViewController:deaspeakDresser animated:NO];
        }
    }
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
