//
//  MovieInfoViewController.swift
//  MyBoxOffice
//
//  Created by Groot on 2023/02/09.
//

import UIKit
import RxSwift

final class MovieInfoViewController: UIViewController {
    weak var coodinator: MovieInfoCoodinator?
    private let viewModel: MovieInfoViewModelable
    private let disposeBag = DisposeBag()
  
    init(coodinator: MovieInfoCoodinator? = nil, viewModel: MovieInfoViewModelable) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        coodinator?.parentCoordinator?.childDidFinish(coodinator)
    }
}
