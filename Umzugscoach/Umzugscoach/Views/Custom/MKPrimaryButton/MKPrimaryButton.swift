//
//  MKPrimaryButton.swift
//  Umzugscoach
//
//  Created by Mikle Kusmenko on 10/24/17.
//  Copyright © 2017 mk. All rights reserved.
//

import UIKit

class MKPrimaryButton: UIButton {
    
    let bgColor            = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.8470943921)
    let gradientStartColor = Config.colors.pink
    let gradientEndColor   = Config.colors.purple
    let buttonFont         = Config.fonts.mkPrimaryButtonFont

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearance()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupAppearance()
    }
    
    private func setupAppearance() {
        titleLabel?.font = buttonFont
        backgroundColor = bgColor
        let text = title(for: .normal) ?? ""
        let color = text.gradientColor(
            font: buttonFont,
            startColor: gradientStartColor,
            endColor: gradientEndColor
        )
        setTitleColor(color, for: .normal)
    }
}
