//
//  DateSelectCoodinator.swift
//  MyBoxOffice
//
//  Created by Groot on 2023/02/12.
//

import UIKit

final class DateSelectCoodinator: Coordinator {
    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator]
    var navigationController: UINavigationController
    var viewModel: DateSelectViewModelable?
    
    init(parentCoordinator: Coordinator? = nil,
         childCoordinators: [Coordinator] = [Coordinator](),
         navigationController: UINavigationController,
         viewModel: DateSelectViewModelable) {
        self.parentCoordinator = parentCoordinator
        self.childCoordinators = childCoordinators
        self.navigationController = navigationController
        self.viewModel = viewModel
    }
    
    func start() {
        guard let viewModel = viewModel else { return }
        
        let dateSelectViewController = DateSelectViewController(coodinator: self,
                                                                viewModel: viewModel)
        navigationController.present(dateSelectViewController, animated: true)
    }
}
