//
//  Helpers.swift
//  Venga
//
//  Created by David Richards on 5/27/17.
//  Copyright © 2017 David Richards. All rights reserved.
//

import UIKit
import Dollar

class Helpers: NSObject {

    static func calculateHeight(inString:String, fontSize: CGFloat = 18) -> CGFloat
    {
        let messageString = inString
        let attributes : [String : Any] = [NSFontAttributeName : UIFont.systemFont(ofSize: fontSize)]
        
        let attributedString : NSAttributedString = NSAttributedString(string: messageString, attributes: attributes)
        
        let rect : CGRect = attributedString.boundingRect(with: CGSize(width: 340.0, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, context: nil)
        
        let requredSize:CGRect = rect
        NSLog(requredSize.height.description)
        if requredSize.height < 40 {
            return 40
        }
        return requredSize.height
    }
    
    static func connetImagesToTitle(imageMap: [String: UIImage], uploadImages: [UploadImage]) -> [UploadImage]? {
        return uploadImages.map { image in
            return UploadImage(title: image.title, image: imageMap[image.title]!, url: image.url, uploadUrl: image.uploadUrl)
        }
    }
    
    static func validateExperience(values: Dictionary<String, Any>) -> Bool {
        let requiredKeys = ["title", "price", "group_size", "age_requirement", "style", "hours", "description", "itinerary", "image0", "language0", "included0", "location"]
        let valueKeys = $.keys(values)
        var isValidated = true
        requiredKeys.forEach { key in
            if (!$.contains(valueKeys, value: key)) {
                NSLog("Error finding \(key)")
                isValidated = false
            }
        }
        return isValidated
    }
}
