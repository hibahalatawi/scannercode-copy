//
//  TextRecogni.swift
//  scannercode
//
//  Created by Hibah Abdullah Alatawi on 21/07/1444 AH.
//

import Foundation
import Vision
import VisionKit

final class TextRecognizer{
    let cameraScan : VNDocumentCameraScan
    init(cameraScan:VNDocumentCameraScan) {
        self.cameraScan = cameraScan
    }
    private let queue = DispatchQueue(label: "scann Please ",qos: .default,attributes: [],autoreleaseFrequency:.workItem)
    func recognizeText(withCompletionHandler CompletionHandler:@escaping([String])->Void) {queue.async {
        let image = (0..<self.cameraScan.pageCount).compactMap({
            self.cameraScan.imageOfPage(at: $0).cgImage
        })
        let imageAndRequests = image.map({(image: $0, request:VNRecognizeTextRequest())})
        let textperpage = imageAndRequests.map{image,request->String in
            let handler = VNImageRequestHandler(cgImage: image, options:[:])
            do{
                try handler.perform([request])
                guard let observations = request.results as? [VNRecognizedTextObservation]else{return " "}
                return observations.compactMap({$0.topCandidates(1).first?.string}).joined(separator: "\n")
    }
            catch {
                print(error)
                return ""
            }
        }
        DispatchQueue.main.async {
            CompletionHandler(textperpage)
        }
    }
        
    }
    func recognizeImage(withCompletionHandler CompletionHandler:@escaping(UIImage)->Void) {queue.async {
        var setImage : UIImage?
        
    
        let setImageFirst = (0..<self.cameraScan.pageCount).compactMap({
            setImage = self.cameraScan.imageOfPage(at: $0)  
        })
        DispatchQueue.main.async {
            //guard let setImage = setImage else {return}
            CompletionHandler(setImage!)
        }
        
    }
    }
}
