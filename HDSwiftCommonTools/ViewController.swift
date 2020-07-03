//
//  ViewController.swift
//  HDSwiftCommonTools
//
//  Created by Damon on 2020/7/2.
//  Copyright © 2020 Damon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
            
//        let view = UIImageView(image: HDCommonTools.shared.getRadialGradientImage(colors: [UIColor.red, UIColor.black, UIColor.blue], raduis: 45))
        let view = UIImageView(image: HDCommonTools.shared.getLinearGradientImage(colors:  [UIColor.red, UIColor.black, UIColor.blue], directionType: .level))
        
        view.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        self.view.addSubview(view)
        
        print( HDCommonTools.shared.encryptString("哈哈是电话费", encryType: HDEncryType.md5))
        print( HDCommonTools.shared.encryptString("sha1加密", encryType: HDEncryType.sha1))
        print( HDCommonTools.shared.encryptString("哈哈是电话费", encryType: HDEncryType.sha256))
        print( HDCommonTools.shared.encryptString("哈哈是电话费", encryType: HDEncryType.sha512))
        print( HDCommonTools.shared.encryptString("哈哈是电话费", encryType: HDEncryType.base64))
        print( HDCommonTools.shared.base64Decode(base64String: "5ZOI5ZOI5piv55S16K+d6LS5"))
        
        print(HDCommonTools.shared.getSystemUpTime())
        print(HDCommonTools.shared.getIDFAString())
    }

}

