//
//  BoxOfficeCollectionViewCell.swift
//  MyBoxOffice
//
//  Created by Groot on 2023/02/08.
//

import UIKit

final class BoxOfficeCollectionViewCell: UICollectionViewCell {
    private let totalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        
        return stackView
    }()
    
    private let leftVerticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        
        return stackView
    }()
    
    private let rightVerticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        
        return stackView
    }()
    
    private let rankStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        
        return stackView
    }()
    
    private let rankLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title1)
        
        return label
    }()
    
    private let rankUpAndDownImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private let rankOldAndNewLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title2)
        
        return label
    }()
    
    private let audienceLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        
        return label
    }()
    
    private let accessoryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func configureCellItems(dailyBoxOfficeModel: BoxOfficeModel ) {
        rankLabel.text = dailyBoxOfficeModel.rank
        rankOldAndNewLabel.text = convertRankOldAndNewLabel(dailyBoxOfficeModel.rankOldAndNew,
                                                            dailyBoxOfficeModel.rankIncrement)
        titleLabel.text = dailyBoxOfficeModel.movieName
        audienceLabel.text = "오늘 \(dailyBoxOfficeModel.audienceCount.convertToDecimal) / 총 \(dailyBoxOfficeModel.audienceAccumulate.convertToDecimal)"
    }
    
    private func convertRankOldAndNewLabel(_ rankOldAndNew: RankOldAndNew, _ rankIncrement: String) -> String {
        switch rankOldAndNew {
        case .new:
            return "신작"
        case .old:
            if rankIncrement == "0" {
                return " -"
            } else if rankIncrement.contains("-") {
                return "🔻\(rankIncrement.filter { $0 != "-" })"
            }
            
            return "🔺\(rankIncrement)"
        }
    }
}

extension BoxOfficeCollectionViewCell: ViewSettingProtocol {
    func configureSubViews() {
        contentView.addSubview(totalStackView)
        [leftVerticalStackView, rightVerticalStackView, accessoryImageView]
            .forEach { totalStackView.addArrangedSubview($0) }
        [rankLabel, rankStackView].forEach { leftVerticalStackView.addArrangedSubview($0) }
        [rankUpAndDownImageView, rankOldAndNewLabel].forEach { rankStackView.addArrangedSubview($0) }
        [titleLabel, audienceLabel].forEach { rightVerticalStackView.addArrangedSubview($0) }
    }
    
    func configureLayouts() {
        totalStackView.snp.makeConstraints { make in
            make.leading.top.trailing.bottom.equalToSuperview()
        }
        leftVerticalStackView.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.2)
        }
        accessoryImageView.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.03)
        }
    }
}
