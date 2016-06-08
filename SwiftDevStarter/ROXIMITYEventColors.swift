//
//  ROXIMITYEventColors.swift
//  SwiftDevStarter
//
//  Created by Cole Richards on 6/8/16.
//  Copyright © 2016 ROXIMITY. All rights reserved.
//

import UIKit

class ROXIMITYEventColors: NSObject {
    
    static func darkBlue()->UIColor{
        return UIColor.init(netHex:0x334D5C)
    }
    
    static func cyanBlue()->UIColor{
        return UIColor.init(netHex: 0x45B29D)
    }

    static func orange()->UIColor{
        return UIColor.init(netHex: 0xE27A3F)
    }
    static func mediumYellow()->UIColor{
        return UIColor.init(netHex: 0xEFC94C)
    }
    static func red()->UIColor{
        return UIColor.init(netHex: 0xDF5A49)
    }
    
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}
