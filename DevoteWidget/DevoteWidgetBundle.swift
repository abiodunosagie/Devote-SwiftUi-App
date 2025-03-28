//
//  DevoteWidgetBundle.swift
//  DevoteWidget
//
//  Created by Abiodun Osagie on 25/03/2025.
//

import WidgetKit
import SwiftUI

@main
struct DevoteWidgetBundle: WidgetBundle {
    var body: some Widget {
        DevoteWidget()
        DevoteWidgetControl()
        DevoteWidgetLiveActivity()
    }
}
