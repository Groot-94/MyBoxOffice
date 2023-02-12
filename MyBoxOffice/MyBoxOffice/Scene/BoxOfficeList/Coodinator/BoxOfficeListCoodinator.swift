//
//  BoxOfficeListCoodinator.swift
//  MyBoxOffice
//
//  Created by Groot on 2023/02/08.
//

import UIKit

final class BoxOfficeListCoodinator: Coordinator {
    weak var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator]
    var navigationController: UINavigationController
    
    init(parentCoordinator: Coordinator? = nil,
         childCoordinators: [Coordinator] = [Coordinator](),
         navigationController: UINavigationController) {
        self.parentCoordinator = parentCoordinator
        self.childCoordinators = childCoordinators
        self.navigationController = navigationController
    }
    
    func start() {
        let boxOfficeListViewController = BoxOfficeListViewController(coodinator: self,
                                                                      viewModel: BoxOfficeListViewModel())
        boxOfficeListViewController.coodinator = self
        navigationController.pushViewController(boxOfficeListViewController, animated: true)
    }
}

extension BoxOfficeListCoodinator {
    func showMovieInfo(movieCode: String) {
        let movieInfoCoodinator = MovieInfoCoodinator(parentCoordinator: self,
                                                      navigationController: navigationController,
                                                      viewModel: MovieInfoViewModel(movieCode: movieCode))
        childCoordinators.append(movieInfoCoodinator)
        childCoordinators.first?.start()
    }
}

