//
//  HelpViewController.swift
//  PornBlocker
//
//  Created by Vadim Drobinin on 12/3/17.
//  Copyright © 2017 Vadim Drobinin. All rights reserved.
//

import UIKit
import MessageUI

extension HelpViewController: MFMailComposeViewControllerDelegate {
  
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

class HelpViewController: UIViewController {
    
  @IBOutlet weak var tableView: UITableView! {
    didSet {
      tableView.delegate = self
      tableView.dataSource = self
    }
  }
  
  var Helps = HelpParser.Helps
  var oppenedCategories: [Int] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.estimatedRowHeight = 80
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: Apperance.defaultSpace, right: 0)
    
    tableView.register(UINib(nibName: Constants.infoTableViewCellIdentifier, bundle: nil), forCellReuseIdentifier: Constants.infoTableViewCellIdentifier)
    tableView.register(UINib(nibName: Constants.plainTableViewCellIdentifier, bundle: nil), forCellReuseIdentifier: Constants.plainTableViewCellIdentifier)
    tableView.register(UINib(nibName: "SpaceTableViewCell", bundle: nil), forCellReuseIdentifier: "SpaceTableViewCell")
  }
  
  func numberOfElementsInSection(_ section: Int) -> Int {
    return numberOfElementsInSection(section, mechOppened: false)
  }
  
  func numberOfElementsInSection(_ section: Int, mechOppened: Bool) -> Int {
    if oppenedCategories.index(of: section) != nil || mechOppened  {
      return Helps[section].helps.count + 2
    }
    return 1
  }
}


// MARK: - UITableViewDataSource

extension HelpViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return Helps.count
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return numberOfElementsInSection(section)
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: RoundedTableViewCell
    
    switch indexPath.row {
    case 0:
      cell = titleCell(tableView, cellForRowAtIndexPath: indexPath)
    case 1:
      let isButton = (indexPath.section == 0) || (indexPath.section == 1)
      cell = acquiredCell(tableView, cellForRowAtIndexPath: indexPath, isButton: isButton)
    default:
      cell = helpCell(tableView, cellForRowAtIndexPath: indexPath)
    }
    
    let numberOfElements = numberOfElementsInSection(indexPath.section)
    
    if numberOfElements == 1 {
      cell.roundedType = .allRounded
    } else if indexPath.row == 0 {
      cell.roundedType = .topRounded
    } else if indexPath.row == numberOfElements - 1 {
      cell.roundedType = .bottomRounded
    } else {
      cell.roundedType = .none
    }
    
    return cell
  }
}

// MARK: - Cells

extension HelpViewController {
  func titleCell(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> RoundedTableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: Constants.plainTableViewCellIdentifier, for: indexPath) as! PlainTableViewCell
    
    cell.nameLabel.text = Helps[indexPath.section].name
    cell.selectionEnable = true
    
    return cell
  }
  
  func buttonClicked() {
    let mailComposeViewController = configuredMailComposeViewController()
    if MFMailComposeViewController.canSendMail() {
      self.present(mailComposeViewController, animated: true, completion: nil)
    } else {
      self.showSendMailErrorAlert()
    }
  }
  
  func acquiredCell(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath, isButton: Bool) -> RoundedTableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: Constants.infoTableViewCellIdentifier, for: indexPath) as! InfoTableViewCell
    cell.contentView.isUserInteractionEnabled = false
    cell.selectionStyle = .none
    cell.selectionEnable = false
    cell.nameLabel.text = "Info"
    cell.infoDescription = Helps[indexPath.section].description
    if isButton {
      cell.emailUsButton.isEnabled = true
      cell.emailUsButton.isHidden = false
      cell.emailUsButton.tag = indexPath.row
      cell.emailUsButton.addTarget(self, action: #selector(HelpViewController.buttonClicked), for: UIControlEvents.touchUpInside)
    } else {
      cell.emailUsButton.isEnabled = false
      cell.emailUsButton.isHidden = true
    }
    return cell
  }
  
  func helpCell(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> RoundedTableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: Constants.plainTableViewCellIdentifier, for: indexPath) as! PlainTableViewCell
    
    cell.nameLabel.text = Helps[indexPath.section].helps[indexPath.row - 2]
    cell.nameLabel.textColor = UIColor.contentAdditionalElementsColor
    cell.selectionEnable = false
    return cell
  }
}


// MARK: - UITableViewDelegate

extension HelpViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if let cell = tableView.cellForRow(at: indexPath) as? InfoTableViewCell {
      if cell.emailUsButton.isEnabled {
        buttonClicked()
      }
      return
    }
    
    let cell = tableView.cellForRow(at: indexPath) as! PlainTableViewCell
    
    tableView.beginUpdates()
    tableView.deselectRow(at: indexPath, animated: true)
    
    var indexPathes: [IndexPath] = []
    for i in 1..<numberOfElementsInSection(indexPath.section, mechOppened: true) {
      indexPathes.append(IndexPath(row: i, section: indexPath.section))
    }
    
    if let index = oppenedCategories.index(of: indexPath.section) {
      oppenedCategories.remove(at: index)
      tableView.deleteRows(at: indexPathes, with: UITableViewRowAnimation.fade)
      
      cell.setOpened(false, animated: true, complition: { () -> () in
        cell.roundedType = .allRounded
      })
      
    } else {
      oppenedCategories.append(indexPath.section)
      tableView.insertRows(at: indexPathes, with: UITableViewRowAnimation.fade)
      
      cell.roundedType = .topRounded
      cell.setOpened(true, animated: true)
    }
    
    tableView.endUpdates()
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    return UIView().fill() { $0.backgroundColor = UIColor.clear }
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return Apperance.defaultSpace
  }
}
