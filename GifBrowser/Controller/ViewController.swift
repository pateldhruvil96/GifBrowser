//
//  ViewController.swift
//  GifBrowser
//
//  Created by Dhruvil Patel on 3/16/21.
//

import UIKit
import SwiftyJSON
import Kingfisher

class ViewController: UIViewController {
    
    var gifData = [String]()
    var titleData = [String]()
    private let fireworkController = ClassicFireworkController()
    @IBOutlet weak var startButton :UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startButton.layer.cornerRadius = 15
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    @IBAction func startButtonAction(_ sender: UIButton) {
        self.perform(#selector(moveToNextVC),with: nil,afterDelay: 0.3)
        self.fireworkController.addFireworks(count: 3, sparks: 8, around: startButton)
    }
    @objc func moveToNextVC(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "GifViewController") as! GifViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

