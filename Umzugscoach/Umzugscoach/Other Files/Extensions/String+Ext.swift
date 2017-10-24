//
//  String+Ext.swift
//  Umzugscoach
//
//  Created by Mikle Kusmenko on 10/24/17.
//  Copyright © 2017 mk. All rights reserved.
//

import UIKit
import Foundation

extension String {
    func gradientColor(font: UIFont, startColor: UIColor, endColor: UIColor) -> UIColor? {
        var startColorRed: CGFloat   = 0
        var startColorGreen: CGFloat = 0
        var startColorBlue: CGFloat  = 0
        var startAlpha: CGFloat      = 0
        if !startColor.getRed(&startColorRed, green: &startColorGreen, blue: &startColorBlue, alpha: &startAlpha) {
            return nil
        }
        var endColorRed:CGFloat   = 0
        var endColorGreen:CGFloat = 0
        var endColorBlue:CGFloat  = 0
        var endAlpha:CGFloat      = 0
        if !endColor.getRed(&endColorRed, green: &endColorGreen, blue: &endColorBlue, alpha: &endAlpha) {
            return nil
        }
        let textSize: CGSize = self.size(withAttributes: [NSAttributedStringKey.font: font])
        let width: CGFloat = textSize.width
        let height: CGFloat = textSize.height
        
        UIGraphicsBeginImageContext(CGSize(width: width, height: height))
        
        guard let context = UIGraphicsGetCurrentContext() else {
            UIGraphicsEndImageContext()
            return nil
        }
        
        UIGraphicsPushContext(context)
        
        let glossGradient: CGGradient?
        let rgbColorspace: CGColorSpace?
        let num_locations: size_t = 2
        let locations: [CGFloat] = [0.0, 1.0]
        let components: [CGFloat] = [startColorRed, startColorGreen, startColorBlue, startAlpha, endColorRed, endColorGreen, endColorBlue, endAlpha]
        rgbColorspace = CGColorSpaceCreateDeviceRGB()
        glossGradient = CGGradient(colorSpace: rgbColorspace!, colorComponents: components, locations: locations, count: num_locations)
        let start = CGPoint.zero
        let end = CGPoint(x: width, y: height)
        context.drawLinearGradient(glossGradient!, start: start, end: end, options: CGGradientDrawingOptions.drawsBeforeStartLocation)
        
        UIGraphicsPopContext()
        
        guard let gradientImage = UIGraphicsGetImageFromCurrentImageContext() else {
            UIGraphicsEndImageContext()
            return nil
        }
        
        UIGraphicsEndImageContext()
        
        return UIColor(patternImage: gradientImage)
    }
}
