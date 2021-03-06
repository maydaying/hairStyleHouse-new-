//
//  talkViewController.h
//  hairStyleHouse
//
//  Created by jeason on 13-11-27.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "talkCell.h"
#define MAX_IMAGEDATA_LEN 2000000.0
@interface talkViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    NSString * uid;
    
    UITableView *myTableView;
    NSMutableArray * dresserArray;
    NSMutableArray * oldArray;
    NSDictionary * headImageDiction;
     NSMutableArray * array;
    
    UIView * lastView;
    UITextView * contentView;
    BOOL ifchangeHeadImage;
    UIImageView * sendImage;
    NSString * imageString;
    UIButton * imageButton;
    UIButton * sendButton;
    
    NSTimer* timer;
    
//    NSString * sorket;
    UIActivityIndicatorView * _activityIndicatorView ;
    
}
@property(strong,nonatomic)    NSString * uid;
@property(strong,nonatomic)    NSString * talkOrQuestion;
@property(strong,nonatomic)    NSString * questionId;
@property(strong,nonatomic)    NSString * sameCityQuestion;
@property(strong,nonatomic)    NSString * _hidden;
@end
