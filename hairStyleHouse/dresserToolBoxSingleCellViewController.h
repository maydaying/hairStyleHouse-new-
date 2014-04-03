//
//  dresserToolBoxSingleCellViewController.h
//  hairStyleHouse
//
//  Created by jeason on 13-12-31.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "wayInforViewController.h"
#import "inviteViewController.h"
#import "hotTalkViewController.h"

@class toolBoxViewController;
@interface dresserToolBoxSingleCellViewController : UIViewController

{
    inviteViewController * inviteView;
    hotTalkViewController * hotView;
    wayInforViewController * wayView;
    

//    wayInforViewController * wayView;
}
@property (nonatomic,strong)toolBoxViewController *fatherController;
@property (strong, nonatomic) IBOutlet UIView *invitedView;

- (IBAction)invitedButtonClick:(id)sender;


@property (strong, nonatomic) IBOutlet UIView *talkPointView;

- (IBAction)talkPointButtonClick:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *wayNewsView;

- (IBAction)wayNewsButtonClick:(id)sender;

@property (strong, nonatomic) IBOutlet UIView *shalongView;

- (IBAction)shalongButtonClick:(id)sender;

- (IBAction)fameButtonClick:(id)sender;

- (IBAction)saleButtonClick:(id)sender;



@end