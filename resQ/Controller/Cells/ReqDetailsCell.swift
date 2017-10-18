//
//  ReqDetailsCell.swift
//  resQ
//
//  Created by sowmya yellapragada on 10/17/17.
//  Copyright © 2017 sowmya.yellapragada. All rights reserved.
//

import UIKit

class ReqDetailsCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource{

    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var authorLbl: UILabel!
    @IBOutlet weak var postedAtLbl: UILabel!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var detailsLbl: UILabel!
    @IBOutlet weak var viewsLbl: UILabel!
    @IBOutlet weak var commentsLbl: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBAction func shareTouch(_ sender: Any) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath)
        return cell
    }
    
    func config(){
        
    }
}
