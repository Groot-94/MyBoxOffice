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
        stackView.distribution = .fillProportionally
        
        return stackView
    }()
    
    private let rightVerticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        
        return stackView
    }()
    
    private let rankLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title2)
        label.setContentHuggingPriority(.required, for: .vertical)
        
        return label
    }()
    
    private let rankOldAndNewLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .footnote)
        label.setContentHuggingPriority(.defaultLow, for: .vertical)
        
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: UIFont.preferredFont(forTextStyle: .title3).pointSize)
        
        return label
    }()
    
    private let audienceLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .footnote)
        
        return label
    }()
    
    private let accessoryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.tintColor = .black
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        resetCellItems()
    }
    
    private func resetCellItems() {
        rankLabel.text = nil
        titleLabel.text = nil
        audienceLabel.text = nil
        rankOldAndNewLabel.text = nil
        rankOldAndNewLabel.textColor = .black
        rankOldAndNewLabel.font = .preferredFont(forTextStyle: .footnote)
    }
    
    func configureCellItems(dailyBoxOfficeModel: BoxOfficeModel ) {
        rankLabel.text = dailyBoxOfficeModel.rank
        rankOldAndNewLabel.text = convertRankOldAndNewLabel(dailyBoxOfficeModel.rankOldAndNew,
                                                            dailyBoxOfficeModel.rankIncrement)
        titleLabel.text = dailyBoxOfficeModel.movieName
        let audienceCount = dailyBoxOfficeModel.audienceCount.convertToDecimal
        let audienceAccumulate = dailyBoxOfficeModel.audienceAccumulate.convertToDecimal
        audienceLabel.text = "관객수 : 당일 \(audienceCount) / 총 \(audienceAccumulate)"
    }
    
    private func convertRankOldAndNewLabel(_ rankOldAndNew: RankOldAndNew, _ rankIncrement: String) -> String {
        switch rankOldAndNew {
        case .new:
            rankOldAndNewLabel.font = .boldSystemFont(ofSize: UIFont.preferredFont(forTextStyle: .footnote).pointSize)
            
            return "신작"
        case .old:
            if rankIncrement == "0" {
                return " -"
            } else if rankIncrement.contains("-") {
                rankOldAndNewLabel.textColor = .systemBlue
                return "↓ \(rankIncrement.filter { $0 != "-" })"
            }
            rankOldAndNewLabel.textColor = .systemRed
            
            return "↑ \(rankIncrement)"
        }
    }
}

extension BoxOfficeCollectionViewCell: ViewSettingProtocol {
    func configureView() {
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.withAlphaComponent(0.1).cgColor
        layer.cornerRadius = 20
    }
    
    func configureSubViews() {
        addSubview(totalStackView)
        [leftVerticalStackView, rightVerticalStackView, accessoryImageView]
            .forEach { totalStackView.addArrangedSubview($0) }
        [rankLabel, rankOldAndNewLabel].forEach { leftVerticalStackView.addArrangedSubview($0) }
        [titleLabel, audienceLabel].forEach { rightVerticalStackView.addArrangedSubview($0) }
    }
    
    func configureLayouts() {
        totalStackView.snp.makeConstraints { make in
            make.edges.equalTo(UIEdgeInsets(top: 16, left: 8, bottom: 16, right: 8))
        }
        leftVerticalStackView.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.1)
        }
        accessoryImageView.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.03)
        }
    }
}
