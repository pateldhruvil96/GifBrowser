//
//  GifTableViewCell.swift
//  GifBrowser
//
//  Created by Dhruvil Patel on 3/16/21.
//

import UIKit

class GifTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var gifImageView: UIImageView!
    @IBOutlet weak var borderLineView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        borderLineView.layer.cornerRadius = 10
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
