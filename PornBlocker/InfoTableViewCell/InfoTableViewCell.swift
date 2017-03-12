//
//  HelpViewController.swift
//  PornBlocker
//
//  Created by Vadim Drobinin on 12/3/17.
//  Copyright © 2017 Vadim Drobinin. All rights reserved.
//

import UIKit

class InfoTableViewCell: RoundedTableViewCell {

    @IBOutlet weak var nameLabel: UILabel! {
        didSet {
            nameLabel.font = UIFont.appMediumFont()
            nameLabel.textColor = UIColor.contentElementsColor
        }
    }
    
    @IBOutlet weak var infoDescriptionLabel: UILabel! {
        didSet {
            infoDescriptionLabel.font = UIFont.appRegularFont()
            infoDescriptionLabel.textColor = UIColor.contentAdditionalElementsColor
        }
    }
    var infoDescription: String = "" {
        didSet {
            updateInfoDescriptionLabel()
        }
    }
    
    @IBOutlet weak var accessorizeImageView: UIImageView! {
        didSet {
            accessorizeImageView.image = accessorizeImageView.image?.imageWithColor(appColor.contentColor)
        }
    }
    
    @IBOutlet weak var accessorizeWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var accessorizeRightConstraint: NSLayoutConstraint!

    var selectionEnable: Bool = false {
        didSet {
            isUserInteractionEnabled = selectionEnable
            accessorizeImageView.isHidden = !selectionEnable
            updateInfoDescriptionLabel()
            
            if selectionEnable {
                accessorizeRightConstraint.constant = 8
                accessorizeWidthConstraint.constant = 20
            } else {
                accessorizeRightConstraint.constant = 0
                accessorizeWidthConstraint.constant = 0
            }
        }
    }
    
    func updateInfoDescriptionLabel() {
        let mutableString = NSMutableAttributedString(string: infoDescription)
        
        if selectionEnable {
            mutableString.addAttribute(NSUnderlineStyleAttributeName, value: NSUnderlineStyle.styleSingle.rawValue, range: NSMakeRange(0, mutableString.length))
        }
        
        infoDescriptionLabel.attributedText = mutableString
    }
    
}
