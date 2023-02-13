//
//  SearchMovieViewController.swift
//  MyBoxOffice
//
//  Created by Groot on 2023/02/13.
//

import UIKit

final class SearchMovieViewController: UIViewController {
    var coodinator: Coordinator?
    private let viewModel: SearchMovieViewModelable
    
    init(coodinator: Coordinator? = nil, viewModel: SearchMovieViewModelable) {
        self.coodinator = coodinator
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
