//
//  SwiftUI_BarcodeScannerApp.swift
//  SwiftUI-BarcodeScanner
//
//  Created by Andre on 16/11/23.
//

import SwiftUI

@main
struct SwiftUI_BarcodeScannerApp: App {
    @State private var alertItem: AlertItem? = nil
    var body: some Scene {
        WindowGroup {
            BarcodeScannerView()
        }
    }
}
