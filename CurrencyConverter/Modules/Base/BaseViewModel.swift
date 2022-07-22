//
//  BaseViewModel.swift
//  CurrencyConverter
//
//  Created by rabin on 19/07/2022.
//

import Foundation
import Combine

/// protocol for app route
protocol AppRoutable {}

/// The baseViewModel for every viewModel
class BaseViewModel {

    /// The subcription cleanup bag
    var bag: Set<AnyCancellable>

    /// Routes trigger
    var trigger: PassthroughSubject<AppRoutable, Never>
    
    /// The initializer
    init() {
        self.bag = Set<AnyCancellable>()
        self.trigger = PassthroughSubject<AppRoutable, Never>()
    }
    
    deinit {
        debugPrint("De-Initialized ViewModel --> \(String(describing: self))")
    }
}
