import SwiftUI
import AVFoundation

struct QRScannerView: UIViewControllerRepresentable {
    @Binding var scannedText: String
    var onFound: ((String) -> Void)?

    func makeUIViewController(context: Context) -> ScannerVC {
        let vc = ScannerVC()
        vc.onFound = { text in
            scannedText = text
            onFound?(text)
        }
        return vc
    }

    func updateUIViewController(_ uiViewController: ScannerVC, context: Context) {}
}

final class ScannerVC: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    private let session = AVCaptureSession()
    private var previewLayer: AVCaptureVideoPreviewLayer?   // ← opcional
    var onFound: ((String) -> Void)?

    private let messageLabel: UILabel = {
        let l = UILabel()
        l.textColor = .white
        l.numberOfLines = 0
        l.textAlignment = .center
        l.isHidden = true
        return l
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.addSubview(messageLabel)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            messageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            messageLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            messageLabel.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 16),
            messageLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -16)
        ])

        requestCameraPermissionAndConfigure()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        previewLayer?.frame = view.bounds           // ← protegido
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async { [weak self] in self?.session.startRunning() }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        DispatchQueue.main.async { [weak self] in self?.session.stopRunning() }
    }

    private func requestCameraPermissionAndConfigure() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            configureSession()
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                DispatchQueue.main.async {
                    granted ? self?.configureSession()
                            : self?.showNoPermissionMessage()
                }
            }
        default:
            showNoPermissionMessage()
        }
    }

    private func showNoPermissionMessage() {
        messageLabel.isHidden = false
        messageLabel.text = "Sin permiso de cámara.\nActívalo en Ajustes > Privacidad > Cámara."
    }

    private func configureSession() {
        guard let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back),
              let input = try? AVCaptureDeviceInput(device: device)
        else {
            showNoPermissionMessage()
            return
        }

        session.beginConfiguration()
        defer { session.commitConfiguration() }

        if session.canAddInput(input) { session.addInput(input) }

        let output = AVCaptureMetadataOutput()
        guard session.canAddOutput(output) else { return }
        session.addOutput(output)

        output.setMetadataObjectsDelegate(self, queue: .main)
        output.metadataObjectTypes = [.qr]

        let layer = AVCaptureVideoPreviewLayer(session: session)
        layer.videoGravity = .resizeAspectFill
        view.layer.insertSublayer(layer, at: 0)    // debajo del label
        previewLayer = layer
        previewLayer?.frame = view.bounds
    }

    func metadataOutput(_ output: AVCaptureMetadataOutput,
                        didOutput metadataObjects: [AVMetadataObject],
                        from connection: AVCaptureConnection) {
        guard let qr = metadataObjects.first as? AVMetadataMachineReadableCodeObject,
              let text = qr.stringValue else { return }
        onFound?(text)
        session.stopRunning()
    }
}
