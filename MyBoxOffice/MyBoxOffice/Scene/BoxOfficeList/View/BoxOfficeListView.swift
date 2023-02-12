//
//  BoxOfficeListView.swift
//  MyBoxOffice
//
//  Created by Groot on 2023/02/08.
//

import UIKit
import SnapKit

final class BoxOfficeListView: UIView {
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
    func configureSubViews() {
        addSubview(collectionView)
    }
    
    func configureLayouts() {
        collectionView.snp.makeConstraints { make in
            make.leading.top.trailing.bottom.equalToSuperview()
        }
    }
}
