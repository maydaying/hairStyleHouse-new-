//
//  dresserCell.h
//  hairStyleHouse
//
//  Created by jeason on 13-12-3.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import <UIKit/UIKit.h>
@class dresserViewController;

@interface dresserCell : UITableViewCell<UIScrollViewDelegate>
{
    
    UIImageView * headImage;
    UILabel * nameLable;
    UILabel * assessLable;
    UILabel * assessNumLable;

    UILabel * cityLable;
    UILabel *timeLable;
    UILabel *priceLable;
    UILabel *oldPriceLable;
    UILabel *distanceLable;

     UILabel *addressLable;
    
    UIButton * cellButton;
    UIButton * fouceButton;
    UIButton * fouceButton1;

    
    UIScrollView* workScroll;
    
    dresserViewController * fatherController;
}
@property(nonatomic,strong) dresserViewController * fatherController;
-(void)setCell:(NSMutableArray *)arr andIndex:(NSInteger)index andSign:(NSString * )_sign;

@end
