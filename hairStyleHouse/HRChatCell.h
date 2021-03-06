//
//  HRChatCell.h
//  TableViewChatDemo
//
//  Created by Rannie on 13-9-9.
//  Copyright (c) 2013年 Rannie. All rights reserved.
//

#import <UIKit/UIKit.h>

#define RChatFontSize 14.0f
#define RCellHeight 70

@class Message;
@interface HRChatCell : UITableViewCell
{
    UILabel * contentLable;
    UIImageView * picImage;
}
@property (weak, nonatomic) IBOutlet UIImageView *headerView;
@property (weak, nonatomic) IBOutlet UIButton *msgButton;
- (void)bindMessage:(NSDictionary *)_dic and: (NSDictionary *)lastDic;
@end
