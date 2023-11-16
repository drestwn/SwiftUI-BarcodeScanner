//
//  ScannerView.swift
//  SwiftUI-BarcodeScanner
//
//  Created by Andre on 16/11/23.
//

import SwiftUI

struct ScannerView: UIViewControllerRepresentable {

    @Binding var scannedCode: String
    @Binding var alertItem:AlertItem?
    
    func makeUIViewController(context: Context) -> ScannerVC {
        ScannerVC(scannerDeligate: context.coordinator)
    }
    
    func updateUIViewController(_ uiViewController: ScannerVC, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(scannerView: self)
    }
    
    final class Coordinator: NSObject, ScannerVCDeligate{
//        passing from scannerview to coordinator
        private let scannerView: ScannerView
        
        init (scannerView: ScannerView){
            self.scannerView = scannerView
        }
//        after passing, get it
        func didFind(barcode: String) {
            scannerView.scannedCode = barcode
        }
        
        func didSurvace(error: CameraError) {
            switch error{
            case.invalidDeviceInput:
                scannerView.alertItem = AlertContext.invalidDeviceInput
            case.invalidScannedValue:
                scannerView.alertItem = AlertContext.invalidscannedType
            }
        }
        
        
    }
    
    
        
}
