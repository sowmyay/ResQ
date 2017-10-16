//
//  RequestHeaderCell.swift
//  resQ
//
//  Created by sowmya yellapragada on 10/13/17.
//  Copyright © 2017 sowmya.yellapragada. All rights reserved.
//

import UIKit
import AlamofireImage


class RequestHeaderCell: UITableViewCell {

    @IBOutlet weak var disasterImage: UIImageView!
    @IBOutlet weak var disasterLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func sortOrderTouch(_ sender: Any) {
    }
    
    func config(image:String, title:String){
        if let imageURL = URL(string:image){
            disasterImage.af_setImage(withURL: imageURL)
        }
        disasterLbl.text = title
    }
}
