//
//  UserManager.swift
//  OneDirection
//
//  Created by Ashish Nautiyal on 3/8/19.
//  Copyright © 2019 Ashish  Nautiyal. All rights reserved.
//

import Foundation
struct UserManager {
    func getUserPhone()-> String?{
        return UserDefaults.standard.string(forKey: "phone")
    }
    func getUserId()-> String?{
        return UserDefaults.standard.string(forKey: "uid")
    }
    func getUserName()-> String?{
        return UserDefaults.standard.string(forKey: "name")
    }
    func setUserData(phone: String, name: String, id: String) {
        UserDefaults.standard.set(phone, forKey: "phone")
        UserDefaults.standard.set(name, forKey: "name")
        UserDefaults.standard.set(id, forKey: "uid")
        UserDefaults.standard.synchronize()
    }
    func resetUserData() {
        UserDefaults.standard.set(nil, forKey: "phone")
        UserDefaults.standard.set(nil, forKey: "name")
        UserDefaults.standard.set(nil, forKey: "uid")
        UserDefaults.standard.synchronize()
    }
    func isLoggedIn() -> Bool {
        if   UserManager.shared.getUserId() != nil && UserManager.shared.getUserPhone() != nil &&  UserManager.shared.getUserName() != nil {
            return true
        }
        else{
            return false
        }
    }
    func setUserLocation(lat: Double, lng: Double){
        UserDefaults.standard.set(lat, forKey: "lat")
        UserDefaults.standard.set(lng, forKey: "lng")
        UserDefaults.standard.synchronize()
    }
    func getUserlat()-> Double {
        return UserDefaults.standard.double(forKey: "lat")
    }
    func getUserlng()-> Double {
        return UserDefaults.standard.double(forKey: "lng")
    }
    static var shared = UserManager()
}
