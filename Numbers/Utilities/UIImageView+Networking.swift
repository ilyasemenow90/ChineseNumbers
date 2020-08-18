//
//  UIImageView+Networking.swift
//  Numbers
//
//  Created by Ilya on 8/18/20.
//  Copyright © 2020 Ilya Semenow. All rights reserved.
//

import Foundation
import UIKit

let imageCache = NSCache<NSString, UIImage>()
private var imageTaskKey: Void?
private var activityIndicatorKey: Void?

extension UIImageView {
    private var imageTask: URLSessionDataTask? {
        get {
            objc_getAssociatedObject(URLSessionDataTask.self, &imageTaskKey) as? URLSessionDataTask
        }
        set {
            objc_setAssociatedObject(URLSessionDataTask.self, &imageTaskKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    private var activityIndicator: UIActivityIndicatorView? {
        get {
            objc_getAssociatedObject(URLSessionDataTask.self, &activityIndicatorKey) as? UIActivityIndicatorView
        }
        set {
            objc_setAssociatedObject(URLSessionDataTask.self, &activityIndicatorKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func loadImage(from url: URL) {
        image = nil
        let cacheKey = url.absoluteString as NSString
        
        if let cachedImage = imageCache.object(forKey: cacheKey)  {
            image = cachedImage
            stopActivityIndicator()
            return
        }
        
        if let activeTask = imageTask {
            activeTask.cancel()
            stopActivityIndicator()
        }
        
        startActivityIndicator()

        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }

            DispatchQueue.main.async {
                defer { self.stopActivityIndicator() }
                guard let image = UIImage(data: data!) else { return }
                
                imageCache.setObject(image, forKey: cacheKey)
                self.image = image
                
            }

        })
        
        task.resume()
    }
}

private extension UIImageView {
    func startActivityIndicator() {
        if self.activityIndicator == nil {
            let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .gray)
            addSubview(activityIndicator)
            self.activityIndicator = activityIndicator
        }
        
        activityIndicator?.startAnimating()
        activityIndicator?.center = self.center
    }
    
    func stopActivityIndicator() {
        activityIndicator?.removeFromSuperview()
        activityIndicator = nil
    }
}
