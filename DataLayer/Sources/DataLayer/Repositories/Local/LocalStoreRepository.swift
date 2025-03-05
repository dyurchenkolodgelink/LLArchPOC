//
//  LocalStoreRepository.swift
//  LodgeLink
//
//  Created by Dmytro Yurchenko on 2024-11-18.
//

import Foundation
import DomainLayer

final class LocalStoreRepository: LocalStoreRepositoryProtocol {
    let userDefaults: UserDefaults
    let encoder: JSONEncoder = JSONEncoder()
    let decoder: JSONDecoder = JSONDecoder()
    
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
    
    func store<T>(_ value: T, for key: StorageKey) throws where T: Encodable {
        let data = try encoder.encode(value)
        
        userDefaults.set(data, forKey: key.rawValue)
    }
    
    func getValue<T>(for key: StorageKey) throws -> T where T: Decodable {
        let data = userDefaults.data(forKey: key.rawValue) ?? Data()
        
        return try decoder.decode(T.self, from: data)
    }
    
    func removeValue(for key: StorageKey) {
        userDefaults.removeObject(forKey: key.rawValue)
    }
}
