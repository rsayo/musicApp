//
//  extensions.swift
//  spotlight
//
//  Created by bajo on 2022-01-08.
//

import Foundation
import UIKit

extension UITextField {
    
    func addBottomBorder(){
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: self.frame.size.height - 1, width: self.frame.size.width, height: 1)
//        backgroundColor = .white
//        textColor = .black
        bottomLine.cornerRadius = 10
        borderStyle = .none
        layer.addSublayer(bottomLine)
    }
    
}
extension UILabel {
    
    func setFont(with size: CGFloat){
        font = UIFont(name: "Helvetica Neue", size: size)
    }
    func setBoldFont(with size: CGFloat){
        font = UIFont.boldSystemFont(ofSize: size)
    }
    
}
extension UIImageView {
    func setUpImage(url: String){
        
        isUserInteractionEnabled = true
        
        NetworkManager.getImage(with: url) { result in
            switch(result){
            case .success(let data):
                self.image = UIImage(data: data)
            case .failure(let err):
                print(err)
                return
            }
        }
    }
}
extension UIImage {
    
    var averageColor: UIColor? {
        guard let inputImage = CIImage(image: self) else { return nil }
        let extentVector = CIVector(x: inputImage.extent.origin.x, y: inputImage.extent.origin.y, z: inputImage.extent.size.width, w: inputImage.extent.size.height)

        guard let filter = CIFilter(name: "CIAreaAverage", parameters: [kCIInputImageKey: inputImage, kCIInputExtentKey: extentVector]) else { return nil }
        guard let outputImage = filter.outputImage else { return nil }

        var bitmap = [UInt8](repeating: 0, count: 4)
        let context = CIContext(options: [.workingColorSpace: kCFNull!])
        context.render(outputImage, toBitmap: &bitmap, rowBytes: 4, bounds: CGRect(x: 0, y: 0, width: 1, height: 1), format: .RGBA8, colorSpace: nil)

        return UIColor(red: CGFloat(bitmap[0]) / 255, green: CGFloat(bitmap[1]) / 255, blue: CGFloat(bitmap[2]) / 255, alpha: CGFloat(bitmap[3]) / 255)
        
    }
}
