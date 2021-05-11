//
//  UIViewController+Extensions.swift
//  MatchiOSCode
//
//  Created by Aminjoni Abdullozoda on 5/9/21.
//

import UIKit

fileprivate var spinnerView : UIView?

extension UIViewController {
    
    /// Alert Display
    /// - Parameters:
    ///   - title: `String` Alert Title
    ///   - message: `String` Alert Messsage
    ///   - buttonTitle: `String` Alert Button Title
    func presentAlertView(title : String, message : String, buttonTitle : String) {
        DispatchQueue.main.async {
            let alertVC  = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let oKAction = UIAlertAction(title: buttonTitle, style: .cancel, handler: nil)
            alertVC.addAction(oKAction)
            self.present(alertVC, animated: true, completion: nil)
        }
    }
    
    /// Starting to loading activity indicator
    func showLoadingView(){
        
        spinnerView = UIView(frame: view.bounds)
        view.addSubview(spinnerView!)
        spinnerView!.backgroundColor = .systemBackground
        spinnerView!.alpha  = 0.8
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        spinnerView?.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false

        //Constrains
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        //Start Spinning
        activityIndicator.startAnimating()
    }
    
    /// Stop loading view
    func dismissLoadingView() {
        DispatchQueue.main.async {
            if let spinner = spinnerView {
                spinner.removeFromSuperview()
            }
        }
    }
}
