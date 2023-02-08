//
//  BoxOfficeListCoodinator.swift
//  MyBoxOffice
//
//  Created by Groot on 2023/02/08.
//

import UIKit

final class BoxOfficeListCoodinator: Coordinator {
    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator]
    var navigationController: UINavigationController
    
    init(parentCoordinator: Coordinator? = nil, childCoordinators: [Coordinator] = [Coordinator](), navigationController: UINavigationController) {
        self.parentCoordinator = parentCoordinator
        self.childCoordinators = childCoordinators
        self.navigationController = navigationController
    }
    
    func start() {
        let boxOfficeListViewController = BoxOfficeListViewController(coodinator: self, viewModel: BoxOfficeListViewModel())
        navigationController.pushViewController(boxOfficeListViewController, animated: true)
    }
    
    func showMovieDetail(MovieCode: String) {}
}

