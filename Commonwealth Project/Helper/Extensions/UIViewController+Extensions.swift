//
//  UIViewController+Extensions.swift
//  Commonwealth Project
//
//  Created by Nur Irfan Pangestu on 29/11/20.
//

import Foundation
import UIKit

extension UIViewController {
    
    func setupHideKeyboardWhenTappedAround() {
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action:  #selector(UIViewController.dismissThisKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissThisKeyboard() {
        view.endEditing(true)
    }
    
    func wrapInNavigationController() -> UINavigationController {
        return UINavigationController(rootViewController: self)
    }
    
    func setupTitleForNavigation(title: String) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.title = title
    }
    
    private class func instantiateControllerInStoryboard<T: UIViewController>(_ storyboard: UIStoryboard, identifier: String) -> T {
        return storyboard.instantiateViewController(withIdentifier: identifier) as! T
    }
    
    class func controllerInStoryboard(_ storyboard: UIStoryboard, identifier: String) -> Self {
        return instantiateControllerInStoryboard(storyboard, identifier: identifier)
    }
    
    class func controllerInStoryboard(_ storyboard: UIStoryboard) -> Self {
        return controllerInStoryboard(storyboard, identifier: nameOfClass)
    }
    
    class func controllerFromStoryboard(_ storyboard: Storyboard) -> Self {
        return controllerInStoryboard(UIStoryboard(name: storyboard.rawValue, bundle: nil), identifier: nameOfClass)
    }
}

enum Storyboard: String {
    case main = "Main"
    case login = "Login"
}
