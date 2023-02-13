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
    var viewModel: BoxOfficeViewModelable
    
    init(parentCoordinator: Coordinator? = nil,
         childCoordinators: [Coordinator] = [Coordinator](),
         navigationController: UINavigationController,
         viewModel: BoxOfficeViewModelable) {
        self.parentCoordinator = parentCoordinator
        self.childCoordinators = childCoordinators
        self.navigationController = navigationController
        self.viewModel = viewModel
    }
    
    func start() {
        let boxOfficeListViewController = BoxOfficeListViewController(coodinator: self,
                                                                      viewModel: viewModel)
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
        movieInfoCoodinator.start()
    }
    
    func showDateSelect(currentDate: Date) {
        let dateSelectViewModel = DateSelectViewModel(targetDate: currentDate)
        let dateSelectCoodinator = DateSelectCoodinator(parentCoordinator: self,
                                                        navigationController: navigationController,
                                                        viewModel: dateSelectViewModel)
        dateSelectViewModel.delegate = viewModel as? DateSelectViewModelDelegate
        childCoordinators.append(dateSelectCoodinator)
        dateSelectCoodinator.start()
    }
    
    func showSearchMovie() {
        let searchMovieCoodinator = SearchMovieCoodinator(parentCoordinator: self,
                                                          navigationController: navigationController,
                                                          viewModel: SearchMovieViewModel())
        childCoordinators.append(searchMovieCoodinator)
        searchMovieCoodinator.start()
    }
}

