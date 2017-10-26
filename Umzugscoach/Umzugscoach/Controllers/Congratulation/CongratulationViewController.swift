//
//  CongratulationViewController.swift
//  Umzugscoach
//
//  Created by Mikle Kusmenko on 10/26/17.
//  Copyright © 2017 mk. All rights reserved.
//

import UIKit

class CongratulationViewController: UIViewController {

    @IBOutlet weak var emailImageView: UIImageView!
    @IBOutlet weak var emailImageViewTop: NSLayoutConstraint!
    @IBOutlet weak var emailImageViewHeight: NSLayoutConstraint!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var moreFunctionsLabel: UILabel!
    @IBOutlet weak var declineOldContractsBtn: MKPrimaryButton!
    @IBOutlet weak var findContractBtn: MKPrimaryButton!
    @IBOutlet weak var contractManagementBtn: MKPrimaryButton!
    
    var isNavigationBarHidden: Bool = true {
        didSet {
            navigationController?.setNavigationBarHidden(isNavigationBarHidden, animated: isNavigationBarHidden)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialState()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        isNavigationBarHidden = true
    }
    
    func setupInitialState() {
        emailImageView.alpha     = 0.0
        titleLabel.alpha         = 0.0
        subtitleLabel.alpha      = 0.0
        moreFunctionsLabel.alpha = 0.0
        let additionalHeight     = UIScreen.main.bounds.height + 60.0 // 40.0 - btn height + 20.0 additional
        declineOldContractsBtn.transform = CGAffineTransform(translationX: 0, y: -declineOldContractsBtn.frame.origin.y + additionalHeight)
        findContractBtn.transform        = CGAffineTransform(translationX: 0, y: -findContractBtn.frame.origin.y + additionalHeight)
        contractManagementBtn.transform  = CGAffineTransform(translationX: 0, y: -contractManagementBtn.frame.origin.y + additionalHeight)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        delay(1.0) {
            self.animateViews()
        }
    }
    
    func animateViews() {
        emailImageView.animateAlpha(duration: 0.1)
        animateEmail()
        delay(0.5) {
            self.titleLabel.animateAlpha(duration: 0.3)
        }
        delay(0.75) {
            self.subtitleLabel.animateAlpha(duration: 0.5)
        }
        delay(1.0) {
            self.moreFunctionsLabel.animateAlpha(duration: 0.5)
            self.animateButtons()
        }
    }
    
    func animateEmail() {
        // set email initial position before animation
        emailImageViewTop.constant = 117.0
        emailImageViewHeight.constant = 100.0
        view.layoutIfNeeded()
        UIView.animate(withDuration: 0.15, animations: {
            self.emailImageViewTop.constant = 0.0
            self.emailImageViewHeight.constant = 217.0
            self.view.layoutIfNeeded()
        }, completion: { Void in
            UIView.animate(
                withDuration: 0.7,
                delay: 0,
                usingSpringWithDamping: 0.25,
                initialSpringVelocity: 0,
                options: .curveEaseOut,
                animations: {
                    self.emailImageViewTop.constant = 60.0
                    self.emailImageViewHeight.constant = 157.0
                    self.view.layoutIfNeeded()
                },
                completion: nil
            )
        })
    }
    
    func animateButtons() {
        let buttons: [MKPrimaryButton] = [declineOldContractsBtn, findContractBtn, contractManagementBtn]
        for i in 0 ..< buttons.count {
            UIView.animate(
                withDuration: 0.35,
                delay: Double(i) * 0.25,
                usingSpringWithDamping: 0.65,
                initialSpringVelocity: 0,
                options: .curveEaseOut,
                animations: {
                    buttons[i].transform = .identity
                },
                completion: nil
            )
        }
    }
}
