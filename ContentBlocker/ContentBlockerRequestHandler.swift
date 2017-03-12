//
//  ContentBlockerRequestHandler.swift
//  ContentBlocker
//
//  Created by Vadim Drobinin on 12/3/17.
//  Copyright © 2017 Vadim Drobinin. All rights reserved.
//

import UIKit
import MobileCoreServices

class ContentBlockerRequestHandler: NSObject, NSExtensionRequestHandling {

    func beginRequest(with context: NSExtensionContext) {
      let fileManager = FileManager.default
      if let directory = fileManager.containerURL(forSecurityApplicationGroupIdentifier: "group.PornBlocker") {
        let fileURL = directory.appendingPathComponent("custom.json")
        let attachment = NSItemProvider(contentsOf: fileURL)!
        let item = NSExtensionItem()
        item.attachments = [attachment]
        
        context.completeRequest(returningItems: [item], completionHandler: nil)
      }
    }
    
}
