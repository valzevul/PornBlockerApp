//
//  VideoViewController.swift
//  PornBlocker
//
//  Created by Vadim Drobinin on 15/3/17.
//  Copyright © 2017 Vadim Drobinin. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation


class VideoViewController: UIViewController {

  @IBOutlet weak var playerView: UIView!
  var player: AVPlayer!
  var avpController: AVPlayerViewController?
  
  @IBAction func closeButtonPressed(_ sender: AnyObject) {
    self.dismiss(animated: true, completion: nil)
  }
  
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
      // Do any additional setup after loading the view.
    }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    let moviePath = Bundle.main.path(forResource: "tutorial", ofType: "mov")
    if let path = moviePath {
      let url = NSURL.fileURL(withPath: path)
      let item = AVPlayerItem(url: url)
      player = AVPlayer(playerItem: item)
      avpController = AVPlayerViewController()
      avpController?.player = self.player
      avpController?.view.frame = playerView.frame
      self.addChildViewController(avpController!)
      view.addSubview(avpController!.view)
      player.play()
    }
  }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
