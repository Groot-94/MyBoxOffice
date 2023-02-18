//
//  BoxOfficeListView.swift
//  MyBoxOffice
//
//  Created by Groot on 2023/02/08.
//

import UIKit
import SnapKit

final class BoxOfficeListView: UIView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: UIFont.preferredFont(forTextStyle: .title2).pointSize)
        label.text = "일별 박스오피스"
        
        return label
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(BoxOfficeCollectionViewCell.self,
                                forCellWithReuseIdentifier: "BoxOfficeCollectionViewCell")
        
        return collectionView
    }()
    
    var listCollectionView: UICollectionView {
        collectionView
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
}

extension BoxOfficeListView: ViewSettingProtocol {
    func configureView() {
        backgroundColor = .systemBackground
    }
    
    func configureSubViews() {
        addSubview(titleLabel)
        addSubview(collectionView)
    }
    
    func configureLayouts() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.centerX.equalToSuperview()
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
