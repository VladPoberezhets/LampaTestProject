//
//  UIView+Extension.swift
//  LampaTestProject
//
//  Created by Vlad Poberezhets on 23.10.2024.
//

import UIKit

extension UIView {

    private var activityIndicator: UIActivityIndicatorView? {
           get {
               return self.subviews.compactMap { $0 as? UIActivityIndicatorView }.first
           }
           set {
               if let indicator = newValue {
                   self.addSubview(indicator)
                   indicator.center = self.center
               } else {
                   activityIndicator?.removeFromSuperview()
               }
           }
       }

       func showLoader() {
           if activityIndicator == nil {
               DispatchQueue.main.async { [weak self] in
                   guard let self = self else { return }
                   let loader = UIActivityIndicatorView(style: .large)
                   loader.hidesWhenStopped = true
                   self.activityIndicator = loader
                   self.activityIndicator?.startAnimating()
               }
              
           }
       }

       func hideLoader() {
           if activityIndicator != nil {
               DispatchQueue.main.async { [weak self] in
                   guard let self = self else { return }
                   self.activityIndicator?.stopAnimating()
                   self.activityIndicator = nil
               }
           }
       }
}
