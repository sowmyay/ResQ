//
//  MakeReqController.swift
//  ResQ
//
//  Created by sowmya yellapragada on 10/8/17.
//  Copyright © 2017 sowmya.yellapragada. All rights reserved.
//

import UIKit

class MakeReqController: BaseController, UITextFieldDelegate, UITextViewDelegate {

    @IBOutlet weak var chooseBttn: UIButton!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var nameTxtFld: PaddingTextField!
    @IBOutlet weak var subTxtFld: PaddingTextField!
    @IBOutlet weak var contentTxtView: UITextView!
    
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelTouch(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func postTouch(_ sender: Any) {
    }
    
    @IBAction func chooseTouch(_ sender: Any) {
    }
    
    @objc func keyboardDidShow(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            //if self.view.frame.origin.y == 0{
                self.bottomConstraint.constant += keyboardSize.height
            //}
        }
        
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            //if self.view.frame.origin.y != 0{
                self.bottomConstraint.constant -= keyboardSize.height
            //}
        }
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
