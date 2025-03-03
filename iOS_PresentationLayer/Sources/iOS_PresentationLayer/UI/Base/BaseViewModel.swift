//
//  BaseViewModel.swift
//  iOS_PresentationLayer
//
//  Created by Dmytro Yurchenko on 2025-02-03.
//

import Foundation
import Combine
import DomainLayer

typealias ViewModel = BaseViewModel & Fakeable


class BaseViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    var cancellableSet: Set<AnyCancellable> = []
}
