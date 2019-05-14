//
//  MBProgressHUD+WB.m
//  MBProgressHUD+WB1
//
//  Created by WMB on 2017/6/11.
//  Copyright © 2017年 文波. All rights reserved.
//

#import "MBProgressHUD+LCManager.h"
#import "MBProgressHUD+LCExtension.h"
#import <objc/runtime.h>


NSTimeInterval const kMinShowTime = 1.f;
NSTimeInterval const KHideAfterDelayTime = 2.2f;
NSTimeInterval const kActivityMinDismissTime = 0.5f;

static char kWBHUDCancelKey;

@implementation MBProgressHUD (WBAddtional)

/** < 创建HUD > */
+ (MBProgressHUD *)lc_createHUD:(UIView *)view {
    if (view == nil) view = (UIView *)[UIApplication sharedApplication].delegate.window;
    MBProgressHUD *lastHud = [MBProgressHUD HUDForView:view];
    if (lastHud) {
        return lastHud;
    }
    return [MBProgressHUD showHUDAddedTo:view
                                animated:YES];
}

/** < 设置HUD > */
+ (MBProgressHUD *)lc_configHUDWithView:(UIView *)view
                                  title:(NSString *)title
                            autoDismiss:(BOOL)autoDismiss
                             completion:(MBProgressHUDCompletionBlock)completion {
    MBProgressHUD *hud = [self lc_createHUD:view];
    /** < 自动换行 > */
    hud.label.numberOfLines = 0;
    /** < 提示文字 > */
    hud.title(title);
    /** < 隐藏移除 > */
    hud.removeFromSuperViewOnHide = YES;
    /** <默认内容样式：黑底白字 > */
    hud.hudContentStyle(WBHUDContentBlackStyle);
    /** < 自动隐藏 > */
    if (autoDismiss) {
        [hud hideAnimated:YES
               afterDelay:KHideAfterDelayTime];
        
    }else {
        [hud hideAnimated:YES
               afterDelay:35];
    }
    hud.completionBlock = completion;
    return hud;
}

+ (MBProgressHUD *)lc_showActivity {
    return [self lc_showActivityMessage:nil
                                 toView:nil];
}

+ (MBProgressHUD *)lc_showActivity:(UIView *)view {
    return [self lc_showActivityMessage:nil
                                 toView:view];
}

+ (MBProgressHUD *)lc_showActivityMessage:(NSString *)message {
    return [self lc_showActivityMessage:message
                                 toView:nil];
}

+ (MBProgressHUD *)lc_showActivityMessage:(NSString *)message
                                   toView:(UIView *)view {
    MBProgressHUD *hud = [self lc_configHUDWithView:view
                                              title:message
                                        autoDismiss:NO
                                         completion:nil];
    hud.mode = MBProgressHUDModeIndeterminate;
    /** < 加载提示最小显示时间 > */
    hud.minShowTime = kActivityMinDismissTime;
    return hud;
}

+ (MBProgressHUD *)lc_showActivityMessage:(NSString *)message
                                   toView:(UIView *)view
                             contentColor:(UIColor *)contentColor
                                maskColor:(UIColor *)maskColor
                               bezelColor:(UIColor *)bezelColor {
    MBProgressHUD *hud = [self lc_configHUDWithView:view
                                              title:message
                                        autoDismiss:NO
                                         completion:nil];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.hudContentColor(contentColor);
    hud.hudMaskColor(maskColor);
    hud.hudBezelColor(bezelColor);
    /** < 加载提示最小显示时间 > */
    hud.minShowTime = kActivityMinDismissTime;
    return hud;
}

+ (MBProgressHUD *)lc_showActivityMessage:(NSString *)message
                                   toView:(UIView *)view
                               titleColor:(UIColor *)titleColor
                                maskColor:(UIColor *)maskColor
                               bezelColor:(UIColor *)bezelColor {
    MBProgressHUD *hud = [self lc_configHUDWithView:view
                                              title:message
                                        autoDismiss:NO
                                         completion:nil];
    hud.titleColor(titleColor);
    hud.hudMaskColor(maskColor);
    hud.hudBezelColor(bezelColor);
    /** < 加载提示最小显示时间 > */
    hud.minShowTime = kActivityMinDismissTime;
    return hud;
}

// MARK:Text
+ (void)lc_showMessage:(NSString *)message {
    [self lc_showMessage:message
                  toView:nil
              completion:nil];
}

