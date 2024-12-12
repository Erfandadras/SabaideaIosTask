//
//  UserManager.swift
//  
//
//  Created by Erfan on 8/21/23.
//

import Foundation

final class UserManager: NSObject {
    static let shared = UserManager()
    
    let manager = UserDefaults.standard
    
    var userId: String? {
        get {
            return manager[#function]
        }
        set {
            manager[#function] = newValue
        }
    }
    
    var email: String? {
        get {
            return manager[#function]
        }
        set {
            manager[#function] = newValue
        }
    }
    
    //TODO: - with using login and signup remove default token
    var token: String? {
        get {
            return manager[#function] ?? API.token
        }
        set {
            manager[#function] = newValue
        }
    }

    var isUserLoggedIn: Bool {
        get { manager[#function] ?? false }
        set { manager[#function] = newValue }
    }
    
    var language: String {
        get { manager[#function] ?? "en_US" }
        set { manager[#function] = newValue}
    }
    
    // MARK: - Methods
    func deleteUser() {
        let dictionary = manager.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            manager.removeObject(forKey: key)
        }
    }
    
    override private init() {}
    
}
