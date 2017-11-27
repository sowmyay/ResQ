//
//  NotifController.swift
//  resQ
//
//  Created by sowmya yellapragada on 10/13/17.
//  Copyright © 2017 sowmya.yellapragada. All rights reserved.
//

import UIKit

class NotifController: UIViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    @IBOutlet weak var messagesBttn: UIButton!
    @IBOutlet weak var notifsBttn: UIButton!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var messgaesView: UIView!
    @IBOutlet weak var notifsView: UIView!
    var isNotifsView: Bool = true
    var greyishBrown = UIColor(red: 78/255.0, green: 78/255.0, blue: 78/255.0, alpha: 1.0)
    var warmGrey = UIColor(red: 141/255.0, green: 141/255.0, blue: 141/255.0, alpha: 1.0)
    var embeddedPageVC = UIPageViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func messagesTouch(_ sender: Any) {
        if isNotifsView{
            isNotifsView = false
            messagesBttn.setTitleColor(greyishBrown, for: .normal)
            notifsView.isHidden = true
            messgaesView.isHidden = false
            notifsBttn.setTitleColor(warmGrey, for: .normal)
            changePage(UIPageViewControllerNavigationDirection.forward, index: 1)
        }
    }
    
    @IBAction func notifsTouch(_ sender: Any) {
        if !isNotifsView{
            isNotifsView = true
            notifsBttn.setTitleColor(greyishBrown, for: .normal)
            notifsView.isHidden = false
            messgaesView.isHidden = true
            messagesBttn.setTitleColor(warmGrey, for: .normal)
            changePage(UIPageViewControllerNavigationDirection.reverse, index: 0)
        }
    }
    
    //MARK:PageViewController DataSource
    func changePage(_ direction: UIPageViewControllerNavigationDirection, index:Int){
        let viewController = getViewControllerAtIndex(index) as! NotifPageController
        viewController.isNotifsView = (index == 0)
        embeddedPageVC.setViewControllers([viewController], direction: direction, animated: true, completion: nil)
    }
    
    func getViewControllerAtIndex(_ index: NSInteger) -> UIViewController
    {
        let contentVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NotifPageController") as! NotifPageController
        contentVC.pageIndex = index
        contentVC.isNotifsView = isNotifsView
        return contentVC
    }
    
    //MARK: PageController Delegate Method
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        var index: Int = 0
        index = (viewController as! NotifPageController).pageIndex
        
        if index == 0 {
            return nil
        }
        index -= 1
        
        return getViewControllerAtIndex(index)
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        var index: Int = 0
        index = (viewController as! NotifPageController).pageIndex
        
        if (index == 1) {
            return nil
        }
        index += 1
        
        return getViewControllerAtIndex(index)
    }
    
    
//    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
//
//        if (completed) {
//        }
//        else {
//            return
//        }
//    }
    
    //MARK: Segue Callbacks
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let vc = segue.destination as? UIPageViewController
            , segue.identifier == "EmbedPageSegue" {
            embeddedPageVC = vc
            embeddedPageVC.delegate = self
            embeddedPageVC.dataSource = self
            self.embeddedPageVC.setViewControllers([self.getViewControllerAtIndex(isNotifsView ? 0 : 1)] as [UIViewController], direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: nil)
        }
    }

}
