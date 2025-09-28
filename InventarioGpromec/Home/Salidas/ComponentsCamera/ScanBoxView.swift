import SwiftUI

struct ScanBoxView: View {
    @Binding var scannedText: String
    @State private var stopAfterFound = true   // si quieres parar tras leer

    var body: some View {
        GeometryReader { geo in
            // cuadro centrado de 300x300 (solo visual)
            let size: CGFloat = 210
            let box = CGRect(x: (geo.size.width - size)/2,
                             y: (geo.size.height - size)/2,
                             width: size, height: size)

            ZStack {
                // Scanner real
                QRScannerView(scannedText: $scannedText) { _ in
                    // opcional: si quieres hacer algo al encontrar
                    if stopAfterFound {
                        // nada aquí; el VC ya hace stopRunning() al encontrar
                    }
                }

                // Máscara con “hueco” donde quieres que el usuario enfoque
                ScanMaskOverlay(box: box)
            }
        }
        .frame(height: 210)
        .clipped()
    }
}

