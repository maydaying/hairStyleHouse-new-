//
//  beaspeakDresserViewController.h
//  hairStyleHouse
//
//  Created by jeason on 13-12-3.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "dresserInforViewController.h"
#import "userInforViewController.h"
#import "sendEvaluateViewController.h"
@interface beaspeakDresserViewController : UIViewController
{
    NSString * orderId;
    NSDictionary * orderInfor;
    NSMutableArray * dresserArray;
    
    dresserInforViewController * dreserView;
    userInforViewController * userView;

    UIButton * sureButton;
    UIButton * cancelButton;
    
    UIButton * sureButton1;
    sendEvaluateViewController * sendEvalute;
//    UIButton * cancelButton1;
}
@property (strong, nonatomic)   NSString * dresserOrCommen;

@property (strong, nonatomic)   NSString * orderId;
@property (strong, nonatomic) IBOutlet UIImageView *headImage;
@property (strong, nonatomic) IBOutlet UIButton *headButton;
@property (strong, nonatomic) IBOutlet UILabel *nameLable;
@property (strong, nonatomic) IBOutlet UILabel *storeLable;
@property (strong, nonatomic) IBOutlet UILabel *mobileLable;
@property (strong, nonatomic) IBOutlet UILabel *addressLable;
@property (strong, nonatomic) IBOutlet UILabel *brespeakLable;
@property (strong, nonatomic) IBOutlet UILabel *typeLable;
@property (strong, nonatomic) IBOutlet UILabel *priceLable;
@property (strong, nonatomic) IBOutlet UILabel *showPicLable;
@property (strong, nonatomic) IBOutlet UILabel *statusLable;

@property (strong, nonatomic) IBOutlet UILabel *firstLable;
@property (strong, nonatomic) IBOutlet UIButton *lookButton;
- (IBAction)lookButtonClick:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *rejectButton;
- (IBAction)rejectButtonClick:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *refuButton;
@property (strong, nonatomic) IBOutlet UIButton *refuButtonClick;
- (IBAction)refuButtonClick:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *secondLable;
@property (strong, nonatomic) IBOutlet UILabel *thirdLable;

@property (strong, nonatomic) IBOutlet UILabel *forthLable;

@property (strong, nonatomic) IBOutlet UILabel *fifthLable;

@property (strong, nonatomic) IBOutlet UIImageView *firstPicImage;



@property (strong, nonatomic) IBOutlet UIView *secondView;

@property (strong, nonatomic) IBOutlet UILabel *otherNameLable;

@property (strong, nonatomic) IBOutlet UILabel *otherMobileLable;
@property (strong, nonatomic) IBOutlet UIView *introView;

@property (strong, nonatomic) IBOutlet UILabel *otherTimeLable;

@property (strong, nonatomic) IBOutlet UILabel *otherTypeLable;

@property (strong, nonatomic) IBOutlet UILabel *otherMoneyLable;

@property (strong, nonatomic) IBOutlet UILabel *afirstLable;

@property (strong, nonatomic) IBOutlet UILabel *asecondLable;
@property (strong, nonatomic) IBOutlet UILabel *athirdLable;

@property (strong, nonatomic) IBOutlet UILabel *aforthLable;

@property (strong, nonatomic) IBOutlet UILabel *afifthLable;

@property (strong, nonatomic) IBOutlet UIImageView *picImage;

- (IBAction)headButtonClick:(id)sender;





@end
