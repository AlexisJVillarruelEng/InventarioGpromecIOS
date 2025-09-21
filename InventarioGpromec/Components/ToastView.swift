//
//  ToastView.swift
//  InventarioGpromec
//
//  Created by Alexis Villarruel on 21/09/25.
//

import SwiftUI

struct ToastView: View {
    let texto: String
    @Binding var esmostrar: Bool
    
    var body: some View {
        if esmostrar && !texto.isEmpty{
            VStack {
                Spacer()
                Text(texto)
                    .font(.callout.bold())
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background(.black.opacity(0.7))
                    .clipShape(Capsule())
                    .shadow(radius: 5, y: 2.5)
                    .gesture(DragGesture().onEnded { value in
                        if value.translation.height > 30 {
                            withAnimation {
                                esmostrar = false
                            }
                        }
                    }
                    )
            }.transition(.move(edge: .bottom).combined(with: .opacity))
                .animation(.easeInOut,value: esmostrar)
                .onAppear {
                    //cierre auto
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation {
                            esmostrar = false
                        }
                    }
                }
        }
    }
}

#Preview {
    ToastView(
        texto: "login iniciado con exito", esmostrar: .constant(true)
    )
}
