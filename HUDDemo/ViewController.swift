//
//  ViewController.swift
//  HUDDemo
//
//  Created by lichao on 2019/1/15.
//  Copyright © 2019 chuck. All rights reserved.
//

import UIKit
import HudExtension

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event);
        
        HUD.showDialog(text: "test");
    }
}

