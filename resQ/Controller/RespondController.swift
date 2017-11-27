//
//  RespondController.swift
//  resQ
//
//  Created by sowmya yellapragada on 11/15/17.
//  Copyright © 2017 sowmya.yellapragada. All rights reserved.
//

import UIKit
protocol RespondToDelegate {
    func respondSuccess()
}
class RespondController: BaseController, UITextFieldDelegate,  UITextViewDelegate{

    var requestId:Int?
    var heightIncreased:Bool = false
    var delegate:RespondToDelegate?
    
    @IBOutlet weak var contentTxtView: PlaceHolderTextView!
    @IBOutlet weak var nameTxtFld: PaddingTextField!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(MakeReqController.keyboardDidShow), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(MakeReqController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        view.endEditing(true)
        NotificationCenter.default.removeObserver(NSNotification.Name.UIKeyboardDidShow)
        NotificationCenter.default.removeObserver(NSNotification.Name.UIKeyboardWillHide)
    }
    
    @IBAction func cancelTouch(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func respondTouch(_ sender: Any) {
        if validityCheck(){
            respond()
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        let phTextView = textView as! PlaceHolderTextView
        if textView.text == ""{
            textView.text = phTextView.placeholder
        }
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        let phTextView = textView as! PlaceHolderTextView
        if textView.text == phTextView.placeholder{
            textView.text = ""
        }
        return true
    }
    
    @objc func keyboardDidShow(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if !heightIncreased{
                heightIncreased = true
                self.bottomConstraint.constant += keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if heightIncreased{
                heightIncreased = false
                self.bottomConstraint.constant -= keyboardSize.height
            }
        }
    }
    
    func validityCheck() -> Bool{
        var status = 0
        if let _ = nameTxtFld.text{
            status += 1
        }
        if let text = contentTxtView.text, text != contentTxtView.placeholder{
            status += 1
        }
        return (status == 2 ? true : false)
    }
    
    func respond(){
    }

}
