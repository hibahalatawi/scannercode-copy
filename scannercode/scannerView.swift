//
//  scannerView.swift
//  scannercode
//
//  Created by Hibah Abdullah Alatawi on 21/07/1444 AH.
//
import VisionKit
import Foundation
import SwiftUI


struct ScannerView:UIViewControllerRepresentable {
    func makeCoordinator() -> Coordinator {
        return Coordinator(completionHandler: completionHandler)
    }
    
    final class Coordinator: NSObject, VNDocumentCameraViewControllerDelegate {
       
        private let completionHandler: (UIImage?) -> Void
        
        init(completionHandler: @escaping (UIImage?) -> Void) {
            self.completionHandler = completionHandler
        }
        func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
            let recognizer = TextRecognizer(cameraScan: scan)
            recognizer.recognizeImage(withCompletionHandler: completionHandler)
            
        }
        func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFailWithError error: Error) {
            completionHandler(nil)
        }
        func documentCameraViewControllerDidCancel(_ controller: VNDocumentCameraViewController) {
            completionHandler(nil)
        }
    }
    func makeUIViewController(context: Context) -> VNDocumentCameraViewController {
        let viewController = VNDocumentCameraViewController()
        viewController.delegate = context.coordinator
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: VNDocumentCameraViewController, context: Context) {
    }
    typealias UIViewControllerType = VNDocumentCameraViewController
    
    private let completionHandler: (UIImage?) -> Void
    
    init(completionHandler: @escaping (UIImage?) -> Void) {
        self.completionHandler = completionHandler
    }
}
