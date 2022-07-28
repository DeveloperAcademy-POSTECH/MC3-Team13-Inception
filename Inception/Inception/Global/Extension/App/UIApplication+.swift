//
//  UIApplication+.swift
//  Inception
//
//  Created by Admin on 2022/07/28.
//

import UIKit

extension UIApplication {
    static var firstKeyWindowForConnectedScenes: UIWindow? {
        UIApplication.shared
            // Of all connected scenes...
            .connectedScenes.lazy

            // ... grab all foreground active window scenes ...
            .compactMap { $0.activationState == .foregroundActive ? ($0 as? UIWindowScene) : nil }

            // ... finding the first one which has a key window ...
            .first(where: { $0.keyWindow != nil })?

            // ... and return that window.
            .keyWindow
    }
}
