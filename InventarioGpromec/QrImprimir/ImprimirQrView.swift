//
//  ImprimirQrView.swift
//  InventarioGpromec
//
//  Created by Alexis Villarruel on 22/09/25.
//

import SwiftUI

struct ImprimirQrView: View {
    @State private var selectedSize: SizeOption = .small
    
    let itemID: String  // pasa String(item.id) cuando tengas tu ID real
    
    enum SizeOption: String, CaseIterable, Identifiable {
        case small = "Small", medium = "Medium", large = "Large"
        var id: Self { self }
        var points: CGFloat {
            switch self {
            case .small:  return 20
            case .medium: return 35
            case .large:  return 60
            }
        }
    }
    @State private var size: SizeOption = .small
    
    // Genera el QR una vez por ID
    private var qrUIImage: UIImage? {
        QRCode.make(from: itemID, scale: 10)
    }
    
    
    var body: some View {
        VStack {
            HStack {
                Text("ID : \(itemID) ")// cambiar por id de card
                Spacer()
                
                Picker("Tamaño", selection: $selectedSize) {
                    ForEach(SizeOption.allCases, id: \.self) { size in
                        Text(size.rawValue)
                    }
                }
                .pickerStyle(.menu) // estilo como botón desplegable
            }.padding()
            //            Rectangle()
            //                .frame(width: 300, height: 300)
            //            Spacer().frame(height: 80)
            // Cuadro del QR (tu “área de líneas”)
            ZStack {
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(.ultraThinMaterial)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .stroke(.white.opacity(0.25), lineWidth: 1)
                    )
                
                if let ui = qrUIImage {
                    Image(uiImage: ui)
                        .resizable()
                        .interpolation(.none)   // nitidez perfecta
                        .scaledToFit()
                        .frame(width: selectedSize.points, height: selectedSize.points)
                } else {
                    ProgressView() // o un placeholder
                }
            }
            .frame(maxWidth: .infinity, minHeight: 260)
            Button(action: {
                if let ui = qrUIImage {
                    Printer.print(image : ui, id: itemID,sizeMM: selectedSize.points)
                }
            }) {
                Text("Imprimir QR")
                    .frame(width: 180, height: 50)
                    .background(
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .fill(Color.blue)
                    ).font(.headline).foregroundColor(.white).padding()
            }
            
        }
        
    }
}

#Preview {
    ImprimirQrView(itemID: "2")
}
