//
//  BlankView.swift
//  Devote
//
//  Created by Abiodun Osagie on 19/03/2025.
//

import SwiftUI

struct BlankView: View {
    // MARK: - PROPERTIES
    var backgroundColor: Color
    var backgroundOpacity: Double
    // MARK: - BODY
    var body: some View {
        VStack{
            Rectangle()
        }
        .edgesIgnoringSafeArea(.all)
        .foregroundStyle(backgroundColor.opacity(backgroundOpacity))
        .blendMode(.overlay)
    }
}


// MARK: - PREVIEWS
#Preview {
    BlankView(backgroundColor: Color.black, backgroundOpacity: 0.3)
        .background(BackgroundImageView())
        .background(backgroundGradient.ignoresSafeArea(.all))
}
