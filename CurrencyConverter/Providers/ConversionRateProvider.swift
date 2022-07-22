//
//  ConversionRateProvider.swift
//  CurrencyConverter
//
//  Created by rabin on 20/07/2022.
//

import Foundation
import Combine

struct ConversionRate {
    var code: String
    var rate: Float
}

struct ConversionRateResponse: Decodable {
    
    var rates: [String: Float]
    
}

final class ConversionRateApiRepository: ApiRepository<ConversionRate> {
    
    let url = Environment.getUrl(for: .latestJson)
    
    override func fetch() {
        let queryUrl = url.appending("app_id", value: Environment.getAppId())
        
        cancellable = perfomrRequest(url: queryUrl, respnseType: ConversionRateResponse.self)
            .sink(receiveCompletion: { self.handleCompletion(result: $0) },
              receiveValue: { conversionResponse in
            let conversionRates = conversionResponse.rates.map({ ConversionRate(code: $0.key, rate: $0.value) })
            self.result.send(.success(conversionRates))
        })
    }
    
}
