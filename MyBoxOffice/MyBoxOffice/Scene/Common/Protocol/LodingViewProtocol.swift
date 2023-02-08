//
//  LodingViewProtocol.swift
//  MyBoxOffice
//
//  Created by Groot on 2023/02/08.
//

import UIKit

protocol LodingViewProtocol {
    var backgroundView: UIView { get }
    var activityIndicatorView: UIActivityIndicatorView { get }
    
    func configureLodingView(superView: UIView)
    func showLodingView()
    func hideLodingView()
}

extension LodingViewProtocol {
    func showLodingView() {
        backgroundView.isHidden = false
        activityIndicatorView.startAnimating()
    }
    
    func hideLodingView() {
        backgroundView.isHidden = true
        activityIndicatorView.stopAnimating()
    }
    
    func configureLodingView(superView: UIView) {
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        superView.addSubview(backgroundView)
        superView.addSubview(activityIndicatorView)
        NSLayoutConstraint.activate([
            backgroundView.leftAnchor.constraint(equalTo: superView.leftAnchor),
            backgroundView.rightAnchor.constraint(equalTo: superView.rightAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: superView.bottomAnchor),
            backgroundView.topAnchor.constraint(equalTo: superView.topAnchor)])
        NSLayoutConstraint.activate([
            activityIndicatorView.centerYAnchor.constraint(equalTo: superView.centerYAnchor),
            activityIndicatorView.centerXAnchor.constraint(equalTo: superView.centerXAnchor)])
    }
}
