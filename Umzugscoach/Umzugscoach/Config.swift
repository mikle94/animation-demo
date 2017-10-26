//
//  Constants.swift
//  Umzugscoach
//
//  Created by Mikle Kusmenko on 10/24/17.
//  Copyright © 2017 mk. All rights reserved.
//

import UIKit
import Foundation

// resources
struct Config {
    
    struct colors {
        static let pink   = #colorLiteral(red: 0.8862745098, green: 0.2352941176, blue: 0.4274509804, alpha: 1)
        static let purple = #colorLiteral(red: 0.5921568627, green: 0.2039215686, blue: 0.568627451, alpha: 1)
        static let yellow = #colorLiteral(red: 0.9843137255, green: 0.8823529412, blue: 0, alpha: 1)
        static let black  = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        static let white  = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)        
    }
    
    struct strings {
        static let oldAddressStateTitle   = "Alte Anschrift"
        static let newAddressStateTitle   = "Neue Anschrift"
        static let neueAnschriftEinegeben = "Neue Anschrift eingeben"
        static let vertragspartner        = "Vertragspartner auswählen"
    }
    
    struct identifiers {
        static let addressViewController               = "addressViewController"
        static let partnerTableViewCell                = "partnerTableViewCell"
        static let partnerSelectionViewControllerSegue = "showPartnersSelectionViewController"
        static let congratulationViewControllerSegue = "showCongratulationViewController"
    }
    
    struct fonts {
        static let navigationBarTitleFont = UIF.sofiaProRegular(size: 21.0)
        static let mkPrimaryButtonFont    = UIF.sofiaProRegular(size: 21.0)
        static let mkTextFieldFont        = UIF.sofiaProSemibold(size: 32.0)
    }
}

// fonts
class UIF {
    static func sofiaProSemibold(size: CGFloat) -> UIFont {
        return UIFont(name: "SofiaPro-Semibold", size: size)!
    }
    
    static func sofiaProRegular(size: CGFloat) -> UIFont {
        return UIFont(name: "SofiaProRegular", size: size)!
    }
    
    static func fontNames() {
        for name in UIFont.familyNames {
            print(name)
            print(UIFont.fontNames(forFamilyName: name))
        }
    }
}
