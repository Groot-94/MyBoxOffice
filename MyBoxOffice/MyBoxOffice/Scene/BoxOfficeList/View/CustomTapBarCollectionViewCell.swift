//
//  CustomTapCollectionViewCell.swift
//  MyBoxOffice
//
//  Created by Groot on 2023/02/21.
//

import UIKit

final class CustomTapBarCollectionViewCell: UICollectionViewCell {
    let titleLabel: UILabel =  {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .lightGray
        
        return label
    }()
    
    override var isSelected: Bool {
        didSet{
            self.titleLabel.textColor = isSelected ? .black : .lightGray
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        configureSubview()
        configureLayout()
    }
    
    private func configureSubview() {
        addSubview(titleLabel)
    }
    
    private func configureLayout() {
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}
