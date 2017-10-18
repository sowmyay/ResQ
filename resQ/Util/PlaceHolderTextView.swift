//
//  PlaceHolderTextView.swift
//  resQ
//
//  Created by sowmya yellapragada on 10/18/17.
//  Copyright © 2017 sowmya.yellapragada. All rights reserved.
//

import UIKit

protocol PHTextViewDelegate {
    func phTextViewDidEndEditing()
    func phTextViewShouldBeginEditing()
}

@IBDesignable class PlaceHolderTextView: UITextView , UITextViewDelegate{

    @IBInspectable var placeholder:String = "Please describe what kind of help you need as clearly as possible. For example, if you are requesting food, tell us how many are with you and what you need. "{
        didSet{
            if self.text == ""{
                self.text = placeholder
            }
        }
    }
    var phdelegate: PHTextViewDelegate?
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == ""{
            textView.text = placeholder
        }
        self.phdelegate?.phTextViewDidEndEditing()
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if textView.text == placeholder{
            textView.text = ""
        }
        self.phdelegate?.phTextViewShouldBeginEditing()
        return true
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
