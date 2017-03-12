//
//  HelpParser.swift
//  PornBlocker
//
//  Created by Vadim Drobinin on 12/3/17.
//  Copyright © 2017 Vadim Drobinin. All rights reserved.
//

import Foundation

class Help {
  fileprivate struct Keys {
    static var nameKey = "name"
    static var descriptionKey = "description"
    static var helpsKey = "helps"
  }
  
  var name: String
  var description: String
  var helps: [String] = []
  
  init(info: NSDictionary) {
    name = info.parse(Keys.nameKey)
    description = info.parse(Keys.descriptionKey)
    helps = info.parse(Keys.helpsKey)
  }
}

class HelpParser {
  static var Helps: [Help] = HelpParser.loadHelps()
  
  fileprivate class func loadHelps() -> [Help] {
    var result: [Help] = []
    let arr = NSArray(contentsOfFile: Bundle.main.path(forResource: "Helps", ofType: "plist")!)!
    
    for dict in arr as! [NSDictionary] {
      let entity = Help(info: dict)
      result.append(entity)
    }
    
    return result
  }
}
