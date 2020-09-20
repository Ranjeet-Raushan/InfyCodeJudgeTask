//  TextField.swift
//  InfyCodeJudgeTask
//  Created by Ranjeet Raushan on 20/09/20.
//  Copyright © 2020 Ranjeet Raushan. All rights reserved.

import Foundation
import UIKit

extension HoshiTextField {
    
    func setBorderActiveInactive(activeColor: UIColor, inactiveColor: UIColor,placeholderColor: UIColor) {
        self.borderActiveColor = activeColor
        self.borderInactiveColor = inactiveColor
        self.placeholderColor = placeholderColor
    }
}
