//
//  MovieInfoView.swift
//  MyBoxOffice
//
//  Created by Groot on 2023/02/11.
//

import UIKit
import SnapKit

final class MovieInfoView: UIView {
    private let totalScrollview: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        
        return scrollView
    }()
    
    private let totalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        
        return stackView
    }()
    
    private let chapterAndValueStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 8
        
        return stackView
    }()
    
    private let chapterStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 8
        
        return stackView
    }()
    
    private let valueStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 8
        
        return stackView
    }()
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "photo")
        
        return imageView
    }()
    
    private let directorsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: UIFont.preferredFont(forTextStyle: .body).pointSize)
        label.setContentHuggingPriority(.required, for: .vertical)
        label.text = "감독"
        
        return label
    }()
    
    private let directorsValueLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.setContentHuggingPriority(.required, for: .vertical)
        label.text = ""
        
        return label
    }()
    
    private let productYearLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: UIFont.preferredFont(forTextStyle: .body).pointSize)
        label.setContentHuggingPriority(.required, for: .vertical)
        label.text = "제작년도"
        
        return label
    }()
    
    private let productYearValueLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.setContentHuggingPriority(.required, for: .vertical)
        label.text = ""
        
        return label
    }()
    
    private let openDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: UIFont.preferredFont(forTextStyle: .body).pointSize)
        label.setContentHuggingPriority(.required, for: .vertical)
        label.text = "개봉일"
        
        return label
    }()
    
    private let openDateValueLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.setContentHuggingPriority(.required, for: .vertical)
        label.text = ""
        
        return label
    }()
    
    private let showTimeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: UIFont.preferredFont(forTextStyle: .body).pointSize)
        label.setContentHuggingPriority(.required, for: .vertical)
        label.text = "상영시간"
        
        return label
    }()
    
    private let showTimeValueLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.setContentHuggingPriority(.required, for: .vertical)
        label.text = ""
        
        return label
    }()
    
    private let watchGradeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: UIFont.preferredFont(forTextStyle: .body).pointSize)
        label.setContentHuggingPriority(.required, for: .vertical)
        label.text = "관람등급"
        
        return label
    }()
    
    private let watchGradeValueLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.setContentHuggingPriority(.required, for: .vertical)
        label.text = ""
        
        return label
    }()
    
    private let nationsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: UIFont.preferredFont(forTextStyle: .body).pointSize)
        label.setContentHuggingPriority(.required, for: .vertical)
        label.text = "제작국가"
        
        return label
    }()
    
    private let nationsValueLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.setContentHuggingPriority(.required, for: .vertical)
        label.text = ""
        
        return label
    }()
    
    private let genresNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: UIFont.preferredFont(forTextStyle: .body).pointSize)
        label.setContentHuggingPriority(.required, for: .vertical)
        label.text = "장르"
        
        return label
    }()
    
    private let genresNameValueLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.setContentHuggingPriority(.required, for: .vertical)
        label.text = ""
        
        return label
    }()
    
    private let actorsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: UIFont.preferredFont(forTextStyle: .body).pointSize)
        label.text = "배우"
        
        return label
    }()
    
    private let actorsValueLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.numberOfLines = 0
        label.text = ""
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func configureItems(movieInfoModel: MovieInfoModel) {
        directorsValueLabel.text = movieInfoModel.directorsNames
        productYearValueLabel.text = movieInfoModel.productYear
        showTimeValueLabel.text = movieInfoModel.showTime + "분"
        openDateValueLabel.text = movieInfoModel.openDate
        watchGradeValueLabel.text = movieInfoModel.watchGradeNames
        nationsValueLabel.text = movieInfoModel.nationsNames
        genresNameValueLabel.text = movieInfoModel.genresNames
        actorsValueLabel.text = movieInfoModel.actorsNames
    }
    
    func configureImage(image: UIImage) {
        posterImageView.image = image
    }
}

extension MovieInfoView: ViewSettingProtocol {
    func configureView() {
        backgroundColor = .systemBackground
    }
    
    func configureSubViews() {
        addSubview(totalScrollview)
        totalScrollview.addSubview(totalStackView)
        [posterImageView, chapterAndValueStackView].forEach { totalStackView.addArrangedSubview($0) }
        [chapterStackView, valueStackView].forEach { chapterAndValueStackView.addArrangedSubview($0) }
        [
            directorsLabel,
            productYearLabel,
            openDateLabel,
            showTimeLabel,
            watchGradeLabel,
            nationsLabel,
            genresNameLabel,
            actorsLabel
        ].forEach { chapterStackView.addArrangedSubview($0) }
        [
            directorsValueLabel,
            productYearValueLabel,
            openDateValueLabel,
            showTimeValueLabel,
            watchGradeValueLabel,
            nationsValueLabel,
            genresNameValueLabel,
            actorsValueLabel
        ].forEach { valueStackView.addArrangedSubview($0) }
    }
    
    func configureLayouts() {
        totalScrollview.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        totalStackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
            make.width.equalToSuperview().inset(16)
        }
        posterImageView.snp.makeConstraints { make in
            make.height.equalTo(450)
        }
        valueStackView.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.7)
        }
    }
}
