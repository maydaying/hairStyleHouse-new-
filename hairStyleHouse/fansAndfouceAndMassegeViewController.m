//
//  fansAndFouceAndmassegeViewController.m
//  hairStyleHouse
//
//  Created by jeason on 13-11-28.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import "fansAndFouceAndmassegeViewController.h"
#import "AppDelegate.h"
#import "ASIFormDataRequest.h"
#import "SBJson.h"
#import "UIImageView+WebCache.h"

#import "MobClick.h"
#import "AllAroundPullView.h"

@interface fansAndFouceAndmassegeViewController ()

@end

@implementation fansAndFouceAndmassegeViewController
@synthesize fansOrFouce;
@synthesize fansOrFouceOrMessage;
@synthesize tableViewM;
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
    dresserArray =[[NSMutableArray alloc] init];
    
    dresserArray1 =[[NSMutableArray alloc] init];
    if ([fansOrFouceOrMessage isEqualToString:@"massege"])
    {
        
        page =[[NSString alloc] init];
        page=@"1";
        pageCount=[[NSString alloc] init];
         tableViewM=[[YFJLeftSwipeDeleteTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
        [tableViewM setSeparatorInset:UIEdgeInsetsZero];
        tableViewM.dataSource=self;
        tableViewM.delegate=self;
//        [self.tableViewM registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        tableViewM.backgroundColor=[UIColor whiteColor];
        [self.view addSubview:tableViewM];
        
        bottomRefreshView = [[AllAroundPullView alloc] initWithScrollView:tableViewM position:AllAroundPullViewPositionBottom action:^(AllAroundPullView *view){
            NSLog(@"loadMore");
            [self pullLoadMore];
            tableViewM.frame=CGRectMake(0, 60, self.view.bounds.size.width, self.view.bounds.size.height-self.navigationController.navigationBar.frame.size.height-self.tabBarController.tabBar.frame.size.height) ;
        }];
        bottomRefreshView.hidden=NO;
        [tableViewM addSubview:bottomRefreshView];
    }
    else
    {
        topImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height+25, 320, 40)];
        topImage.backgroundColor = [UIColor whiteColor];
        topImage.layer.cornerRadius = 5;//设置那个圆角的有多圆
        topImage.layer.borderWidth =1;//设置边框的宽度，当然可以不要
        topImage.layer.borderColor = [[UIColor colorWithRed:212.0/256.0 green:212.0/256.0 blue:212.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
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
        
       
            [oneButton setTitle:@"发型师" forState:UIControlStateNormal];
            [twoButton setTitle:@"个人用户" forState:UIControlStateNormal];
      
        
        
        
        
        [self.view addSubview:topImage];
        [self.view addSubview:oneButton];
        [self.view addSubview:twoButton];
        
        sign = [[NSString alloc] init];
        
        myTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 110, self.view.bounds.size.width, self.view.bounds.size.height-self.navigationController.navigationBar.frame.size.height-self.tabBarController.tabBar.frame.size.height-70) style:UITableViewStylePlain];
//        [myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        dresserOrperson =YES;
        
        //    myTableView.allowsSelection=NO;
        [myTableView setSeparatorInset:UIEdgeInsetsZero];
        myTableView.dataSource=self;
        myTableView.delegate=self;
        myTableView.backgroundColor=[UIColor whiteColor];
        [self.view addSubview:myTableView];
    }

   

   
    
    [self getData];
    
    _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    //创建一个UIActivityIndicatorView对象：_activityIndicatorView，并初始化风格。
    _activityIndicatorView.frame = CGRectMake(160, self.view.center.y, 0, 0);
    //设置对象的位置，大小是固定不变的。WhiteLarge为37 * 37，White为20 * 20
    _activityIndicatorView.color = [UIColor grayColor];
    //设置活动指示器的颜色
    _activityIndicatorView.hidesWhenStopped = YES;
    //hidesWhenStopped默认为YES，会隐藏活动指示器。要改为NO
    [self.view addSubview:_activityIndicatorView];
    //将对象加入到view
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


