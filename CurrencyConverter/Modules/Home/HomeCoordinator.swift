//
//  HomeCoordinator.swift
//  CurrencyConverter
//
//  Created by rabin on 19/07/2022.
//

import UIKit
import Combine

final class HomeCoordinator: BaseCoordinator {
    
    private let route: NavigationRoute
    
    private var bag = Set<AnyCancellable>()
    
    init(route: NavigationRoute) {
        self.route = route
    }
    
    override func start() {
        showConverter()
    }
    
    private func showConverter() {
        let view = ConverterView()
        let viewModel = ConverterViewModel()
        
        let controller = ConverterController(baseView: view, baseViewModel: viewModel)
        route.setRoot(controller)
    }
    
}
