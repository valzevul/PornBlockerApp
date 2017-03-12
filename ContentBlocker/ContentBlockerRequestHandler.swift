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
      
//        let attachment1 = NSItemProvider(contentsOf: Bundle.main.url(forResource: "blockerList", withExtension: "json"))!
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("custom.json")
        let attachment2 = NSItemProvider(contentsOf: fileURL)!
        print(attachment2)
        let item = NSExtensionItem()
        item.attachments = [attachment2]
        
        context.completeRequest(returningItems: [item], completionHandler: nil)
    }
    
}
