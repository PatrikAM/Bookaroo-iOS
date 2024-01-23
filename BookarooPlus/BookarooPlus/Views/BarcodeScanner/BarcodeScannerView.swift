//
//  BarcodeScannerView.swift
//  BookarooPlus
//
//  Created by Patrik Michl on 04.01.2024.
//

import AVFoundation
import SwiftUI
import VisionKit

struct BarcodeScannerView: View {
    // https://medium.com/@jpmtech/how-to-make-a-qr-or-barcode-scanner-in-swiftui-68d8dae8e908
    // https://medium.com/@ios_guru/swiftui-and-custom-barcode-scanner-f3daaeabfcea
    
//    @State private var captureSession: AVCaptureSession?
//    @State private var videoPreviewLayer: AVCaptureVideoPreviewLayer?
//    
//    var body: some View {
//        ZStack {
//            VideoCaptureView(captureSession: $captureSession,
//                             videoPreviewLayer: $videoPreviewLayer)
//                .edgesIgnoringSafeArea(.all)
//            BarcodeOverlay(captureSession: $captureSession)
//                .edgesIgnoringSafeArea(.all)
//        }
//        .onAppear(perform: startSession)
//    }
//    
//    private func startSession() {
//        guard let captureDevice = AVCaptureDevice.default(for: .video) else { return }
//        do {
//            let input = try AVCaptureDeviceInput(device: captureDevice)
//            captureSession = AVCaptureSession()
//            captureSession?.addInput(input)
//            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
//            videoPreviewLayer?.videoGravity = .resizeAspectFill
//            videoPreviewLayer?.frame = UIScreen.main.bounds
//            captureSession?.startRunning()
//        } catch {
//            print(error)
//        }
//    }
//    
    var onDisappearEvent: () -> Void
    @Binding var isScannerViewActive: Bool
    
    
    @State var isShowingScanner = true
    @State private var scannedText = ""
    @State private var message = ""
    
    @State private var navigate = false
    
    var body: some View {
        VStack {
            if DataScannerViewController.isSupported && DataScannerViewController.isAvailable {
                ZStack(alignment: .bottom) {
                    BarcodeScannerRepresentable(
                        shouldStartScanning: $isShowingScanner,
                        scannedText: $scannedText,
                        dataToScanFor: [.barcode(symbologies: [.ean13])]
                    )
                    
                    Text(message)
                        .padding()
                        .background(Color.white)
                        .foregroundColor(.black)
                }
            } else if !DataScannerViewController.isSupported {
                Text("It looks like this device doesn't support the DataScannerViewController")
            } else {
                Text("It appears your camera may not be available")
            }
        }
        .onChange(of: scannedText) {
            if scannedText.isValidIsbn() {
                navigate.toggle()
            } else {
                message = "This is not valid ISBN. Please try again."
            }
        }
        .navigate(to: BookAddEditView(onDisappearEvent: onDisappearEvent, isScannerViewActive: $isScannerViewActive, isbn: scannedText), when: $navigate)
    }
}
