//
//  HUD.swift
//  PNStarCalendar
//
//  Created by Thor on 2018/5/24.
//  Copyright © 2018年 http://www.cnblogs.com/saytome/. All rights reserved.
//

import UIKit


public class HUD {

    public class func showWaiting() {
        MBProgressHUD.lc_showActivityMessage(nil);
    }
    
    public class func showDialog(text:String?) {
        MBProgressHUD.lc_showMessage(text);
        if let message = text {
            print("⚠️"+message);
        }
    }
    
    public class func dismiss() {
        MBProgressHUD.lc_hide();
    }
    
}