-(void)pullLoadMore
{
    
    if ([fansOrFouceOrMessage isEqualToString:@"massege"])
    {
        NSInteger _pageCount= [pageCount integerValue];
        
        NSInteger _page = [page integerValue];
        
        NSLog(@"page:%@",page);
        NSLog(@"pageCount:%@",pageCount);
        
        if (_page<_pageCount) {
            _page++;
            page = [NSString stringWithFormat:@"%d",_page];
            NSLog(@"page:%@",page);
            [self getData];
        }
        else
        {
            [bottomRefreshView performSelector:@selector(finishedLoading)];
        }
    }
    else
    {
      
    }
    
}
#pragma mark - View lifecycle

-(void) viewDidAppear:(BOOL)animated
{
    NSString* cName;
    if ([fansOrFouceOrMessage isEqualToString:@"massege"])
    {
        cName = [NSString stringWithFormat:@"消息记录"];
    }
    else
    {
        if ([fansOrFouce isEqualToString:@"fans"])
        {
            cName = [NSString stringWithFormat:@"我的粉丝"];

        }
        else
        {
            cName = [NSString stringWithFormat:@"我的关注"];
        }
        
    }

        [MobClick beginLogPageView:cName];
    
}

-(void) viewDidDisappear:(BOOL)animated
{
    NSString* cName;
    if ([fansOrFouceOrMessage isEqualToString:@"massege"])
    {
        cName = [NSString stringWithFormat:@"消息记录"];
    }
    else
    {
        if ([fansOrFouce isEqualToString:@"fans"])
        {
            cName = [NSString stringWithFormat:@"我的粉丝"];
            
        }
        else
        {
            cName = [NSString stringWithFormat:@"我的关注"];
        }
        
    }
    [MobClick endLogPageView:cName];
}

