//
//  MJPhotoBrowser.h
//
//  Created by mj on 13-3-4.
//  Copyright (c) 2013年 itcast. All rights reserved.

#import <UIKit/UIKit.h>
#import "loginViewController.h"
@protocol MJPhotoBrowserDelegate;
@interface MJPhotoBrowser : UIViewController <UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    loginViewController* loginView;
    NSString * first ;
    
    CGPoint  firstContentOffSet;
    NSString * sign;
    
    UIControl * subView;
    UIControl * alphaView;
    UITextField * severTime;
    UITextField * severPrice;
    UILabel * saleLable;
    UIButton * saleButton;
    UILabel * reallPriceLable;
    
    UIButton * sureButton;
    UIButton * cancelButton;
    UITableView * myTableView;
    NSMutableArray* saleArr;
}
// 代理
@property (nonatomic, weak) id<MJPhotoBrowserDelegate> delegate;
// 所有的图片对象
@property (nonatomic, strong) NSArray *photos;
// 当前展示的图片索引
@property (nonatomic, assign) NSUInteger currentPhotoIndex;

// 显示
- (void)show;
-(void)refreashNavLab:(NSInteger)currentIndex and:(NSInteger)allCount;
-(void)pushViewController:(id)Sen;
-(void)addAlphaView;
@end

@protocol MJPhotoBrowserDelegate <NSObject>
@optional
// 切换到某一页图片
- (void)photoBrowser:(MJPhotoBrowser *)photoBrowser didChangedToPageAtIndex:(NSUInteger)index;


@end