+ (void)lc_showMessage:(NSString *)message
         detailMessage:(NSString *)detailMessage {
    [self lc_showMessage:message
             detailTitle:detailMessage
                  toView:nil
                position:WBHUDPositionCenterStyle
            contentStyle:WBHUDContentBlackStyle
              completion:nil];
}

+ (void)lc_showMessage:(NSString *)message
         detailMessage:(NSString *)detailMessage
                toView:(UIView *)view
              position:(WBHUDPositionStyle)position {
    [self lc_showMessage:message
             detailTitle:detailMessage
                  toView:view
                position:position
            contentStyle:WBHUDContentBlackStyle
              completion:nil];
}

+ (void)lc_showMessage:(NSString *)message
            completion:(MBProgressHUDCompletionBlock)completion {
    [self lc_showMessage:message
                  toView:nil
              completion:completion];
}

+ (void)lc_showMessage:(NSString *)message
                toView:(UIView *)view
            completion:(MBProgressHUDCompletionBlock)completion {
    [self lc_showMessage:message
             detailTitle:nil
                  toView:view
                position:WBHUDPositionCenterStyle
            contentStyle:WBHUDContentBlackStyle
              completion:completion];
}

+ (void)lc_showMessage:(NSString *)message
                toView:(UIView *)view
              position:(WBHUDPositionStyle)position
            completion:(MBProgressHUDCompletionBlock)completion {
    [self lc_showMessage:message
             detailTitle:nil
                  toView:view
                position:position
            contentStyle:WBHUDContentBlackStyle
              completion:completion];
}

+ (void)lc_showMessage:(NSString *)message
           detailTitle:(NSString *)detailTitle
                toView:(UIView *)view
              position:(WBHUDPositionStyle)position
          contentStyle:(WBHUDContentStyle)contentStyle
            completion:(MBProgressHUDCompletionBlock)completion {
    MBProgressHUD *hud = [self lc_configHUDWithView:view
                                              title:message
                                        autoDismiss:YES
                                         completion:completion];
    hud.userInteractionEnabled = NO;
    hud.mode = MBProgressHUDModeText;
    hud.detailTitle(detailTitle);
    hud.hudPositon(position);
    hud.hudContentStyle(contentStyle);
    hud.minShowTime = kMinShowTime;
}

// MARK:Image
+ (void)lc_showSuccess:(NSString *)success {
    [self lc_showSuccess:success
                  toView:nil
              completion:nil];
}
+ (void)lc_showSuccess:(NSString *)success
            completion:(MBProgressHUDCompletionBlock)completion {
    [self lc_showSuccess:success
                  toView:nil
              completion:completion];
}
+ (void)lc_showSuccess:(NSString *)success
                toView:(UIView *)view
            completion:(MBProgressHUDCompletionBlock)completion {
    [self lc_show:success
             icon:@"MBProgressHUD.bundle/success"
             view:view
       completion:completion];
}

+ (void)lc_showError:(NSString *)error {
    [self lc_showError:error
                toView:nil
            completion:nil];
}

+ (void)lc_showError:(NSString *)error
          completion:(MBProgressHUDCompletionBlock)completion {
    [self lc_showError:error
                toView:nil
            completion:completion];
}

+ (void)lc_showError:(NSString *)error
              toView:(UIView *)view
          completion:(MBProgressHUDCompletionBlock)completion {
    [self lc_show:error
             icon:@"MBProgressHUD.bundle/error"
             view:view
       completion:completion];
}

+ (void)lc_showInfo:(NSString *)info {
    [self lc_showInfo:info
               toView:nil
           completion:nil];
}

+ (void)lc_showInfo:(NSString *)info
         completion:(MBProgressHUDCompletionBlock)completion {
    [self lc_showInfo:info
               toView:nil
           completion:completion];
}

+ (void)lc_showInfo:(NSString *)info
             toView:(UIView *)view
         completion:(MBProgressHUDCompletionBlock)completion {
    [self lc_show:info
             icon:@"MBProgressHUD.bundle/MBHUD_Info"
             view:view
       completion:completion];
}

+ (void)lc_showWarning:(NSString *)warning {
    [self lc_showWarning:warning
                  toView:nil
              completion:nil];
}

+ (void)lc_showWarning:(NSString *)warning
            completion:(MBProgressHUDCompletionBlock)completion {
    [self lc_showWarning:warning
                  toView:nil
              completion:completion];
}