-(void)oneButtonClick
{
    //    [topImage setImage:[UIImage imageNamed:@"最新发型.png"]];
    [oneButton setTitleColor:[UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    [twoButton setTitleColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    
    dresserOrperson=YES;
    [myTableView reloadData];
    
}
-(void)twoButtonClick
{
    [oneButton setTitleColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    [twoButton setTitleColor:[UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    //    [topImage setImage:[UIImage imageNamed:@"同城发型.png"]];
    //    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;

    dresserOrperson=NO;

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

-(void)refreashNavLab
{
    UILabel * Lab= [[UILabel alloc] initWithFrame:CGRectMake(160, 7, 100, 30)];
    if ([fansOrFouceOrMessage isEqualToString:@"massege"])
    {
        Lab.text = @"消息记录";
    }
    else
    {
        if ([fansOrFouce isEqualToString:@"fans"])
        {
            Lab.text = @"我的粉丝";
        }
        else
        {
            Lab.text = @"我的关注";
        }
        
    }
    
    Lab.textAlignment = NSTextAlignmentCenter;
    Lab.font = [UIFont systemFontOfSize:16];
    Lab.textColor = [UIColor blackColor];
    self.navigationItem.titleView =Lab;
}


-(void)getData
{
    if ([fansOrFouceOrMessage isEqualToString:@"massege"])
    {
        AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
        ASIFormDataRequest* request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wap.faxingw.cn/wapapp.php?g=wap&m=message&a=messageList&page=%@",page]]];
        request.delegate=self;
        request.tag=2;
        [request setPostValue:appDele.uid forKey:@"uid"];
        [request setPostValue:appDele.secret forKey:@"secret"];
        [request startAsynchronous];
    }
    else
    {
        NSURL * urlString;
        if ([fansOrFouce isEqualToString:@"fans"])
        {
            urlString= [NSURL URLWithString:@"http://wap.faxingw.cn/wapapp.php?g=wap&m=user&a=fanlist"];

        }
        else
        {
           urlString= [NSURL URLWithString:@"http://wap.faxingw.cn/wapapp.php?g=wap&m=user&a=watchlist"];
        }
        AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
        ASIFormDataRequest* request=[[ASIFormDataRequest alloc] initWithURL:urlString];
        request.delegate=self;
        request.tag=1;
        [request setPostValue:appDele.uid forKey:@"uid"];
        [request setPostValue:appDele.secret forKey:@"secret"];
        [request setPostValue:@"2" forKey:@"type"];
        
        [request startAsynchronous];
        
        
        NSURL * urlString1;
        if ([fansOrFouce isEqualToString:@"fans"])
        {
            urlString1= [NSURL URLWithString:@"http://wap.faxingw.cn/wapapp.php?g=wap&m=user&a=fanlist"];
            
        }
        else
        {
            urlString1= [NSURL URLWithString:@"http://wap.faxingw.cn/wapapp.php?g=wap&m=user&a=watchlist"];
        }
        ASIFormDataRequest* request1=[[ASIFormDataRequest alloc] initWithURL:urlString1];
        request1.delegate=self;
        request1.tag=11;
        [request1 setPostValue:appDele.uid forKey:@"uid"];
        [request1 setPostValue:appDele.secret forKey:@"secret"];
        [request1 setPostValue:@"1" forKey:@"type"];
        
        
        [request1 startAsynchronous];
        
    }

    
    
    [_activityIndicatorView startAnimating];
    
    
   
}
-(void)getData1
{

}

-(void)getData2
{
    
}
-(void)requestFinished:(ASIHTTPRequest *)request
{
//    if (dresserArray!=nil) {
//        [dresserArray removeAllObjects];
//    }
    if (request.tag==1) {
        NSLog(@"%@",request.responseString);
        NSData*jsondata = [request responseData];
        NSString*jsonString = [[NSString alloc]initWithBytes:[jsondata bytes]length:[jsondata length]encoding:NSUTF8StringEncoding];
            jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
            jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
            jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        SBJsonParser* jsonP=[[SBJsonParser alloc] init];
        NSDictionary* dic=[jsonP objectWithString:jsonString];
        NSLog(@"粉丝列表dic:%@",dic);
        
        if ([[dic objectForKey:@"user_info"] isKindOfClass:[NSString class]])
        {
            
        }
        else if ([[dic objectForKey:@"user_info"] isKindOfClass:[NSArray class]])
        {
            dresserArray = [dic objectForKey:@"user_info"];

        }
        [self freashView];
        
        [_activityIndicatorView stopAnimating];
        _activityIndicatorView.hidesWhenStopped = YES;
    }
     if (request.tag==11) {
        NSLog(@"%@",request.responseString);
        NSData*jsondata = [request responseData];
        NSString*jsonString = [[NSString alloc]initWithBytes:[jsondata bytes]length:[jsondata length]encoding:NSUTF8StringEncoding];
            jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
            jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
            jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        SBJsonParser* jsonP=[[SBJsonParser alloc] init];
        NSDictionary* dic=[jsonP objectWithString:jsonString];
        NSLog(@"粉丝列表dic:%@",dic);
        if ([[dic objectForKey:@"user_info"] isKindOfClass:[NSString class]])
        {
            
        }
        else if ([[dic objectForKey:@"user_info"] isKindOfClass:[NSArray class]])
        {
            dresserArray1 = [dic objectForKey:@"user_info"];
            
        }
        [self freashView];
         
         [_activityIndicatorView stopAnimating];
         _activityIndicatorView.hidesWhenStopped = YES;
    }
    
     if (request.tag==2) {
        NSLog(@"%@",request.responseString);
        NSData*jsondata = [request responseData];
        NSString*jsonString = [[NSString alloc]initWithBytes:[jsondata bytes]length:[jsondata length]encoding:NSUTF8StringEncoding];
            jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
            jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
            jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        SBJsonParser* jsonP=[[SBJsonParser alloc] init];
        NSDictionary* dic=[jsonP objectWithString:jsonString];
        NSLog(@"消息表dic:%@",dic);
         pageCount = [dic objectForKey:@"page_count"];
         NSMutableArray * mesArr;
        if ([[dic objectForKey:@"message_list"] isKindOfClass:[NSString class]])
        {
            
        }
        else if ([[dic objectForKey:@"message_list"] isKindOfClass:[NSArray class]])
        {
            mesArr = [dic objectForKey:@"message_list"];
            [dresserArray addObjectsFromArray:mesArr];
        }
        [self freashView];
         
         [_activityIndicatorView stopAnimating];
         _activityIndicatorView.hidesWhenStopped = YES;
    }
    if (request.tag==202) {
        NSLog(@"%@",request.responseString);
        NSData*jsondata = [request responseData];
        NSString*jsonString = [[NSString alloc]initWithBytes:[jsondata bytes]length:[jsondata length]encoding:NSUTF8StringEncoding];
        jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        SBJsonParser* jsonP=[[SBJsonParser alloc] init];
        NSDictionary* dic=[jsonP objectWithString:jsonString];
        NSLog(@"删除成功dic:%@",dic);
        
    }

}

-(void)requestFailed:(ASIHTTPRequest *)request
{
    UIAlertView * alert =[[UIAlertView alloc] initWithTitle:@"提示" message:@"请求超时" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
    [self freashView];
}
-(void)freashView
{
    [bottomRefreshView performSelector:@selector(finishedLoading)];
    if ([fansOrFouceOrMessage isEqualToString:@"massege"])
    {
    [tableViewM reloadData];
    }
    else
    {
    [myTableView reloadData];
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if ([fansOrFouceOrMessage isEqualToString:@"massege"])
    {
        return dresserArray.count;
        
    }
    else
    {
        if (dresserOrperson==YES)
       {
        //查看发型师
        return dresserArray.count;

      }
     else
      {
        //查看个人
        return dresserArray1.count;

      }
}
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return   80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *cellID=@"cell";
    fansAndfoceAndMassegeCell *cell=(fansAndfoceAndMassegeCell*)[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil) {
        cell=[[fansAndfoceAndMassegeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    NSInteger row =[indexPath row];
    if ([fansOrFouceOrMessage isEqualToString:@"massege"])
    {
        [cell setCell2:[dresserArray objectAtIndex:row] andIndex:row];
        
        
    }
    else
    {
        if (dresserOrperson==YES)
        {
            [cell setCell:[dresserArray objectAtIndex:row] andIndex:row];
        }
        else
        {
            [cell setCell:[dresserArray1 objectAtIndex:row] andIndex:row];
        }
    
    }
    
    
    return cell;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([fansOrFouceOrMessage isEqualToString:@"massege"]) {
        return YES;
    }
    else
    {
        return NO;
    }
    // Return NO if you do not want the specified item to be editable.
    
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        
        
        AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
        ASIFormDataRequest* request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:@"http://wap.faxingw.cn/wapapp.php?g=wap&m=message&a=messageDel"]];
        
        request.delegate=self;
        request.tag=202;
        [request setPostValue:appDele.uid forKey:@"uid"];
        [request setPostValue:[[dresserArray objectAtIndex:[indexPath row]] objectForKey:@"ftid"] forKey:@"ftid"];
        [request setPostValue:appDele.secret forKey:@"secret"];
        
        [request startAsynchronous];
        
        [dresserArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([fansOrFouceOrMessage isEqualToString:@"massege"]) {

        talkView=nil;
        talkView = [[talkViewController alloc] init];
        talkView.uid = [[dresserArray objectAtIndex:[indexPath row] ] objectForKey:@"ta_id"];
        [self.navigationController pushViewController:talkView animated:NO];
        
    }
    else
    {
        if (dresserOrperson==YES)
        {
            //查看发型师
            dreserView =nil;
            dreserView =[[dresserInforViewController alloc] init];
            dreserView.uid = [[dresserArray objectAtIndex:[indexPath row] ] objectForKey:@"uid"];
            dreserView._hidden=@"no";
            [self.navigationController pushViewController:dreserView animated:NO];
        }
        else
        {
            //查看个人
            
            userView =nil;
            userView =[[userInforViewController alloc] init];
            userView.uid = [[dresserArray1 objectAtIndex:[indexPath row] ] objectForKey:@"uid"];
            userView._hidden=@"no";
            [self.navigationController pushViewController:userView animated:NO];
        }
    
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
