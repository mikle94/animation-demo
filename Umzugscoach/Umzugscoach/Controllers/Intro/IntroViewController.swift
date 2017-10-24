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
    
    var animationWasShown: Bool = false
    var isNavigationBarHidden: Bool = true {
        didSet {
            navigationController?.setNavigationBarHidden(isNavigationBarHidden, animated: isNavigationBarHidden)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupInitialState()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        isNavigationBarHidden = false
    }
    
    func setupNavigationBar() {
        // title attributes
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedStringKey.font: Config.fonts.navigationBarTitleFont,
            NSAttributedStringKey.foregroundColor: Config.colors.black
        ]
        // custom back button
        navigationController?.navigationBar.backIndicatorImage = #imageLiteral(resourceName: "left-arrow")
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = #imageLiteral(resourceName: "left-arrow")
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        // tint color
        navigationController?.navigationBar.tintColor = Config.colors.black
        // transparent nav bar
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear
    }
    
    func setupInitialState() {
        houseImageView.alpha       = 0.0
        titleLabel.alpha           = 0.0
        subtitleLabel.alpha        = 0.0
        descriptionLabel.alpha     = 0.0
        continueBtnBottom.constant = 60.0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !animationWasShown {
            animationWasShown = true
            delay(1.0) {
                self.animateViews()
            }
        }
    }
    
    func animateViews() {
        animateViewAlpha(titleLabel, duration: 0.075)
        animateViewAlpha(houseImageView, duration: 0.1)
        animateHouse()
        delay(0.5) {
            self.animateViewAlpha(self.subtitleLabel, duration: 0.95)
        }
        delay(1.0) {
            self.animateViewAlpha(self.descriptionLabel, duration: 0.95)
        }
        delay(1.5) {
            self.animateContinueBtn()
        }
    }
    
    func animateHouse() {
        // set house initial position before animation
        houseImageViewTop.constant = 162.0
        houseImageViewHeight.constant = 100.0
        view.layoutIfNeeded()
        UIView.animate(withDuration: 0.15, animations: {
            self.houseImageViewTop.constant = 32.0
            self.houseImageViewHeight.constant = 230.0
            self.view.layoutIfNeeded()
        }, completion: { Void in
            UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.25, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
                self.houseImageViewTop.constant = 102.0
                self.houseImageViewHeight.constant = 160.0
                self.view.layoutIfNeeded()
            }, completion: nil)
        })
    }
    
    func animateViewAlpha(_ view: UIView, alpha: CGFloat = 1.0, duration: TimeInterval = 1.0) {
        UIView.animate(withDuration: duration) {
            view.alpha = 1.0
        }
    }
    
    func animateContinueBtn() {
        // bottom button animation using values from Flinto
        let slideAnimation = POPSpringAnimation(propertyNamed: kPOPLayoutConstraintConstant)
        slideAnimation!.dynamicsTension = 950
        slideAnimation!.dynamicsFriction = 67
        slideAnimation!.velocity = 12
        slideAnimation!.toValue = 0.0
        // start animations
        continueBtnBottom.pop_add(slideAnimation, forKey: "slideAnimation")
    }
    
    @IBAction func continueBtnPressed() {
        if let addressViewController = storyboard?.instantiateViewController(withIdentifier: Config.identifiers.addressViewController) as? AddressViewController {
            addressViewController.address = .old
            navigationController?.pushViewController(addressViewController, animated: true)
        }
    }
}
