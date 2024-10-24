//
//  VideoView.swift
//  LampaTestProject
//
//  Created by Vlad Poberezhets on 24.10.2024.
//

import UIKit

final class VideoView: UIView {
    
    private lazy var backgroundImageView: UIImageView = {
         let view = UIImageView()
         view.contentMode = .scaleAspectFill
         view.layer.masksToBounds = true
         view.layer.cornerRadius = 8
         return view
     }()
    
    private lazy var infoStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.alignment = .center
        view.distribution = .fillEqually
        return view
    }()
    
    private lazy var ratingStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.alignment = .trailing
        view.spacing = 4
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        view.numberOfLines = 1
        view.textAlignment = .left
        view.textColor = .white
        return view
     }()
    
    private lazy var ratingLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 12)
        view.numberOfLines = 0
        view.textAlignment = .left
        view.textColor = .white
        return view
     }()
    
    private lazy var ratingImageView: UIImageView = {
         let view = UIImageView()
         view.image = UIImage(named: "ratingImage")
         view.contentMode = .scaleAspectFit
         view.clipsToBounds = true
         return view
     }()
    
    private lazy var actionButtonView: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(named: "playImage"), for: .normal)
        view.isEnabled = true
        view.addTarget(self, action: #selector(playAction), for: .touchUpInside)
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        let color: UIColor = UIColor(named: "gradientColor") ?? .black
        layer.colors = [color.cgColor, color.withAlphaComponent(0).cgColor]
        layer.startPoint = CGPoint(x: 0.5, y: 1.0)
        layer.endPoint = CGPoint(x: 0.5, y: 0.0)
        layer.locations = [NSNumber(floatLiteral: 0.0), NSNumber(floatLiteral: 1.0)]
        return layer
    }()
    
    private var movieName: String?
    
    var onVideoPlayClicked: ((_ movieName: String?) -> Void)?
    
    init() {
        super.init(frame: .zero)
        self.layer.cornerRadius = 8
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(image: UIImage?, title: String?, rating: Double?) {
        self.movieName = title
        self.backgroundImageView.image = image
        self.titleLabel.text = title
        self.ratingLabel.text = String(format: "%.1f", rating ?? 0)
    }
    
    private func setupViews() {
        setupBackgroundImageView()
        setupInfoStackView()
        setupTitleLabel()
        setupRatingStackView()
        setupRatingLabel()
        setupRatingImage()
        setupActionButonView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = backgroundImageView.bounds
    }
    
    private func setupBackgroundImageView() {
        backgroundImageView.layer.insertSublayer(gradientLayer, at: 0)
        
        self.addSubview(self.backgroundImageView)
        self.backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.backgroundImageView.topAnchor.constraint(equalTo: self.topAnchor),
            self.backgroundImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.backgroundImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.backgroundImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    private func setupInfoStackView() {
        self.backgroundImageView.addSubview(self.infoStackView)
        self.infoStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.infoStackView.bottomAnchor.constraint(equalTo: self.backgroundImageView.bottomAnchor, constant: -12),
            self.infoStackView.leadingAnchor.constraint(equalTo: self.backgroundImageView.leadingAnchor, constant: 12),
            self.infoStackView.trailingAnchor.constraint(equalTo: self.backgroundImageView.trailingAnchor, constant: -12)
        ])
    }
    
    private func setupTitleLabel() {
        self.infoStackView.addArrangedSubview(self.titleLabel)
    
    }
    
    private func setupRatingStackView() {
        self.infoStackView.addSubview(self.ratingStackView)
        self.ratingStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.ratingStackView.trailingAnchor.constraint(equalTo: self.infoStackView.trailingAnchor)
        ])
    }
    
    private func setupRatingLabel() {
        self.ratingStackView.addArrangedSubview(self.ratingLabel)
    
    }
    
    private func setupRatingImage() {
        self.ratingStackView.addArrangedSubview(self.ratingImageView)

    }
 
    private func setupActionButonView() {
        self.addSubview(self.actionButtonView)
        self.actionButtonView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            actionButtonView.topAnchor.constraint(equalTo: self.topAnchor),
            actionButtonView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            actionButtonView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            actionButtonView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    @objc private func playAction() {
        if let name = self.movieName {
            self.onVideoPlayClicked?(name)
        } else {
            self.onVideoPlayClicked?(nil)
        }
    }
}
