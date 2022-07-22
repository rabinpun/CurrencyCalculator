//
//  ApiRepository.swift
//  CurrencyConverter
//
//  Created by rabin on 22/07/2022.
//

import Foundation
import Combine

protocol DataFetcher {
    associatedtype ResultType
    
    var result: PassthroughSubject<Result<[ResultType], Error>,Never> { get }
    func fetch()
}


class ApiRepository<T>: DataFetcher {
    
    typealias ResultType = T

    var result = PassthroughSubject<Result<[ResultType], Error>, Never>()
    var cancellable: AnyCancellable?
    
    let urlSession: URLSession
    
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func fetch() {
    }
    
    func perfomrRequest<O: Decodable>(url: URL, respnseType: O.Type) -> AnyPublisher<O,Error> {
        urlSession
            .dataTaskPublisher(for: url)
            .tryMap() { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse,
                    httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                    }
                return element.data
                }
            .decode(type: O.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func handleCompletion(result: Subscribers.Completion<Error>) {
        switch result {
        case .finished:
            debugPrint("Success")
        case .failure(let error):
            self.result.send(.failure(error))
        }
    }
    
}
