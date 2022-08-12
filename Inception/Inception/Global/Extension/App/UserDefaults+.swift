//
//  UserDefaults+.swift
//  Inception
//
//  Created by Chanhee Jeong on 2022/08/12.
//

import Foundation

extension UserDefaults {
  private enum UserDefaultKeys: String {
    case hasOnboarded
  }
  
  //true -> home , false -> onboarding
  var hasOnboarded: Bool {
    get{
      bool(forKey: UserDefaultKeys.hasOnboarded.rawValue)
    }
    
    set {
      setValue(newValue, forKey: UserDefaultKeys.hasOnboarded.rawValue)
    }
  }
}
