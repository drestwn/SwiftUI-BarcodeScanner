//
//  Alert.swift
//  SwiftUI-BarcodeScanner
//
//  Created by Andre on 16/11/23.
//

import SwiftUI

struct AlertItem : Identifiable{
    let id = UUID()
    let title: String
    let message: String
    let dismissButton: Alert.Button
}

struct AlertContext{
    static let invalidDeviceInput = AlertItem(title: "Invalid Device Input", message: "Something is wrong with camera", dismissButton: .default(Text("Close")))
    
    static let invalidscannedType = AlertItem(title: "Invalid Scanned Type", message: "The value scanned is not valid. Only EAN-8 and EAN-13 type.", dismissButton: .default(Text("Close")))
}
