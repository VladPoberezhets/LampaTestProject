//
//  MoviewDetailsVC.swift
//  LampaTestProject
//
//  Created by Vlad Poberezhets on 24.10.2024.
//

import UIKit


final class MoviewDetailsVC: UIViewController {
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = .clear
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = true
        return view
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var videoView: VideoView = {
        let view = VideoView()
        view.layer.cornerRadius = 8
        return view
    }()
    
    private lazy var descriptionTitleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        view.text = String(localized: "DETAILS_DESCRIPTION_TITLE")
        view.numberOfLines = 1
        view.textAlignment = .left
        view.textColor = UIColor(named: "titleColor")
        return view
    }()
    
    private lazy var descriptionTextLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 14)
        view.numberOfLines = 0 // Ensure it can expand
        view.textColor = UIColor(named: "descriptionColor")
        view.textAlignment = .left
        return view
    }()
    
    private lazy var releaseDateLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 14)
        view.textColor = UIColor(named: "highlightedOrange")
        view.textAlignment = .left
        return view
    }()
    
    private var viewModel: MoviesViewModel
    private var index: Int
    
    init(viewModel: MoviesViewModel, index: Int) {
        self.viewModel = viewModel
        self.index = index
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = UIView()
        self.view.backgroundColor = UIColor(named: "backgroundColor")
        self.setupNavigationTitle(image: UIImage(named: "navigationImage"), title: String(localized: "HEADER_TITLE"))
        setupViews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let model = self.viewModel.movies?[self.index] {
            self.viewModel.getMoviesImage(imagePath: model.backdropPath ?? "") { image, error in
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else {
                        return
                    }
                    if error != nil {
                        self.setupContent(with: model, image: nil)
                        self.view.hideLoader()
                    } else if let loadedImage = image {
                        self.setupContent(with: model, image: loadedImage)
                        self.view.hideLoader()
                    }
                }
            }
        } else {
            self.setupUnavaliableView(title: String(localized: "UNAVALIBALE_VIEW_TITLE"), description: String(localized: "UNAVALIABLE_VIEW_DESCRIPTION"), image: UIImage(named: "warningImage"))
        }
    }
    
    private func setupContent(with model: MovieDTO, image: UIImage?) {
        let loadedImage = image == nil ? UIImage(named: "failedLoadImage") : image
        self.videoView.setup(image: loadedImage, title: model.title, rating: model.voteAverage)
        self.descriptionTextLabel.text = model.overview
        self.releaseDateLabel.text = "\(String(localized: "RELEASE_TITLE")) \(model.releaseDate?.transformDateString() ?? "Unknown")"
    }
    
    private func setupViews() {
        setupScrollView()
        setupContentView()
        setupVideoView()
        setupDescriptionTitleLabelView()
        setupDescriptionTextLabelView()
        setupReleaseDateLabelView()
    }
    
    private func setupScrollView() {
        self.view.addSubview(self.scrollView)
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            self.scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.scrollView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    private func setupContentView() {
        self.scrollView.addSubview(self.contentView)
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.contentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            self.contentView.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),
            self.contentView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor)
        ])
    }
    
    private func setupVideoView() {
        self.videoView.onVideoPlayClicked = { [weak self] movieName in
            DispatchQueue.main.async {
                if let name = movieName {
                    self?.showAlert(title: String(localized: "MOVIE_ALERT_TITLE"), message: name)
                } else {
                    self?.showAlert(title: String(localized: "ERROR_ALERT_TITLE"), message: String(localized: "ERROR_ALERT_DESCRIPTION"))
                }
            }
        }
        
        self.contentView.addSubview(self.videoView)
        self.videoView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.videoView.heightAnchor.constraint(equalToConstant: 193),
            self.videoView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.videoView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            self.videoView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16)
        ])
    }
    
    private func setupDescriptionTitleLabelView() {
        self.contentView.addSubview(self.descriptionTitleLabel)
        self.descriptionTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.descriptionTitleLabel.topAnchor.constraint(equalTo: self.videoView.bottomAnchor, constant: 24),
            self.descriptionTitleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            self.descriptionTitleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16)
        ])
    }
    
    private func setupDescriptionTextLabelView() {
        self.contentView.addSubview(self.descriptionTextLabel)
        self.descriptionTextLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.descriptionTextLabel.topAnchor.constraint(equalTo: self.descriptionTitleLabel.bottomAnchor, constant: 16),
            self.descriptionTextLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            self.descriptionTextLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16)
        ])
    }
    
    private func setupReleaseDateLabelView() {
        self.contentView.addSubview(self.releaseDateLabel)
        self.releaseDateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.releaseDateLabel.topAnchor.constraint(equalTo: self.descriptionTextLabel.bottomAnchor, constant: 16),
            self.releaseDateLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            self.releaseDateLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            self.releaseDateLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -16)
        ])
    }
}
