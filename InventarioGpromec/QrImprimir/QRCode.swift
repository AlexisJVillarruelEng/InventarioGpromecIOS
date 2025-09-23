//
//  QRCode.swift
//  InventarioGpromec
//
//  Created by Alexis Villarruel on 22/09/25.
//

import Foundation
import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

enum QRCode {
    static let context = CIContext()
    static let filter = CIFilter.qrCodeGenerator()

    /// Genera un UIImage de QR nítido.
    static func make(from text: String, scale: CGFloat = 12, correction: String = "H") -> UIImage? {
        filter.message = Data(text.utf8)
        // L, M, Q, H (H = más redundancia → mejor al reducir)
        filter.setValue(correction, forKey: "inputCorrectionLevel")

        guard let output = filter.outputImage else { return nil }
        let transformed = output.transformed(by: CGAffineTransform(scaleX: scale, y: scale))

        guard let cgimg = context.createCGImage(transformed, from: transformed.extent) else { return nil }
        return UIImage(cgImage: cgimg)
    }
}
