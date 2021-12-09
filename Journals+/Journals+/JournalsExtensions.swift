//
//  JournalsExtensions.swift
//  Journals+
//
//  Created by Mazen M. Abdel-Rahman on 2/15/17.
//  Copyright © 2017 Mazen M. Abdel-Rahman. All rights reserved.
//

import UIKit

extension UIImage {

    func resize(to size:CGSize, scale:(CGFloat))->(UIImage?) {
        
        guard let cgImage = self.cgImage else {
            return nil
        }
        
        let bitsPerComponent = cgImage.bitsPerComponent
        let bytesPerRow = cgImage.bytesPerRow
        let colorSpace = cgImage.colorSpace
        let bitmapInfo = cgImage.bitmapInfo
        
        let context = CGContext(data: nil, width: Int(size.width * scale), height: Int(size.height * scale), bitsPerComponent: bitsPerComponent, bytesPerRow: bytesPerRow, space: colorSpace!, bitmapInfo: bitmapInfo.rawValue)
        
        context!.interpolationQuality = CGInterpolationQuality.high
        
        context?.draw(cgImage, in: CGRect(origin: CGPoint.zero, size: CGSize(width: CGFloat(size.width * scale), height: CGFloat(size.height * scale))))
        
        let scaledImage = context!.makeImage().flatMap { UIImage(cgImage: $0, scale:scale, orientation:self.imageOrientation) }
        
        return scaledImage
    }
    
    ///This method returns a resized copy of the image that preseves the aspect ratio and
    ///resized it to the specified dimension.  If isMaxDimension is true it resizes the image
    ///so that the largest dimension of the image returned is equal to the parameter dimension.
    ///If isMaxDimension is false it resizes the image so that the smalles dimension of the
    /// mage returned is equal to the parameter dimension.
    ///
    /// -Parameters:
    ///      -dimension: The dimension to resize the image to.  This can either be the max or the min.
    ///      -isMaxDimension: Specified if value in 'dimension' parametr speficies the maximum or minimum dimension
    ///
    func resizeAndKeepAspectRatio(to dimension:CGFloat, scale:CGFloat, isMaxDimension:Bool)->(UIImage?) {
     
        let originalWidth = self.size.width
        let originalHeight = self.size.height
        
            let smallestImageDimensionValue = (originalWidth <= originalHeight) ? originalWidth:originalHeight
            
            let largestImageDimensionValue = (originalWidth >= originalHeight) ? originalWidth:originalHeight

        let divisor:CGFloat
        
        if isMaxDimension {
            divisor = largestImageDimensionValue/dimension
        } else {
            divisor = smallestImageDimensionValue/dimension
        }
        
        
        let destWidth = originalWidth/divisor
        let destHeight = originalHeight/divisor
        
        
        let resizedImage = resize(to: CGSize(width: destWidth, height:destHeight), scale: scale)
        
        return resizedImage
    }
    
}