+ (void)lc_showWarning:(NSString *)warning
                toView:(UIView *)view
            completion:(MBProgressHUDCompletionBlock)completion {
    [self lc_show:warning
             icon:@"MBProgressHUD.bundle/MBHUD_Warn"
             view:view
       completion:completion];
}

+ (void)lc_show:(NSString *)text
           icon:(NSString *)icon
           view:(UIView *)view
     completion:(MBProgressHUDCompletionBlock)completion {
    MBProgressHUD *hud = [self lc_configHUDWithView:view
                                              title:text
                                        autoDismiss:YES
                                         completion:completion];
    hud.userInteractionEnabled = NO;
    hud.mode = MBProgressHUDModeCustomView;
    hud.animationType = MBProgressHUDAnimationZoom;
    hud.iconName(icon);
}

// MARK:Switch Model
+ (MBProgressHUD *)lc_showModelSwitch:(UIView *)view
                                title:(NSString *)title
                          configBlock:(WBHUDConfigBlock)configBlock {
    MBProgressHUD *hud = [self lc_configHUDWithView:view
                                              title:title
                                        autoDismiss:NO
                                         completion:nil];
    hud.minSize = CGSizeMake(150.f, 100.f);
    if (configBlock) {
        configBlock(hud);
    }
    return hud;
}

// MARK:Progress
+ (MBProgressHUD *)lc_showDownloadToView:(UIView *)view
                           progressStyle:(WBHUDProgressStyle)progressStyle
                                   title:(NSString *)title
                             configBlock:(WBHUDConfigBlock)configBlock;
 {
    MBProgressHUD *hud = [self lc_configHUDWithView:view
                                              title:title
                                        autoDismiss:NO
                                         completion:nil];
    if (progressStyle == WBProgressHUDModeDeterminateStyle) {
        hud.mode = MBProgressHUDModeDeterminate;
    }
    if (progressStyle == WBProgressHUDModeAnnularDeterminateStyle) {
        hud.mode = MBProgressHUDModeAnnularDeterminate;
    }
    if (progressStyle == WBProgressHUDModeDeterminateHorizontalBarStyle) {
        hud.mode = MBProgressHUDModeDeterminateHorizontalBar;
    }
    if (configBlock) {
        configBlock(hud);
    }
     return hud;
}

+ (MBProgressHUD *)lc_showDownloadToView:(UIView *)view
                           progressStyle:(WBHUDProgressStyle)progressStyle
                                   title:(NSString *)title
                             cancelTitle:(NSString *)cancelTitle
                             configBlock:(WBHUDConfigBlock)configBlock
                             cancelBlock:(WBHUDCancelBlock)cancelBlock {
    MBProgressHUD *hud = [self lc_configHUDWithView:view
                                              title:title
                                        autoDismiss:NO
                                         completion:nil];
    if (progressStyle == WBProgressHUDModeDeterminateStyle) {
        hud.mode = MBProgressHUDModeDeterminate;
    }
    if (progressStyle == WBProgressHUDModeAnnularDeterminateStyle) {
        hud.mode = MBProgressHUDModeAnnularDeterminate;
    }
    if (progressStyle == WBProgressHUDModeDeterminateHorizontalBarStyle) {
        hud.mode = MBProgressHUDModeDeterminateHorizontalBar;
    }
    [hud.button setTitle:cancelTitle ? : NSLocalizedString(@"Cancel", @"HUD cancel button title")
                forState:UIControlStateNormal];
    [hud.button addTarget:self
                   action:@selector(didClickedCancelBtn)
         forControlEvents:UIControlEventTouchUpInside];
    hud.cancelBlock = cancelBlock;
    
    if (configBlock) {
        configBlock(hud);
    }
    return hud;
}

