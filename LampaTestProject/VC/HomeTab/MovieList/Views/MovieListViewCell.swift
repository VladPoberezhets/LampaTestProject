//
//  MovieListViewCell.swift
//  LampaTestProject
//
//  Created by Vlad Poberezhets on 23.10.2024.
//

import UIKit

final class MovieListViewCell: UICollectionViewCell {
    
    static let identifier = "MovieListViewCell"
    
    private lazy var cellContentView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.isLayoutMarginsRelativeArrangement = true
        view.alignment = .top
        view.distribution = .equalSpacing
        view.spacing = 20
        return view
    }()
    
    private lazy var cellInfoView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.alignment = .leading
        view.clipsToBounds = true
        view.isLayoutMarginsRelativeArrangement = true
        view.spacing = 12
        return view
    }()

    private lazy var imageView: UIImageView = {
         let view = UIImageView()
         view.contentMode = .scaleAspectFit
         view.clipsToBounds = true
         view.layer.cornerRadius = 10
         return view
     }()
     
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        view.numberOfLines = 0
        view.textAlignment = .left
        view.textColor = UIColor(named: "titleColor")
        return view
     }()
    
    private lazy var descriptionLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 12)
        view.numberOfLines = 0
        view.textColor = UIColor(named: "descriptionColor")
        view.textAlignment = .left
        return view
    }()
    
    private lazy var releaseDateLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 12)
        view.textColor = UIColor(named: "highlightedOrange")
        view.textAlignment = .left
        return view
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.image = nil
        self.titleLabel.text = nil
        self.descriptionLabel.text = nil
        self.releaseDateLabel.text = nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.layer.cornerRadius = 12
        self.clipsToBounds = true
        self.setupViews()
    }
     
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
    
    private func setupViews() {
        self.setupContentView()
        self.setupImageView()
        
        self.cellContentView.addArrangedSubview(self.cellInfoView)
        
        self.cellInfoView.addArrangedSubview(self.titleLabel)
        self.cellInfoView.addArrangedSubview(self.descriptionLabel)
        self.cellInfoView.addArrangedSubview(self.releaseDateLabel)
    }
     
    private func setupContentView() {
        self.addSubview(self.cellContentView)
        self.cellContentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.cellContentView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.cellContentView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            self.cellContentView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            self.cellContentView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20)
        ])
    }
    
    private func setupImageView() {
        self.cellContentView.addArrangedSubview(self.imageView)
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.imageView.widthAnchor.constraint(equalToConstant: 128),
            self.imageView.heightAnchor.constraint(equalToConstant: 188)
        ])
    }
    
    func setup(index: Int, viewModel: MoviesViewModel) {
        guard let model = viewModel.movies?[index] else {
            return
        }
        titleLabel.text = model.title
        descriptionLabel.text = model.overview
        releaseDateLabel.text = "\(String(localized: "RELEASE_TITLE")) \(model.releaseDate?.transformDateString() ?? "Unknown")"
        self.imageView.showLoader()
        if let path = model.posterPath {
            viewModel.getMoviesImage(imagePath: path, completion: { [weak self] image, error in
                DispatchQueue.main.async {
                    guard let self = self else {
                        return
                    }
                    if error != nil {
                        self.imageView.image = UIImage(named: "failedLoadImage")
                        self.imageView.hideLoader()
                    } else if let loadedImage = image {
                        self.imageView.image = loadedImage
                        self.imageView.hideLoader()
                    }
                }
            })
        }
        self.layoutSubviews()
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let attributes = super.preferredLayoutAttributesFitting(layoutAttributes)
        attributes.bounds.size.width = self.bounds.width
        return attributes
    }
}
