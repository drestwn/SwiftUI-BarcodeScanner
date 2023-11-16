//
//  ScannerVC.swift
//  SwiftUI-BarcodeScanner
//
//  Created by Andre on 16/11/23.
//

import UIKit
import AVFoundation

enum CameraError{
    case invalidDeviceInput
    case invalidScannedValue
}

protocol ScannerVCDeligate: AnyObject{
    func didFind(barcode: String)
    func didSurvace(error: CameraError)
}


final class ScannerVC: UIViewController{
    let captureSession = AVCaptureSession()
    var previewLayer: AVCaptureVideoPreviewLayer?
    
    weak var scannerDeligate: ScannerVCDeligate!
    
    init (scannerDeligate: ScannerVCDeligate){
        super.init(nibName: nil, bundle: nil)
        self.scannerDeligate =  scannerDeligate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCapturedSession()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard let previewLayer = previewLayer else{
            scannerDeligate.didSurvace(error: .invalidDeviceInput)
            return
        }
        
        previewLayer.frame =  view.layer.bounds
    }
    
    
    private func setupCapturedSession(){
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else{
            scannerDeligate?.didSurvace(error: .invalidDeviceInput)
            return

        }
        
        let videoInput: AVCaptureDeviceInput
        do{
            try videoInput = AVCaptureDeviceInput(device: videoCaptureDevice)
            
        }catch{
            scannerDeligate?.didSurvace(error: .invalidDeviceInput)
            return
        }
        
        if captureSession.canAddInput(videoInput){
            captureSession.addInput(videoInput)
        }else{
            scannerDeligate?.didSurvace(error: .invalidDeviceInput)
            return
        }
        
        let metaDataOutput = AVCaptureMetadataOutput()
        
        if captureSession.canAddOutput(metaDataOutput){
            captureSession.addOutput(metaDataOutput)
            metaDataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
//            on lane 55 is the setting of what type of barcode you want to scanned
            metaDataOutput.metadataObjectTypes=[.ean8, .ean13]
        }else{
            return
        }
        
//            after all the checks upthere. Here is how it runs camera
        previewLayer=AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer!.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer!)
        
        captureSession.startRunning()
        
    }
}


extension ScannerVC: AVCaptureMetadataOutputObjectsDelegate{
//    In this extention, is what to do after captureing or initiate the camera on
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        guard let object = metadataObjects.first else{
            scannerDeligate?.didSurvace(error: .invalidScannedValue)
            return
        }
        
        guard let mechineReadableObject = object as? AVMetadataMachineReadableCodeObject else{
            scannerDeligate?.didSurvace(error: .invalidScannedValue)
            return
        }
        guard let barcode = mechineReadableObject.stringValue else{
            scannerDeligate?.didSurvace(error: .invalidScannedValue)
            return
        }
        
        scannerDeligate?.didFind(barcode: barcode)
    }
}
