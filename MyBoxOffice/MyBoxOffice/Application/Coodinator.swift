//
//  Coodinator.swift
//  MyBoxOffice
//
//  Created by Groot on 2023/02/08.
//

import UIKit

protocol Coordinator: AnyObject {
    var parentCoordinator: Coordinator? { get set }
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
    func childDidFinish(_ child: Coordinator?)
}

extension Coordinator {
    func childDidFinish(_ child: Coordinator?) {
        childCoordinators = childCoordinators.filter { $0 !== child }
    }
}

final class MainCoordinator: Coordinator {
    weak var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController : UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let boxOfficeListCoodinator = BoxOfficeListCoodinator(parentCoordinator: self,
                                                              navigationController: navigationController,
                                                              viewModel: BoxOfficeListViewModel())
        childCoordinators.append(boxOfficeListCoodinator)
        childCoordinators.first?.start()
    }
}
