//
//  BarcodeScannerViewModel.swift
//  SwiftUI-BarcodeScanner
//
//  Created by Andre on 16/11/23.
//

import SwiftUI

final class BarcodeScannerViewModel: ObservableObject{
    
    @Published var scannedCode = ""
    @Published var alertItem: AlertItem?
    
    var statusText: String{
        scannedCode.isEmpty ? "Not yet scanned" : scannedCode
    }
    
    var statusColor: Color{
        scannedCode.isEmpty ? .red : .green
    }
}
