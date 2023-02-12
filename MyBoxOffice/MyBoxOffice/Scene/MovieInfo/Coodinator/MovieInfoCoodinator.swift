//
//  MovieInfoCoodinator.swift
//  MyBoxOffice
//
//  Created by Groot on 2023/02/09.
//

import UIKit

final class MovieInfoCoodinator: Coordinator {
    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator]
    var navigationController: UINavigationController
    var viewModel: MovieInfoViewModelable?
    
    init(parentCoordinator: Coordinator? = nil,
         childCoordinators: [Coordinator] = [Coordinator](),
         navigationController: UINavigationController,
         viewModel: MovieInfoViewModelable) {
        self.parentCoordinator = parentCoordinator
        self.childCoordinators = childCoordinators
        self.navigationController = navigationController
        self.viewModel = viewModel
    }
    
    func start() {
        guard let viewModel = viewModel else { return }
        
        let movieInfoViewController = MovieInfoViewController(coodinator: self,
                                                              viewModel: viewModel)
        movieInfoViewController.coodinator = self
        navigationController.pushViewController(movieInfoViewController, animated: true)
    }
}
