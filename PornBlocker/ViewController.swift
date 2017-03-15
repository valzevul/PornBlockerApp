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
    if !UserDefaults.standard.bool(forKey: "notFirstLaunch") {
      UserDefaults.standard.set(true, forKey: "notFirstLaunch")
      performSegue(withIdentifier: "showTutorial", sender: nil)
    }
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    let reloader = RestrictionsFetcher()
    reloader.getNewFiles()
    // Hide the navigation bar on the this view controller
    self.navigationController?.setNavigationBarHidden(true, animated: animated)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    
    // Show the navigation bar on other view controllers
    self.navigationController?.setNavigationBarHidden(false, animated: animated)
  }
  
  func sendEmail() {
    let mailComposeViewController = configuredMailComposeViewController()
    if MFMailComposeViewController.canSendMail() {
      self.present(mailComposeViewController, animated: true, completion: nil)
    } else {
      self.showSendMailErrorAlert()
    }
  }
  
  func openAppStore() {
    let appID = 1214411593
    let urlStr = "itms-apps://itunes.apple.com/app/viewContentsUserReviews?id=\(appID)"
    UIApplication.shared.openURL(URL(string: urlStr)!)
  }
  
  @IBAction func sendEmailButtonTapped(_ sender: AnyObject) {
    let alert = UIAlertController(title: "Send Feedback", message: "Are you happy with Porn Blocker Pro?", preferredStyle: UIAlertControllerStyle.alert)
    alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.cancel, handler: { (action) in
      if action.style == .cancel {
        self.openAppStore()
      } else {
        self.sendEmail()
      }
    }))
    alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.default, handler: { (action) in
      if action.style == .cancel {
        self.openAppStore()
      } else {
        self.sendEmail()
      }
    }))
    self.present(alert, animated: true, completion: nil)
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

