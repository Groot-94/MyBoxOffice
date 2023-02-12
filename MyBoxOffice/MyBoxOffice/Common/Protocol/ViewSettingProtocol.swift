//
//  ViewSettingProtocol.swift
//  MyBoxOffice
//
//  Created by Groot on 2023/02/08.
//

import UIKit

protocol ViewSettingProtocol {
    func commonInit()
    func configureView()
    func configureSubViews()
    func configureLayouts()
}

extension ViewSettingProtocol {
    func commonInit() {
        configureView()
        configureSubViews()
        configureLayouts()
    }
    
    func configureView() {}
    func configureSubViews() {}
    func configureLayouts() {}
}
