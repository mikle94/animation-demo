//
//  PartnerSelectionTableViewCell.swift
//  Umzugscoach
//
//  Created by Mikle Kusmenko on 10/25/17.
//  Copyright © 2017 mk. All rights reserved.
//

import UIKit

class PartnerSelectionTableViewCell: UITableViewCell {

    @IBOutlet weak var customContainerView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var checkboxImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupContainerViewShadow()
    }
    
    func setupContainerViewShadow() {
        customContainerView.layer.masksToBounds = false
        customContainerView.layer.shadowColor   = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        customContainerView.layer.shadowOffset  = CGSize(width: 0, height: 2)
        customContainerView.layer.shadowRadius  = 0
        customContainerView.layer.shadowOpacity = 0.1
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        keepContainerViewBackground(selected)
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        keepContainerViewBackground(highlighted)
    }
    
    private func keepContainerViewBackground(_ selected: Bool) {
        customContainerView.backgroundColor = selected ? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2003157106) : customContainerView.backgroundColor
    }
}
