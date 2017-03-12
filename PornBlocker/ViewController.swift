//
//  ViewController.swift
//  PornBlocker
//
//  Created by Vadim Drobinin on 12/3/17.
//  Copyright © 2017 Vadim Drobinin. All rights reserved.
//

import UIKit
import MessageUI

class ViewController: UIViewController {
  @IBOutlet weak var feedbackButton: UIButton! {
    didSet {
      feedbackButton.alpha = 0.8
    }
  }

  @IBOutlet weak var helpButton: UIButton! {
    didSet {
      helpButton.alpha = 0.8
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    // Hide the navigation bar on the this view controller
    self.navigationController?.setNavigationBarHidden(true, animated: animated)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    
    // Show the navigation bar on other view controllers
    self.navigationController?.setNavigationBarHidden(false, animated: animated)
  }
  
  @IBAction func sendEmailButtonTapped(_ sender: AnyObject) {
    let mailComposeViewController = configuredMailComposeViewController()
    if MFMailComposeViewController.canSendMail() {
      self.present(mailComposeViewController, animated: true, completion: nil)
    } else {
      self.showSendMailErrorAlert()
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}

extension ViewController: MFMailComposeViewControllerDelegate {
  
  func configuredMailComposeViewController() -> MFMailComposeViewController {
    let mailComposerVC = MFMailComposeViewController()
    mailComposerVC.mailComposeDelegate = self
    
    mailComposerVC.setToRecipients(["pornblockpro@gmail.com"])
    mailComposerVC.setSubject("Feedback for Porn Blocker Pro")
    mailComposerVC.setMessageBody("Write your feedback below this line:", isHTML: false)
    
    return mailComposerVC
  }
  
  func showSendMailErrorAlert() {
    print("Something went wrong!")
  }
  
  // MARK: MFMailComposeViewControllerDelegate
  func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
    controller.dismiss(animated: true, completion: nil)
  }
}

