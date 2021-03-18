//
//  SelectedViewController.swift
//  GifBrowser
//
//  Created by Dhruvil Patel on 3/17/21.
//

import UIKit

class SelectedViewController: BaseViewController {
    var label = String()
    var imageUrl = String()
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated:true )
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text  = label
        
        let url = URL(string: imageUrl)
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(with: url)
    }
}
