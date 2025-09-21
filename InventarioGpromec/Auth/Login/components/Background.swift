//
//  Background.swift
//  InventarioGpromec
//
//  Created by Alexis Villarruel on 19/09/25.
//

import SwiftUI
import Lottie

struct Background: View {
    var body: some View {
        LottieView(animation: .named("fondo"))   // ← sin extensión
                    .playbackMode(.playing(.toProgress(1, loopMode: .loop)))
                    .ignoresSafeArea()
                    .allowsTightening(false)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    Background()
}