//#pragma mark --------  Private Method  --------
//#pragma mark
////获取当前屏幕显示的viewcontroller
//+ (UIViewController *)lc_getCurrentWindowVc
//{
//    UIViewController *result = nil;
//    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
//    if (window.windowLevel != UIWindowLevelNormal)
//    {
//        NSArray *windows = [[UIApplication sharedApplication] windows];
//        for(UIWindow * tempWindow in windows)
//        {
//            if (tempWindow.windowLevel == UIWindowLevelNormal)
//            {
//                window = tempWindow;
//                break;
//            }
//        }
//    }
//    UIView *frontView = [[window subviews] objectAtIndex:0];
//    id nextResponder = [frontView nextResponder];
//    if ([nextResponder isKindOfClass:[UIViewController class]])
//    {
//        result = nextResponder;
//    }
//    else
//    {
//        result = window.rootViewController;
//    }
//    return  result;
//}
//
//+ (UIViewController *)lc_getCurrentVc
//{
//    UIViewController  *superVC = [[self class]  lc_getCurrentWindowVc ];
//    if ([superVC isKindOfClass:[UITabBarController class]]) {
//        UIViewController  *tabSelectVC = ((UITabBarController*)superVC).selectedViewController;
//        if ([tabSelectVC isKindOfClass:[UINavigationController class]]) {
//            return ((UINavigationController*)tabSelectVC).viewControllers.lastObject;
//        }
//        return tabSelectVC;
//    }else
//        if ([superVC isKindOfClass:[UINavigationController class]]) {
//            return ((UINavigationController*)superVC).viewControllers.lastObject;
//        }
//    return superVC;
//}

// MARK:Hide
+ (void)lc_hideHUD {
    [self lc_hideHUDForView:nil];
}

+ (void)lc_hideHUDForView:(UIView *)view {
    if (view == nil) view = (UIView *)[UIApplication sharedApplication].delegate.window;
    [self hideHUDForView:view animated:YES];
}

// MARK:设置样式
- (MBProgressHUD *(^)(WBHUDContentStyle))hudContentStyle {
    return ^(WBHUDContentStyle hudContentStyle) {
        switch (hudContentStyle) {
            case WBHUDContentBlackStyle:
                self.contentColor = [UIColor whiteColor];
                self.bezelView.backgroundColor = [UIColor blackColor];
                self.bezelView.style = MBProgressHUDBackgroundStyleBlur;
                break;
            case WBHUDContentCustomStyle:
                self.contentColor = kWBHUDCustomContentColor;
                self.bezelView.backgroundColor = kWBHUDCustomBezelColor;
                self.bezelView.style = MBProgressHUDBackgroundStyleBlur;
                break;
            default:
                self.contentColor = [UIColor blackColor];
                self.bezelView.backgroundColor = [UIColor colorWithWhite:0.902 alpha:1.000];
                self.bezelView.style = MBProgressHUDBackgroundStyleBlur;
                break;
        }
        return self;
    };
}

- (MBProgressHUD *(^)(UIColor *))hudMaskColor {
    return ^(UIColor *hudMaskColor) {
        self.backgroundView.backgroundColor = hudMaskColor;
        return self;
    };
}

- (MBProgressHUD *(^)(UIColor *))hudContentColor {
    return ^(UIColor *hudContentColor) {
        self.contentColor = hudContentColor;
        return self;
    };
}

- (MBProgressHUD *(^)(UIColor *))hudBezelColor {
    return ^(UIColor *hudBezelColor) {
        self.bezelView.backgroundColor = hudBezelColor;
        return self;
    };
}

- (MBProgressHUD *(^)(NSString *))title {
    return ^(NSString *title) {
        self.label.text = title;
        return self;
    };
}

- (MBProgressHUD *(^)(NSString *))detailTitle {
    return ^(NSString *detailTitle) {
        self.detailsLabel.text = detailTitle;
        return self;
    };
}

- (MBProgressHUD *(^)(UIColor *))titleColor {
    return ^(UIColor *titleColor) {
        self.label.textColor = titleColor;
        return self;
    };
}

- (MBProgressHUD *(^)(WBHUDPositionStyle))hudPositon {
    return ^(WBHUDPositionStyle hudPositon) {
        switch (hudPositon) {
            case WBHUDPositionTopStyle:
                self.offset = CGPointMake(0, -MBProgressMaxOffset);
                break;
            case WBHUDPositionCenterStyle:
                self.offset = CGPointZero;
                break;
            case WBHUDPositionBottomStyle:
                self.offset = CGPointMake(0, MBProgressMaxOffset);
                break;
            default:
                break;
        }
        return self;
    };
}

- (MBProgressHUD *(^)(NSString *))iconName {
    return ^(NSString *iconName) {
        self.customView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:iconName]];
        return self;
    };
}

- (void)setCancelBlock:(WBHUDCancelBlock)cancelBlock {
    objc_setAssociatedObject(self, &kWBHUDCancelKey, cancelBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (WBHUDCancelBlock)cancelBlock {
    return objc_getAssociatedObject(self, &kWBHUDCancelKey);
}

// MARK:Event Response
- (void)didClickedCancelBtn {
    if (self.cancelBlock) {
        self.cancelBlock(self);
    }
}

@end
