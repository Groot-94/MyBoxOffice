//
//  CustomTapBarView.swift
//  MyBoxOffice
//
//  Created by Groot on 2023/02/21.
//

import UIKit

protocol CustomTapBarViewDelegate: NSObject {
    func didTapCell(indexPath: IndexPath)
}

final class CustomTapBarView: UIView {
    var tabMenuList: [String]?
    weak var delegate: CustomTapBarViewDelegate?
    var indicatorViewLeadingConstraint: NSLayoutConstraint!
    var indicatorViewWidthConstraint: NSLayoutConstraint!
    private var currentSelectedIndexPath = IndexPath(row: 0, section: 0)
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isScrollEnabled = false
        collectionView.register(CustomTapBarCollectionViewCell.self,
                                forCellWithReuseIdentifier: "CustomTapBarCollectionViewCell")
        
        return collectionView
    }()
    
    private let indicatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        configureView()
        configureSubView()
        configureLayout()
    }
    
    private func configureView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBackground
    }
    
    private func configureSubView() {
        addSubview(collectionView)
        addSubview(indicatorView)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: [])
    }
    
    private func configureLayout() {
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: self.topAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 20)
        ])
        indicatorViewWidthConstraint = indicatorView.widthAnchor.constraint(equalToConstant: self.frame.width / 3)
        indicatorViewLeadingConstraint = indicatorView.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        NSLayoutConstraint.activate([
            indicatorViewWidthConstraint,
            indicatorViewLeadingConstraint,
            indicatorView.heightAnchor.constraint(equalToConstant: 3),
            indicatorView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}

extension CustomTapBarView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomTapBarCollectionViewCell",
                                                            for: indexPath) as? CustomTapBarCollectionViewCell
        else { return UICollectionViewCell() }
        
        cell.titleLabel.text = tabMenuList?[indexPath.row]
        
        return cell
    }
}

extension CustomTapBarView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard currentSelectedIndexPath != indexPath else { return }
        
        delegate?.didTapCell(indexPath: indexPath)
        currentSelectedIndexPath = indexPath
    }
}

extension CustomTapBarView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width / 3, height: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
