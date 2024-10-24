//
//  MovieListVC.swift
//  LampaTestProject
//
//  Created by Vlad Poberezhets on 23.10.2024.
//

import UIKit

final class MovieListVC: UIViewController {
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 150, height: 200)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        
        let view = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        view.contentInsetAdjustmentBehavior = .always
        view.backgroundColor = UIColor(named: "backgroundColor")
        view.refreshControl = UIRefreshControl()
        view.refreshControl?.addTarget(self, action: #selector(refreshAction), for: .valueChanged)
        view.delegate = self
        view.dataSource = self
        view.register(MovieListViewCell.self, forCellWithReuseIdentifier: MovieListViewCell.identifier)
        (view.collectionViewLayout as? UICollectionViewFlowLayout)?.estimatedItemSize = UICollectionViewFlowLayout.automaticSize

        return view
    }()
    
    private var viewModel: MoviesViewModel
    
    var onMovieSelected: (() -> Void)?
    
    init(viewModel: MoviesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = UIView()
        self.view.backgroundColor = UIColor(named: "backgroundColor")
        self.setupNavigationTitle(image: UIImage(named: "navigationImage"), title: String(localized: "HEADER_TITLE"))
        setupCollectionView()
        self.getMoviesList()
    }
    
    private func setupCollectionView() {
        self.view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    private func getMoviesList() {
        guard viewModel.movies?.isEmpty ?? true else { return }
        self.view.showLoader()
        viewModel.getMoviesList { [weak self] error in
            DispatchQueue.main.async { [weak self] in
                guard let self = self, error == nil else {
                    self?.view.hideLoader()
                    self?.showAlert(title: String(localized: "ERROR_ALERT_TITLE"), message: String(localized: "ERROR_ALERT_DESCRIPTION"))
                    return
                }
                self.collectionView.reloadData()
                self.view.hideLoader()
            }
            
        }
    }
    
    @objc private func refreshAction() {
        getMoviesList()
        self.collectionView.refreshControl?.endRefreshing()
    }
}

extension MovieListVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.movies?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieListViewCell.identifier, for: indexPath) as? MovieListViewCell else {
            return UICollectionViewCell()
        }

        cell.setup(index: indexPath.row, viewModel: self.viewModel)
        return cell
    }
    
}

extension MovieListVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.size.width - 32
        return CGSize(width: width, height: 0)
    }
     
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
         return 20
     }
}

extension MovieListVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.viewModel.setSelectedMovie(index: indexPath.row)
        self.onMovieSelected?()
    }
}
