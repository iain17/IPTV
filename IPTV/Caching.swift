//
//  Caching.swift
//  IPTV
//
//  Created by Iain Munro on 02/04/2017.
//  Copyright © 2017 Iain Munro. All rights reserved.
//

import Foundation
import Foundation
import UIKit

/**
 This class contains the sharedCache used for the images.
 */
class Caching {
    /// Static constant variable with our cache.
    static let sharedCache: NSCache = { () -> NSCache<AnyObject, AnyObject> in
        let cache = NSCache<AnyObject, AnyObject>()
        cache.name = "IPTV"
        return cache
    }()
}

/**
 This extension is used to cache the ad images.
 */
extension URL {
    /// Defines the method signature of the on completion methods.
    typealias ImageCacheCompletion = (UIImage) -> Void
    /// Holds the callbacks. URI as key.
    fileprivate static var callbacks = [String: [ImageCacheCompletion]]()
    /// Returns the cache key of a URL instance.
    func getCacheKey() -> String {
        return self.absoluteString // self.lastPathComponent!
    }
    
    /// Retrieves a pre-cached image, or nil if it isn't cached.
    /// You should call this before calling fetchImage.
    var cachedImage: UIImage? {
        return Caching.sharedCache.object(
            forKey: getCacheKey() as AnyObject) as? UIImage
    }
    
    /**
     Fetches the image from the network.
     Stores it in the cache if successful.
     Only calls completion on successful image download.
     Completion is called on the main thread.
     */
    func fetchImage(_ completion: @escaping ImageCacheCompletion) {
        
        if URL.callbacks[self.getCacheKey()] == nil {
            // create it.
            URL.callbacks[self.getCacheKey()] = [ImageCacheCompletion]()
            
            let task = URLSession.shared.dataTask(with: self, completionHandler: {
                data, response, error in
                if error == nil {
                    if let data = data, let image = UIImage(data: data) {
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            Caching.sharedCache.setObject(image, forKey: self.getCacheKey() as AnyObject, cost: data.count)
                            
                            for callback in URL.callbacks[self.getCacheKey()]! {
                                callback(image)
                            }
                            // Reset it. So that if the Cache decides the remove this image. We'll be able to download it again.
                            URL.callbacks[self.getCacheKey()] = nil
                        }
                    }
                }
            })
            task.resume()
        }
        // Add to the list of images we need to call when we have the requested result.
        URL.callbacks[self.getCacheKey()]!.append(completion)
    }
}

/**
 This extension is used to cache the ad images.
 */
public extension UIImageView {
    /// The last url that an instance of the imageView has asked for.
    fileprivate static var currentUrl = [UIImageView: URL]()
    
    /**
     This method will kick off the caching process. It will start fetching the image if it isn't already being downloaded or in the cache and eventually call set the self.image.
     */
    func cacheSetImageFromURL(_ url: URL, completion handler: ((Bool) -> Swift.Void)? = nil) {
        
        if UIImageView.currentUrl[self] == url {
            return
        }
        
        if let campaignImage = url.cachedImage {
            // Cached
            self.image = campaignImage
            
            // Clear up after ourselves.
            UIImageView.currentUrl[self] = nil
            
        } else {
            // Set this url as the last url we've asked for.
            UIImageView.currentUrl[self] = url
            
            url.fetchImage({ downloadedImage in
                // In some cases this fetchImage call gets called very quickly if people scroll very quickly.
                // This check here, makes sure that the response we are getting for this image, is actually the one he has last requested.
                if UIImageView.currentUrl[self] != url {
                    return
                }
                
                self.image = downloadedImage
                handler?(true)
            })
        }
    }
}
