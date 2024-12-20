//
//  UIViewController+Extension.swift
//  LampaTestProject
//
//  Created by Vlad Poberezhets on 24.10.2024.
//

import UIKit

//MARK: VC alert extensions
extension UIViewController {
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    

}
//MARK: end

//MARK: Navigation bar extensions
extension UIViewController {
    func setupNavigationTitle(image: UIImage?, title: String) {
        let backButtonItem = UIBarButtonItem()
        backButtonItem.title = ""
        backButtonItem.tintColor = UIColor(named: "highlightedOrange")
        self.navigationItem.backBarButtonItem = backButtonItem
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.navigationItem.titleView = NavigationTitleView(image: image, title: title)
    }
}
//MARK: end

//MARK: Unavaliable view
extension UIViewController {
    func setupUnavaliableView(title: String, description: String, image: UIImage?) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            let unavaliableView = UnavaliableView(title: title, description: description, image: image)

            self.view.addSubview(unavaliableView)
            unavaliableView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                unavaliableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
                unavaliableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
                unavaliableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
                unavaliableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            ])
        }
    }
    
    func removeUnavaliableView() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.view.subviews.first(where: { $0 is UnavaliableView})?.removeFromSuperview()
        }
    }
}

//MARK: end
