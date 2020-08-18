//
//  ContentNetworkUpdater.swift
//  Numbers
//
//  Created by Ilya on 8/18/20.
//  Copyright © 2020 Ilya Semenow. All rights reserved.
//

import Foundation

typealias DataUpdateHandler = (Result<[Number], Error>) -> ()

final class ContentNetworkUpdater {
    private let httpService: HttpService
    private let dataParser: NumbersParser
    
    private var dataUpdateCompletion: DataUpdateHandler?
    private weak var repeatTimer: Timer?
    private var repeatTimeIntervals: [TimeInterval] = [3, 5, 10, 20]
    private var repeatCount: Int = 0
    
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
    
    func updateData(_ completion: @escaping DataUpdateHandler) {
        dataUpdateCompletion?(.failure(ContentUpdateError.interruptWithOtherRequester))
        dataUpdateCompletion = completion

        startDataRequest()
    }
}

private extension ContentNetworkUpdater {
    enum ContentUpdateError: Error {
        case requestInProgress
        case noDataFromServer
        case interruptWithOtherRequester
    }
    
    func startDataRequest() {
        guard !isRequestActive else {
            dataUpdateCompletion?(.failure(ContentUpdateError.requestInProgress))
            return
        }
        
        isRequestActive = true
        
        repeatTimer?.invalidate()
        repeatTimer = nil
        
        httpService.requestAllNumber { [weak self] success, data in
            guard let self = self else { return }
            defer { self.isRequestActive = false }
            guard success else {
                DispatchQueue.main.async {
                    self.scheduleNextDataUpdate()
                }
                self.dataUpdateCompletion?(.failure(ContentUpdateError.noDataFromServer))
                return
            }
            
            self.repeatCount = 0
            let parsedNumbers = self.dataParser.parseNumbers(from: data)
            self.dataUpdateCompletion?(.success(parsedNumbers))
            self.dataUpdateCompletion = nil
        }
    }
    
    func executeDataUpdateCompletion(_ result: Result<[Number], Error>) {
        dataUpdateCompletion?(result)
        dataUpdateCompletion = nil
    }
    
    func scheduleNextDataUpdate() {
        guard repeatTimer == nil else { return }
        
        let repeatInterval = repeatTimeIntervals[safe: repeatCount] ?? repeatTimeIntervals.last ?? 60
        repeatCount += 1
        repeatTimer = NonBlockingTimer.scheduledTimer(withTimeInterval: repeatInterval, repeats: false, block: { [weak self] timer in
            self?.startDataRequest()
            self?.repeatTimer = nil
        })
    }
}

