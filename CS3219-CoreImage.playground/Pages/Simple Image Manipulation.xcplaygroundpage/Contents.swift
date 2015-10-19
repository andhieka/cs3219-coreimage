//: Playground - noun: a place where people can play

import UIKit
import XCPlayground

var context = CIContext()

var uiImage = UIImage(named: "crowd.jpg")
var originalImage = CIImage(CGImage: uiImage!.CGImage!)
var imageView = UIImageView()

func increaseBrightness(image: CIImage, amount: Double) -> UIImage {
    var result = image
    // enter your core image magic here
    
    let brightnessFilter = CIFilter(name: "CIColorControls")!
    brightnessFilter.setValue(image, forKey: kCIInputImageKey)
    brightnessFilter.setValue(amount, forKey: kCIInputBrightnessKey)
    result = brightnessFilter.outputImage!
    
    let renderedImage = context.createCGImage(result, fromRect: image.extent)
    return UIImage(CGImage: renderedImage)
}

func chainFilters(image: CIImage, amount: Double) -> UIImage {
    var result = image
    
    // demo your CIFilter here
    let sepiaFilter = CIFilter(name: "CISepiaTone")
    sepiaFilter?.setValue(image, forKey: kCIInputImageKey)
    sepiaFilter?.setValue(amount, forKey: kCIInputIntensityKey)
    
    let vignetteFilter = CIFilter(name: "CIVignette")
    vignetteFilter?.setValue(sepiaFilter?.outputImage, forKey: kCIInputImageKey)
    vignetteFilter?.setValue(amount, forKey: kCIInputIntensityKey)
    result = vignetteFilter!.outputImage!
    
    let renderedImage = context.createCGImage(result, fromRect: image.extent)
    return UIImage(CGImage: renderedImage)
}

func sepiaFilters(image: CIImage, amount: Double) -> UIImage {
    var result = image
    
    let sepiaFilter = CIFilter(name: "CISepiaTone")
    sepiaFilter?.setValue(image, forKey: kCIInputImageKey)
    sepiaFilter?.setValue(amount, forKey: kCIInputIntensityKey)
    result = sepiaFilter!.outputImage!
    
    let renderedImage = context.createCGImage(result, fromRect: image.extent)
    return UIImage(CGImage: renderedImage)
}

let sepiaResult = sepiaFilters(originalImage, amount: 1.0)

let myImage = chainFilters(originalImage, amount: 1)// demo adjusting brightness
//for var i = -0.75; i < 1.0; i = i + 0.25 {
  //  let image = increaseBrightness(originalImage, amount: i)
    //imageView.image = image
    //XCPShowView("Brightness", view: imageView)
//}

// demo old effect
for var i: Double = 0; i < 1.0; i = i + 0.2 {
    
}

