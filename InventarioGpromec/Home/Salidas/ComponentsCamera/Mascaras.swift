import SwiftUICore


struct ScanMaskOverlay: View {
    let box: CGRect       // en coords de la vista (no normalizado)

    var body: some View {
        GeometryReader { geo in
            // capa oscura
            Color.black.opacity(0.35)
                .mask(
                    Rectangle()
                        .overlay(
                            Rectangle()
                                .path(in: box)
                                .fill(style: FillStyle(eoFill: true)) // “agujero”
                        )
                )
                .allowsHitTesting(false)

            // 4 esquinas
            CornerMarks(rect: box, lineWidth: 10, length: 60)
                .stroke(Color.black, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                .allowsHitTesting(false)
        }
    }
}

struct CornerMarks: Shape {
    let rect: CGRect
    let lineWidth: CGFloat
    let length: CGFloat
    func path(in _: CGRect) -> Path {
        var p = Path()
        let r = rect

        // Esquina superior-izq
        p.move(to: CGPoint(x: r.minX, y: r.minY + length))
        p.addLine(to: CGPoint(x: r.minX, y: r.minY))
        p.addLine(to: CGPoint(x: r.minX + length, y: r.minY))

        // sup-der
        p.move(to: CGPoint(x: r.maxX - length, y: r.minY))
        p.addLine(to: CGPoint(x: r.maxX, y: r.minY))
        p.addLine(to: CGPoint(x: r.maxX, y: r.minY + length))

        // inf-izq
        p.move(to: CGPoint(x: r.minX, y: r.maxY - length))
        p.addLine(to: CGPoint(x: r.minX, y: r.maxY))
        p.addLine(to: CGPoint(x: r.minX + length, y: r.maxY))

        // inf-der
        p.move(to: CGPoint(x: r.maxX - length, y: r.maxY))
        p.addLine(to: CGPoint(x: r.maxX, y: r.maxY))
        p.addLine(to: CGPoint(x: r.maxX, y: r.maxY - length))

        return p
    }
}
