//
//  BaseViewController.swift
//  GifBrowser
//
//  Created by Dhruvil Patel on 3/17/21.
//

import UIKit
import Kingfisher

class BaseViewController: UIViewController {
    var button = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backButtonDesign()
    }
    func backButtonDesign(){
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        
        //adds shadow
        self.navigationController?.navigationBar.layer.masksToBounds = false
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.lightGray.cgColor
        self.navigationController?.navigationBar.layer.shadowOpacity = 0.2
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 5.0)
        self.navigationController?.navigationBar.layer.shadowRadius = 2
        
        //removes border line
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        
        //left button
        button.setImage(UIImage(named: "Left arrow"), for: .normal)
        button.setTitle("Back", for: .normal)
        button.tintColor = UIColor .black
        button.titleLabel?.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        button.sizeToFit()
        button.addTarget(self, action: #selector(self.backButtonAction), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
    }
    
    @objc func backButtonAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
}
