//: [Previous](@previous)

import Foundation
import CoreImage
import UIKit

var context = CIContext()

var uiImage = UIImage(named: "crowd.jpg")
var originalImage = CIImage(CGImage: uiImage!.CGImage!)

let detector = CIDetector(ofType: CIDetectorTypeFace, context: nil, options: nil)
let faceArray = detector.featuresInImage(originalImage)

// Create a green circle to cover the rects that are returned.

var maskImage: CIImage = nil


for (CIFeature *f in faceArray) {
    CGFloat centerX = f.bounds.origin.x + f.bounds.size.width / 2.0;
    CGFloat centerY = f.bounds.origin.y + f.bounds.size.height / 2.0;
    CGFloat radius = MIN(f.bounds.size.width, f.bounds.size.height) / 1.5);
    CIFilter *radialGradient = [CIFilter filterWithName:@"CIRadialGradient" keysAndValues:
    @"inputRadius0", @(radius),
    @"inputRadius1", @(radius + 1.0f),
    @"inputColor0", [CIColor colorWithRed:0.0 green:1.0 blue:0.0 alpha:1.0],
    @"inputColor1", [CIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0],
    kCIInputCenterKey, [CIVector vectorWithX:centerX Y:centerY],
    nil];
    CIImage *circleImage = [radialGradient valueForKey:kCIOutputImageKey];
    if (nil == maskImage)
    maskImage = circleImage;
    else
    maskImage = [[CIFilter filterWithName:@"CISourceOverCompositing" keysAndValues:
    kCIInputImageKey, circleImage,
    kCIInputBackgroundImageKey, maskImage,
    nil] valueForKey:kCIOutputImageKey];
}

//: [Next](@next)
