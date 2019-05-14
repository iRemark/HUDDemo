//
//  MBProgressHUD+WBHUDExtension.h
//  WBMBProgressHUDManager
//
//  Created by 文波 on 2018/7/22.
//  Copyright © 2018年 WMB. All rights reserved.
//


#import <MBProgressHUD/MBProgressHUD.h>

typedef NS_ENUM(NSInteger, WBHUDPositionStyle) {
    WBHUDPositionTopStyle,      /** < 文字顶部 > */
    WBHUDPositionCenterStyle,   /** < 文字中间 > */
    WBHUDPositionBottomStyle    /** < 文字底部 > */
};

typedef NS_ENUM(NSInteger, WBHUDContentStyle) {
    WBHUDContentDefaultStyle,   /** < 默认白底黑字 > */
    WBHUDContentBlackStyle,     /** < 黑底白字 > */
    WBHUDContentCustomStyle     /** < 自定义样式 > */
};

typedef NS_ENUM(NSInteger, WBHUDProgressStyle) {
    WBProgressHUDModeDeterminateStyle,              /*  < A round, pie-chart like, progress view. > */
    WBProgressHUDModeDeterminateHorizontalBarStyle, /*  < Horizontal progress bar > */
    WBProgressHUDModeAnnularDeterminateStyle        /*  < Ring-shaped progress view. > */
};

typedef void(^WBHUDConfigBlock)(MBProgressHUD *hud);
typedef void(^WBHUDCancelBlock)(MBProgressHUD *hud);

/**  < 最小显示时间 >  */
UIKIT_EXTERN NSTimeInterval const kMinShowTime;
/**  < 显示几秒后消失 >  */
UIKIT_EXTERN NSTimeInterval const KHideAfterDelayTime;
/**  < 菊花最少显示时间 >  */
UIKIT_EXTERN NSTimeInterval const kActivityMinDismissTime;

/** < 文字内容颜色 > */
#define kWBHUDCustomContentColor [UIColor colorWithWhite:1.f alpha:0.7f]
/** < 方框颜色 > */
#define kWBHUDCustomBezelColor [UIColor colorWithWhite:1.f alpha:0.7f]
/** < 自定义蒙版颜色 > */
#define kWBHUDCustomMaskBackgroundColor [[UIColor blackColor] colorWithAlphaComponent:0.5f];



@interface MBProgressHUD ()

// MARK:Property
/** < 内容文字颜色 默认：WBHUDContentBlackStyle > */
@property (nonatomic, assign, readonly) MBProgressHUD *(^hudContentStyle)(WBHUDContentStyle hudContentStyle);
    
/** < 蒙版颜色 > */
@property (nonatomic, strong, readonly) MBProgressHUD *(^hudMaskColor)(UIColor *hudMaskColor);
    
/** < 内容颜色 > */
@property (nonatomic, strong, readonly) MBProgressHUD *(^hudContentColor)(UIColor *hudContentColor);
    
/** < 容器颜色 > */
@property (nonatomic, strong, readonly) MBProgressHUD *(^hudBezelColor)(UIColor *hudBezelColor);
    
/** < 标题 > */
@property (nonatomic, copy, readonly) MBProgressHUD *(^title)(NSString *title);
    
/** < 详情标题 > */
@property (nonatomic, copy, readonly) MBProgressHUD *(^detailTitle)(NSString *detailTitle);
    
    
/** < 标题颜色 > */
@property (nonatomic, strong, readonly) MBProgressHUD *(^titleColor)(UIColor *titleColor);
    
    
/** < 文字显示位置 默认：WBHUDPositionCenterStyle > */
@property (nonatomic, assign, readonly) MBProgressHUD *(^hudPositon)(WBHUDPositionStyle
    hudPositon);
    
    
/*  < 自定义图片名 > */
@property (nonatomic, copy, readonly) MBProgressHUD *(^iconName)(NSString *iconName);
    
    
/*  < 取消按钮回调 > */
@property (nonatomic, copy, readonly) WBHUDCancelBlock cancelBlock;

@end







