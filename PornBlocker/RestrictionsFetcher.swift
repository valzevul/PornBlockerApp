//
//  RestrictionsFetcher.swift
//  PornBlocker
//
//  Created by Vadim Drobinin on 12/3/17.
//  Copyright © 2017 Vadim Drobinin. All rights reserved.
//

import Foundation
import SafariServices

class RestrictionsFetcher {
  
  let id = "com.etrainmobilegames.pornblocker"
  
  func getNewFiles() {
    let url = "http://q2mobilelabs.com/blocker/blockerList.json"
    URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { (data, response, error) -> Void in
      if error == nil && data != nil {
        do {
          let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! [[String: AnyObject]]
          var jsonData: Data!
          do {
            jsonData = try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted)
          } catch let error as NSError {
            print("Array to JSON conversion failed: \(error.localizedDescription)")
          }
          
          let fileManager = FileManager.default
          if let directory = fileManager.containerURL(forSecurityApplicationGroupIdentifier: "group.com.etrainmobilegames.pornblocker") {
            let fileURL = directory.appendingPathComponent("custom.json")
            
            do {
              try jsonData.write(to: fileURL, options: .atomic)
              URLCache.shared.removeAllCachedResponses()
            } catch {
              print(error)
            }
          }
          
          SFContentBlockerManager.reloadContentBlocker(withIdentifier: self.id) { error in
            print(error)
            self.testReading()
          }
        } catch {
          
        }
      }
    }).resume()
  }
  
  func testReading() {
    if let file = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.com.etrainmobilegames.pornblocker") {
      let fileURL = file.appendingPathComponent("custom.json")
      let jsonData = try! Data(contentsOf: fileURL, options: .mappedIfSafe)
      do {
        if let jsonResult = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions(rawValue: 0)) as? NSArray {
          print(jsonResult)
        }
      } catch let error as NSError {
        print("Error: \(error)")
      }
    }
  }
}
