//
//  HideKeyboardExtension.swift
//  Devote
//
//  Created by Abiodun Osagie on 19/03/2025.
//

import SwiftUI

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared
            .sendAction(
                #selector(UIResponder.resignFirstResponder),
                to: nil,
                from: nil,
                for: nil
            )
    }
}
#endif

