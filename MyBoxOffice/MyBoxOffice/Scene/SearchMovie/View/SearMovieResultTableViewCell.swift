//
//  MovieTableViewCell.swift
//  MyBoxOffice
//
//  Created by Groot on 2023/02/13.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class SearMovieResultTableViewCell: UITableViewCell {
    private let disposeBag = DisposeBag()
    private var imageUrl = ""
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.setContentCompressionResistancePriority(.required, for: .horizontal)
        imageView.image = UIImage(named: "placeholder")
        
        return imageView
    }()
    
    private let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 8
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: UIFont.preferredFont(forTextStyle: .body).pointSize)
        label.setContentHuggingPriority(.required, for: .vertical)
        label.numberOfLines = 0
        
        return label
    }()
    
    private let directorLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .callout)
        label.tintColor = .systemGray6
        label.setContentHuggingPriority(.required, for: .vertical)
        
        return label
    }()
    
    private let userRatingLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: UIFont.preferredFont(forTextStyle: .caption1).pointSize)
        label.tintColor = .systemRed
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        ImageCacheManager.default.cancel(url: imageUrl)
        posterImageView.image = UIImage(named: "placeholder")
    }
    
    func configureItems(_ model: NaverMovieModel) {
        imageUrl = model.imageUrl
        titleLabel.text = model.movieName
        directorLabel.text = model.director
            .replacingOccurrences(of: "|", with: "/")
        userRatingLabel.text = "⭐️ " + model.userRating
        configurePosterImage()
    }
    
    private func configurePosterImage() {
        ImageCacheManager.default.requestImage(url: imageUrl)
            .subscribe { [weak self] image in
                self?.posterImageView.image = image
            }.disposed(by: disposeBag)
    }
}

extension SearMovieResultTableViewCell: ViewSettingProtocol {
    func configureSubViews() {
        contentView.addSubview(posterImageView)
        contentView.addSubview(verticalStackView)
        [titleLabel, directorLabel, userRatingLabel].forEach { verticalStackView.addArrangedSubview($0) }
    }
    
    func configureLayouts() {
        posterImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().inset(8)
            make.leading.equalToSuperview()
            make.height.greaterThanOrEqualTo(140)
            make.width.lessThanOrEqualTo(90)
        }
        verticalStackView.snp.makeConstraints { make in
            make.leading.equalTo(posterImageView.snp.trailing).offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.top.equalTo(posterImageView.snp.top).offset(16)
            make.bottom.equalTo(posterImageView.snp.bottom).inset(16)
        }
    }
}
