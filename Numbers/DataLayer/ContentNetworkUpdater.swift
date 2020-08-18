//
//  ContentNetworkUpdater.swift
//  Numbers
//
//  Created by Ilya on 8/18/20.
//  Copyright © 2020 Ilya Semenow. All rights reserved.
//

import Foundation

final class ContentNetworkUpdater {
    private let httpService: HttpService
    private let dataParser: NumbersParser
    
    init(
        httpService: HttpService,
        dataParser: NumbersParser
    ) {
        self.httpService = httpService
        self.dataParser = dataParser
    }
    
    private var isRequestActive: Bool = false
}

extension ContentNetworkUpdater: ContentUpdater {
    var isUpdateActive: Bool { isRequestActive }
    
    func updateData(_ completion: @escaping (Result<[Number], Error>) -> ()) {
        guard !isRequestActive else { return completion(.failure(ContentUpdateError.requestInProgress)) }
        
        httpService.requestAllNumber { [weak self] success, data in
            guard let self = self else { return }
            guard success else { return completion(.failure(ContentUpdateError.noDataFromServer)) }
            
            let parsedNumbers = self.dataParser.parseNumbers(from: data)
            completion(.success(parsedNumbers))
        }
    }
}

private extension ContentNetworkUpdater {
    enum ContentUpdateError: Error {
        case requestInProgress
        case noDataFromServer
    }
}

