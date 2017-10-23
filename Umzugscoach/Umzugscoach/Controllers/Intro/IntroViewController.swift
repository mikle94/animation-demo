//
//  IntroViewController.swift
//  Umzugscoach
//
//  Created by Mikle Kusmenko on 10/23/17.
//  Copyright © 2017 mk. All rights reserved.
//

import UIKit
import pop

class IntroViewController: UIViewController {

    @IBOutlet weak var houseImageView: UIImageView!
    @IBOutlet weak var houseImageViewTop: NSLayoutConstraint!
    @IBOutlet weak var houseImageViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var continueBtn: UIButton!
    @IBOutlet weak var continueBtnBottom: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupInitialState()
    }
    
    func setupNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear
    }
    
    func setupInitialState() {
        houseImageView.isHidden    = true
        titleLabel.alpha           = 0.0
        subtitleLabel.alpha        = 0.0
        descriptionLabel.alpha     = 0.0
        continueBtnBottom.constant = 60.0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateHouse()
        animateLabel(titleLabel, duration: 0.35)
        delay(0.5) {
            self.animateLabel(self.subtitleLabel, duration: 0.95)
        }
        delay(1.0) {
            self.animateLabel(self.descriptionLabel, duration: 0.95)
        }
        delay(1.5) {
            self.animateContinueBtn()
        }
    }
    
    func animateHouse() {
        // show house and label
        houseImageView.isHidden = false
        // set house initial position before animation
        houseImageViewTop.constant = 18.0
        houseImageViewHeight.constant = 200.0
        view.layoutIfNeeded()
        // top animation using values from Flinto
        let topAnimation = POPSpringAnimation(propertyNamed: kPOPLayoutConstraintConstant)
        topAnimation!.dynamicsTension = 950
        topAnimation!.dynamicsFriction = 17
        topAnimation!.velocity = 0
        topAnimation!.toValue = 58.0
        // height animation
        let heightAnimation = POPSpringAnimation(propertyNamed: kPOPLayoutConstraintConstant)
        heightAnimation!.dynamicsTension = 950
        heightAnimation!.dynamicsFriction = 17
        heightAnimation!.velocity = 0
        heightAnimation!.toValue = 160.0
        // start animations
        houseImageViewTop.pop_add(topAnimation, forKey: "topAnimation")
        houseImageViewHeight.pop_add(heightAnimation, forKey: "heightAnimation")
    }
    
    func animateLabel(_ label: UILabel, duration: TimeInterval = 1.0) {
        UIView.animate(withDuration: duration) {
            label.alpha = 1.0
        }
    }
    
    func animateContinueBtn() {
        // bottom button animation using values from Flinto
        let bottomButtonAnimation = POPSpringAnimation(propertyNamed: kPOPLayoutConstraintConstant)
        bottomButtonAnimation!.dynamicsTension = 950
        bottomButtonAnimation!.dynamicsFriction = 67
        bottomButtonAnimation!.velocity = 12
        bottomButtonAnimation!.toValue = 0.0
        // start animations
        continueBtnBottom.pop_add(bottomButtonAnimation, forKey: "bottomButtonAnimation")
    }
}
