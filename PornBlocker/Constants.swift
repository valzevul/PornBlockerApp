//
//  Constants.swift
//  PornBlocker
//
//  Created by Vadim Drobinin on 12/3/17.
//  Copyright © 2017 Vadim Drobinin. All rights reserved.
//

import Foundation
import UIKit

class Apperance: NSObject {
  static let defaultCornerRadius: CGFloat = 10.0
  static let defaultSpace: CGFloat = 16.0
}

struct Constants {
  static let infoTableViewCellIdentifier = "InfoTableViewCell"
  static let plainTableViewCellIdentifier = "PlainTableViewCell"
  static let imageTableViewCellIdentifier = "ImageTableViewCell"
}

extension NSObject {
  func fill<T>(_ action: (T!) -> ()) -> T! {
    return self as! T
  }
}

extension NSDictionary {
  func parse<T>(_ key: String) -> T {
    return self.object(forKey: key) as! T
  }
  
  func parse<T>(_ key: String, anotherValue: T) -> T {
    return (self.object(forKey: key) as? T) ?? anotherValue
  }
}

let appColor = VDColor()

class VDColor {
  fileprivate(set) var contentColor = UIColor.colorWithHexString("000000")
  
  func resetColor() {
    contentColor = UIColor.colorWithHexString("6F6F6F")
  }
  
  func updateColor(_ color: UIColor) {
    updateColor(color, isWithNotification: true)
  }
  
  func updateColor(_ color: UIColor, isWithNotification: Bool) {
    contentColor = color
  }
}

// MARK: - Background Colors
extension UIColor {
  /** Example: navigation bar color */
  class var backgroundColor: UIColor {
    return UIColor.colorWithHexString("FFFFFF")
  }
  
  /** Example: view background color */
  class var backgroundCustomColor: UIColor {
    return UIColor.colorWithHexString("FFFFFF")
  }
  
  /** Example: navigation bar elements color */
  class var backgroundElementsColor: UIColor {
    return UIColor.colorWithHexString("000000")
  }
}

// MARK: - Content Colors
extension UIColor {
  /** Example: cell background color */
  class var contentBackgroundColor: UIColor {
    return UIColor.colorWithHexString("FFFFFF")
  }
  
  /** Example: name color */
  class var contentElementsColor: UIColor {
    return appColor.contentColor
  }
  
  /** Example: info color */
  class var contentAdditionalElementsColor: UIColor {
    return UIColor.black.withAlphaComponent(0.6)
  }
  
  class var contentSeperatorsColor: UIColor {
    return appColor.contentColor
  }
  
  class var contentSeperatorsSelectionColor: UIColor {
    return UIColor.colorWithHexString("F3F3F3")
  }
  
}

// MARK: - From hex string
extension UIColor {
  class func colorWithHexString(_ hex: String) -> UIColor {
    var hex = hex
    
    if hex.hasPrefix("#") {
      hex = hex.substring(from: 1)
    }
    
    if hex.characters.count == 3 {
      let redHex = hex.substring(with: 0..<1)
      let greenHex = hex.substring(with: 1..<2)
      let blueHex = hex.substring(with: 2..<3)
      
      hex = redHex + redHex + greenHex + greenHex + blueHex + blueHex
    }
    
    let redHex = hex.substring(with: 0..<2)
    let greenHex = hex.substring(with: 2..<4)
    let blueHex = hex.substring(with: 4..<6)
    
    var redInt: CUnsignedInt = 0
    var greenInt: CUnsignedInt = 0
    var blueInt: CUnsignedInt = 0
    
    Scanner(string: redHex).scanHexInt32(&redInt)
    Scanner(string: greenHex).scanHexInt32(&greenInt)
    Scanner(string: blueHex).scanHexInt32(&blueInt)
    
    return UIColor(red: CGFloat(redInt) / 255.0,
                   green: CGFloat(greenInt) / 255.0,
                   blue: CGFloat(blueInt) / 255.0,
                   alpha: 1.0)
  }
}

extension String {
  func substring(from index: Int) -> String {
    return self.substring(from: self.characters.index(self.startIndex, offsetBy: index))
  }
  
  func substring(with range: Range<Int>) -> String {
    let startIndex = self.characters.index(self.startIndex, offsetBy: range.lowerBound)
    let endIndex = self.characters.index(self.startIndex, offsetBy: range.upperBound)
    return self.substring(with: startIndex..<endIndex)
  }
}

extension UIFont {
  class func appUltraLightFont(_ size: CGFloat) -> UIFont {
    return UIFont(name: "AvenirNext-UltraLight", size: size) ?? UIFont.systemFont(ofSize: size)
  }
  
  class func appRegularFont(_ size: CGFloat) -> UIFont {
    return UIFont(name: "AvenirNext-Regular", size: size) ?? UIFont.systemFont(ofSize: size)
  }
  
  class func appMediumFont(_ size: CGFloat) -> UIFont {
    return UIFont(name: "AvenirNext-Medium", size: size) ?? UIFont.boldSystemFont(ofSize: size)
  }
  
  class func appHeavyFont(_ size: CGFloat) -> UIFont {
    return UIFont(name: "AvenirNext-Heavy", size: size) ?? UIFont.boldSystemFont(ofSize: size)
  }
  
  class func appBoldFont(_ size: CGFloat) -> UIFont {
    return UIFont(name: "AvenirNext-Bold", size: size) ?? UIFont.boldSystemFont(ofSize: size)
  }
  
  class func appDemiBoldFont(_ size: CGFloat) -> UIFont {
    return UIFont(name: "AvenirNext-DemiBold", size: size) ?? UIFont.boldSystemFont(ofSize: size)
  }
  
  class var appDefaultTextFontSize: CGFloat {
    return 14.0
  }
  
  class var appDefaultSmallTextFontSize: CGFloat {
    return 12.0
  }
}

extension UIFont {
  class func appUltraLightFont() -> UIFont {
    return appUltraLightFont(appDefaultTextFontSize)
  }
  
  class func appRegularFont() -> UIFont {
    return appRegularFont(appDefaultTextFontSize)
  }
  
  class func appMediumFont() -> UIFont {
    return appMediumFont(appDefaultTextFontSize)
  }
  
  class func appHeavyFont() -> UIFont {
    return appHeavyFont(appDefaultTextFontSize)
  }
  
  class func appBoldFont() -> UIFont {
    return appBoldFont(appDefaultTextFontSize)
  }
  
  class func appDemiBoldFont() -> UIFont {
    return appDemiBoldFont(appDefaultTextFontSize)
  }
}

extension UIImage {
  class func imageFromColor(_ color: UIColor) -> UIImage {
    let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
    UIGraphicsBeginImageContext(rect.size)
    let context = UIGraphicsGetCurrentContext()
    
    context?.setFillColor(color.cgColor);
    context?.fill(rect);
    
    let image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image!
  }
  
  func imageWithColor(_ color: UIColor) -> UIImage {
    UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
    
    let context = UIGraphicsGetCurrentContext()! as CGContext
    context.translateBy(x: 0, y: self.size.height)
    context.scaleBy(x: 1.0, y: -1.0);
    
    context.setBlendMode(CGBlendMode.normal)
    
    let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height) as CGRect
    context.clip(to: rect, mask: self.cgImage!)
    color.setFill()
    context.fill(rect)
    
    let newImage = UIGraphicsGetImageFromCurrentImageContext()! as UIImage
    UIGraphicsEndImageContext()
    
    return newImage
  }
}
