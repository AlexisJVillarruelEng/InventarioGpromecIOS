//
//  Printer.swift
//  InventarioGpromec
//
//  Created by Alexis Villarruel on 22/09/25.
//
import CoreGraphics
import Foundation
import UIKit

private func mmToPoints(_ mm: CGFloat) -> CGFloat { mm * 72.0 / 25.4 } // 1pt = 1/72 in

final class QRPageRenderer: UIPrintPageRenderer {
    let qr: UIImage
    let sizePt: CGFloat
    let marginPt: CGFloat
    let corner: Corner

    enum Corner { case topLeft, topRight, bottomLeft, bottomRight }

    init(qr: UIImage, sizeMM: CGFloat, marginMM: CGFloat = 10, corner: Corner = .topLeft) {
        self.qr = qr
        self.sizePt = mmToPoints(sizeMM)
        self.marginPt = mmToPoints(marginMM)
        self.corner = corner
        super.init()
    }

    override func drawPage(at pageIndex: Int, in printableRect: CGRect) {
        let w = sizePt, h = sizePt
        var x = printableRect.minX + marginPt
        var y = printableRect.minY + marginPt

        switch corner {
        case .topLeft:
            break
        case .topRight:
            x = printableRect.maxX - marginPt - w
        case .bottomLeft:
            y = printableRect.maxY - marginPt - h
        case .bottomRight:
            x = printableRect.maxX - marginPt - w
            y = printableRect.maxY - marginPt - h
        }

        let rect = CGRect(x: x, y: y, width: w, height: h)
        qr.draw(in: rect)
    }
}

enum Printer {
    @MainActor
    static func print(image : UIImage, id: String, sizeMM: CGFloat, corner: QRPageRenderer.Corner = .topLeft) {
        let info = UIPrintInfo(dictionary: nil)
        info.outputType = .photo
        info.jobName = "QR \(id)"
        info.orientation = .portrait
        info.duplex = .none

        let ctrl = UIPrintInteractionController.shared
        ctrl.printInfo = info
        ctrl.printPageRenderer = QRPageRenderer(qr: image, sizeMM: sizeMM, marginMM: 10, corner: corner)
        ctrl.present(animated: true)
    }
}
