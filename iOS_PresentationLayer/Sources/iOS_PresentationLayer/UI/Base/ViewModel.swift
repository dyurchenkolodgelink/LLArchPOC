//
//  ViewModel.swift
//  LodgeLink
//
//  Created by Dmytro Yurchenko on 2023-04-27.
//

import Foundation
import Combine
import DomainLayer

public typealias ViewModel = BaseViewModel & Fakeable

public class BaseViewModel: ObservableObject {
    let sideCar: ViewModelSideCar
    
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    public let id: UUID = .init()
    let serialWorkingQueue: DispatchQueue
    let concurrentWorkingQueue: DispatchQueue
    let requiredPermissions: Set<OrgPermission>
    var cancellableSet: Set<AnyCancellable> = []
    
    final var permissions: Set<OrgPermission> {
        []//sideCar.applicationSessionStore.authentication.permissions
    }
    
    init(
        requiredPermissions: Set<OrgPermission> = [],
        sideCar: ViewModelSideCar
    ) throws {
        self.requiredPermissions = requiredPermissions
        
        if requiredPermissions.satisfied(by: sideCar.permissions) {
            self.sideCar = sideCar
            
            let queueLabel = "com.lodgelink.\(String(describing: type(of: self)))"
            
            serialWorkingQueue = DispatchQueue(label: [queueLabel, "serialWorkingQueue"].joined(separator: "."))
            concurrentWorkingQueue = DispatchQueue(label: [queueLabel, "concurrentWorkingQueue"].joined(separator: "."))
            
            subscribePublishers()
        } else {
            throw AccessError.noPermission
        }
    }
    
    deinit {
//        Debug.log(.deinitialization([String(describing: type(of: self)), "has been deinitialized"].joined(separator: " ")))
    }
    
    func onViewLoaded() {
//        let viewModelClassName = String(describing: type(of: self))
//        
//        guard let viewName = AnalyticsTrackableViewModels(rawValue: viewModelClassName)?.viewName
//        else { return }
//        
//        let parameters: LogEventParameters = ["screen_name": viewName]
//            .mergingAllNew(prepareViewDidAppearAdditionalLogParameters())
//        
//        logViewDidAppearEvent(
//            event: ViewDidAppearLogEvent(
//                parameters: parameters
//            )
//        )
    }
    
//    func prepareViewDidAppearAdditionalLogParameters() -> LogEventParameters {
//        [:]
//    }
    
    func onViewAppeared() {}
    
    func refresh() {}
    
    func subscribePublishers() {
//        $errorMessage
//            .compactMap { $0 }
//            .sink { [unowned self] errorMessage in
//                //sideCar.analyticsLogger.log(error: errorMessage)
//            }
//            .store(in: &cancellableSet)
    }
    
//    func log(event: AnalyticsLogEvent) {
//        sideCar.analyticsLogger.log(event: event)
//    }
//    
//    func logViewDidAppearEvent(event: ViewDidAppearLogEvent) {
//        log(event: event)
//    }
}

extension BaseViewModel {
    func handleCompletion<F>(_ completion: Subscribers.Completion<F>) where F: Error {
        assert(Thread.isMainThread)
        
        switch completion {
        case let .failure(error):
            errorMessage = error.localizedDescription
            
        case .finished:
            break
        }
    }
}

extension BaseViewModel: Identifiable, Hashable {
    public static func == (lhs: BaseViewModel, rhs: BaseViewModel) -> Bool {
        lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
