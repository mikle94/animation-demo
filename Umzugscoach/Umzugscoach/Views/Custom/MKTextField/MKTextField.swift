//
//  MKTextField.swift
//  Umzugscoach
//
//  Created by Mikle Kusmenko on 10/24/17.
//  Copyright © 2017 mk. All rights reserved.
//

import UIKit

@IBDesignable
class MKTextField: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var hintLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var border: UIView!
    
    private let defaultBorderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2028039384)
    
    @IBInspectable
    var hintText: String? {
        didSet {
            hintLabel.text = hintText
        }
    }
    
    @IBInspectable
    var textFieldText: String? {
        didSet {
            textField.text = textFieldText
        }
    }
    
    @IBInspectable
    var placeholder: String? {
        didSet {
            textField.attributedPlaceholder = NSAttributedString(
                string: placeholder ?? "",
                attributes: [
                    NSAttributedStringKey.font: textField.font ?? Config.fonts.mkTextFieldFont,
                    NSAttributedStringKey.foregroundColor: textField.textColor ?? Config.colors.white
                ]
            )
        }
    }
    
    var borderHighlighter: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 0, height: 2.0)
        view.backgroundColor = Config.colors.yellow
        return view
    }()
    
    var didBeginEditing: Bool = false {
        didSet {
            updateAppearance()
            if didBeginEditing {
                animateBorder()
            } else {
                removeBorderAnimation()
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customInit()
    }
    
    private func customInit() {
        let bundle = Bundle(for: type(of: self))
        bundle.loadNibNamed("MKTextField", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        border.layer.cornerRadius = 1.0
        textField.tintColor = Config.colors.yellow
    }
    
    private func updateAppearance() {
        hintLabel.textColor = didBeginEditing ? Config.colors.yellow : Config.colors.black
    }
    
    private func animateBorder() {
        // animating highlighter in 3 steps
        borderHighlighter.frame = CGRect(x: 0, y: 0, width: 0, height: 2.0)
        border.addSubview(borderHighlighter)
        let initialHighlighterWidth: CGFloat = 50.0
        let duration: TimeInterval = 0.45
        UIView.animate(withDuration: duration, animations: {
            self.borderHighlighter.frame = CGRect(
                x: 0, y: 0,
                width: initialHighlighterWidth,
                height: self.borderHighlighter.frame.height
            )
        }, completion: { Void in
            let xValue = self.border.frame.width - initialHighlighterWidth
            UIView.animate(withDuration: duration, animations: {
                self.borderHighlighter.frame = CGRect(
                    x: xValue, y: 0,
                    width: initialHighlighterWidth,
                    height: self.borderHighlighter.frame.height
                )
            }, completion: { Void in
                UIView.animate(withDuration: duration) {
                    self.borderHighlighter.frame = CGRect(
                        x: 0, y: 0,
                        width: self.border.frame.width,
                        height: self.borderHighlighter.frame.height
                    )
                }
            })
        })
    }
    
    private func removeBorderAnimation() {
        // setting frame back
        layoutIfNeeded()
        borderHighlighter.removeFromSuperview()
    }
}

extension MKTextField: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        didBeginEditing = true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        didBeginEditing = false
    }
}
