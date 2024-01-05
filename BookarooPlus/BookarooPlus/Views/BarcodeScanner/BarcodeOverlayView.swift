//
//  BarcodeOverlayView.swift
//  BookarooPlus
//
//  Created by Patrik Michl on 05.01.2024.
//

import AVFoundation
import SwiftUI

struct BarcodeOverlay: View {
    @Binding var captureSession: AVCaptureSession?
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.clear)
                .frame(width: 300, height: 200)
                .overlay(
                    Text("Scan Barcode Here")
                        .foregroundColor(.white)
                        .font(.largeTitle)
            )
            .background(Color.black.opacity(0.5))
            .cornerRadius(20)
            .onTapGesture {
                self.captureSession?.startRunning()
            }
            .onAppear {
                self.captureSession?.stopRunning()
            }
        }
    }
}
