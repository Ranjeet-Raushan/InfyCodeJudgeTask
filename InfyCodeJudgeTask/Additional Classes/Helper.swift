//  Helper.swift
//  InfyCodeJudgeTask
//  Created by Ranjeet Raushan on 20/09/20.
//  Copyright © 2020 Ranjeet Raushan. All rights reserved.

import Foundation
import UIKit
import SwiftMessages
extension UITextField {

func useUnderline() {
    let border = CALayer()
    let borderWidth = CGFloat(1.0)
    border.borderColor = UIColor.white.cgColor
    border.frame = CGRect(origin: CGPoint(x: 0,y :self.frame.size.height - borderWidth), size: CGSize(width: self.frame.size.width + 800, height: self.frame.size.height))
    border.borderWidth = borderWidth
    self.layer.addSublayer(border)
    self.layer.masksToBounds = true
    
    }
}
func showMessage(view: MessageView = try! SwiftMessages.viewFromNib(), isCardView: Bool = false ,titleText: String = "Message" ,bodyText: String,iconImage: UIImage? = nil ,iconText: String? = nil,
                 buttonImage: UIImage? = nil,buttonTitle: String? = "OK",theme: Theme = Theme.info, iconStyle: IconStyle = .default,
                 accessibilityPrefix: String = "info", dropShadow: Bool = true, showButton:Bool = true,showIcon: Bool = true ,showTitle: Bool = true ,showBody: Bool = true, presentationStyle: SwiftMessages.PresentationStyle = .top ,presentationContext: SwiftMessages.PresentationContext = .window(windowLevel: UIWindow.Level.normal),duration: SwiftMessages.Duration = .forever, dimMode: SwiftMessages.DimMode = .gray(interactive: true),shouldAutoRotate: Bool = true,interactiveHide: Bool = true, buttonTapHandler: ((UIButton)->())? = { _ in SwiftMessages.hide() } ) {
    view.configureContent(title: titleText, body: bodyText, iconImage: iconImage, iconText: iconText, buttonImage: buttonImage, buttonTitle:  buttonTitle, buttonTapHandler : buttonTapHandler)
    view.configureTheme(theme, iconStyle: iconStyle)
    view.accessibilityPrefix = accessibilityPrefix
    
    if dropShadow {
        view.configureDropShadow()
    }
    if !showButton{
        view.button?.isHidden = true
    }
    if !showIcon  {
        view.iconImageView?.isHidden = true
        view.iconLabel?.isHidden = true
    }
    if !showTitle {
        view.titleLabel?.isHidden = true
    }
    
    if !showBody{
        view.bodyLabel?.isHidden = true
    }
    if case Theme.warning = theme  {
    }
    // Config setup
    var config = SwiftMessages.defaultConfig
    config.presentationStyle = presentationStyle
    config.presentationContext = presentationContext
    config.duration = duration
    config.dimMode = dimMode
    config.shouldAutorotate = shouldAutoRotate
    config.interactiveHide = interactiveHide
    // Set status bar style unless using card view (since it doesn't
    // go behind the status bar).
    if case .top = config.presentationStyle, isCardView {
        config.preferredStatusBarStyle = .lightContent
    }
    //Show
    SwiftMessages.show(config: config, view: view)
}

extension String {
    func trim() -> String {
        return self.trimmingCharacters(in: NSCharacterSet.whitespaces)
    }
}

extension String {
    func isValidEmail() -> Bool {
        let emailRegEx = "(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"+"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"+"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"+"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"+"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"+"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"+"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        
        let emailTest = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
}
