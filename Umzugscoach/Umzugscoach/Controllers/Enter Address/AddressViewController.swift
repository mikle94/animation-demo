//
//  AddressViewController.swift
//  Umzugscoach
//
//  Created by Mikle Kusmenko on 10/24/17.
//  Copyright © 2017 mk. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class AddressViewController: UIViewController {
    
    @IBOutlet weak var streetTextField: MKTextField!
    @IBOutlet weak var numberTextField: MKTextField!
    @IBOutlet weak var postalCodeTextField: MKTextField!
    @IBOutlet weak var cityTextField: MKTextField!
    @IBOutlet weak var continueBtn: MKPrimaryButton!
    @IBOutlet weak var continueBtnBottom: NSLayoutConstraint!
    
    enum AddressState {
        case old, new
        
        var title: String {
            switch self {
                case .old:
                    return Config.strings.oldAddressStateTitle
                case .new:
                    return Config.strings.newAddressStateTitle
            }
        }
        
        var continueBtnTitle: String {
            switch self {
                case .old:
                    return Config.strings.neueAnschriftEinegeben
                case .new:
                    return Config.strings.vertragspartner
            }
        }
    }
    
    var address: AddressState?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupButton()
    }
    
    func setupNavigationBar() {
        title = address?.title
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    func setupButton() {
        continueBtn.setTitle(address?.continueBtnTitle, for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // add 60.0 to distance because of continue button
        IQKeyboardManager.sharedManager().keyboardDistanceFromTextField = 10.0 + 60.0
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardNotification(_:)),
            name: NSNotification.Name.UIKeyboardWillChangeFrame,
            object: nil
        )
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // move back to default value
        IQKeyboardManager.sharedManager().keyboardDistanceFromTextField = 10.0
        NotificationCenter.default.removeObserver(self)
    }
    
    @IBAction func enterNewAddressBtnPressed() {
        if address == .old, let addressViewController = storyboard?.instantiateViewController(withIdentifier: Config.identifiers.addressViewController) as? AddressViewController {
            addressViewController.address = .new
            navigationController?.pushViewController(addressViewController, animated: true)
        } else {
            print("go to table view")
        }
    }
    
    @objc func keyboardNotification(_ notification: NSNotification) {
        if let userInfo = notification.userInfo, let frame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let duration: TimeInterval = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIViewAnimationOptions.curveEaseInOut.rawValue
            let animationCurve: UIViewAnimationOptions = UIViewAnimationOptions(rawValue: animationCurveRaw)
            if frame.origin.y >= UIScreen.main.bounds.size.height {
                continueBtnBottom.constant = 0.0
            } else {
                continueBtnBottom.constant = frame.size.height
            }
            UIView.animate(
                withDuration: duration,
                delay: 0,
                options: animationCurve,
                animations: {
                    self.view.layoutIfNeeded()
                },
                completion: nil
            )
        }
    }
}
