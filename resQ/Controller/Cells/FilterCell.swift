//
//  FilterCell.swift
//  resQ
//
//  Created by sowmya yellapragada on 10/30/17.
//  Copyright © 2017 sowmya.yellapragada. All rights reserved.
//

import UIKit

protocol FilterDelegate:class{
    func clearSelectedFilters()
}
class FilterCell: UITableViewCell {

    @IBOutlet weak var selectedImg: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    
    weak var delegate:FilterDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func config(title:String, isSelected:Bool){
        titleLbl.text = title
        selectedImg.isHidden = !isSelected
    }
    
    @IBAction func clearTouch(_ sender: Any) {
        self.delegate?.clearSelectedFilters()
    }
    
}
