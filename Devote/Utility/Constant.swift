//
//  Constant.swift
//  Devote
//
//  Created by Abiodun Osagie on 19/03/2025.
//

import Foundation
import SwiftUI

// MARK: - FORMATTER

 let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

// MARK: - UI

var backgroundGradient: LinearGradient {
    return LinearGradient(
        gradient: Gradient(colors: [Color.pink, Color.blue]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}

// MARK: - UX
