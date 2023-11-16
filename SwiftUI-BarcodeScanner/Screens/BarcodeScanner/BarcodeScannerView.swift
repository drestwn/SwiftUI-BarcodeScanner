//
//  ContentView.swift
//  SwiftUI-BarcodeScanner
//
//  Created by Andre on 16/11/23.
//

import SwiftUI

struct BarcodeScannerView: View {
    
    @StateObject var viewModel = BarcodeScannerViewModel()
    
//    public init(alertItem: Binding<AlertItem?>) {
//           _alertItem = alertItem
//       }
//    
    var body: some View {
        NavigationView{
            VStack{
                ScannerView(scannedCode: $viewModel.scannedCode, alertItem: $viewModel.alertItem)
                    .frame(maxWidth: .infinity, maxHeight: 100, alignment: .top)
                
                Spacer()
                    .frame(height: 60)
                
                Label("Scan the barcode", systemImage: "barcode.viewfinder")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                
                Text(viewModel.statusText)
                    .bold()
                    .font(.largeTitle)
                    .foregroundStyle(viewModel.statusColor)
                    .padding()
            }
            .navigationTitle("Barcode Scanner")
            .alert(item:$viewModel.alertItem) { alertItem in
                Alert(title: Text(alertItem.title), message: Text(alertItem.message), dismissButton: .default(Text("close")))
            }
            
        }
    }
}

#Preview {
    BarcodeScannerView()
}
