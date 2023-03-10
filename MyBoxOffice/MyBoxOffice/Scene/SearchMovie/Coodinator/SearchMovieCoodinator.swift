//
//  SearchMovieCoodinator.swift
//  MyBoxOffice
//
//  Created by Groot on 2023/02/13.
//

import UIKit

final class SearchMovieCoodinator: Coordinator {
    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator]
    var navigationController: UINavigationController
    var viewModel: SearchMovieViewModelable
    
    init(parentCoordinator: Coordinator? = nil,
         childCoordinators: [Coordinator] = [Coordinator](),
         navigationController: UINavigationController,
         viewModel: SearchMovieViewModelable) {
        self.parentCoordinator = parentCoordinator
        self.childCoordinators = childCoordinators
        self.navigationController = navigationController
        self.viewModel = viewModel
    }
    
    func start() {
        let searchMovieViewController = SearchMovieViewController(coodinator: self,
                                                                  viewModel: viewModel)
        searchMovieViewController.coodinator = self
        navigationController.pushViewController(searchMovieViewController, animated: true)
    }
}

extension SearchMovieCoodinator {
    func showMovieInfo(movieCode: String) {
        let movieInfoCoodinator = MovieInfoCoodinator(parentCoordinator: self,
                                                      navigationController: navigationController,
                                                      viewModel: MovieInfoViewModel(movieCode: movieCode))
        childCoordinators.append(movieInfoCoodinator)
        movieInfoCoodinator.start()
    }
}
