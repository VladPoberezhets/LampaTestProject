//
//  MovieFavouriteListVC.swift
//  LampaTestProject
//
//  Created by Vlad Poberezhets on 23.10.2024.
//

import UIKit

final class MovieFavouriteListVC: UIViewController {
    
    override func loadView() {
        self.view = UIView()
        self.view.backgroundColor = UIColor(named: "background")
        self.setupNavigationTitle(image: UIImage(named: "navigationImage"), title: String(localized: "HEADER_TITLE"))
        self.setupUnavaliableView(title: String(localized: "UNAVALIBALE_VIEW_TITLE"), description: String(localized: "UNAVALIABLE_VIEW_DESCRIPTION"), image: UIImage(named: "warningImage"))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
