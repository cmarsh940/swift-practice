//
//  ContentView.swift
//  Cache_Practice
//
//  Created by Cam on 8/23/21.
//

import SwiftUI

class CacheManager {
    static let instance = CacheManager() // Singleton
    
//    Create a private init to make sure you cant create a new instance of the singleton anywhere else in project
    private init() { }
    
    var imageCache: NSCache<NSString, UIImage> = {
       let cache = NSCache<NSString, UIImage>()
//        put a count limit on cache to make sure it emptys before max limit is reached
        cache.countLimit = 100
        
//        set the cache total limit before it emptys
        cache.totalCostLimit = 1024 * 1024 * 100 // 100mb
        return cache
    }()
    
    func add(image: UIImage, name: String) -> String {
        imageCache.setObject(image, forKey: name as NSString)
        return "Added to cache!"
    }
    
    func remove(name: String) -> String{
        imageCache.removeObject(forKey: name as NSString)
        return "Removed from cache!"
    }
    
    func get(name: String) -> UIImage? {
        return imageCache.object(forKey: name as NSString)
    }
}

class CacheViewModel: ObservableObject {
    @Published var startingImage: UIImage? = nil
    @Published var cachedImage:UIImage? = nil
    @Published var message: String = ""
    
    let imageName: String = "IMG_5359"
    let manager = CacheManager.instance
    
    
    init() {
        getImageFromAssetsFolder()
    }
    
    func getImageFromAssetsFolder() {
        startingImage = UIImage(named: imageName)
    }
    
    func saveToCache() {
        guard let image = startingImage else { return }
        message = manager.add(image: image, name: imageName)
    }
    
    func removeFromCache() {
        message = manager.remove(name: imageName)
    }
    
    func getFromCache() {
        if let returnedImage = manager.get(name: imageName) {
            cachedImage = returnedImage
            message = "Got image from cache"
        } else {
            message = "Image not found in cache"
        }
    }
}


struct ContentView: View {
    
    @StateObject var vm = CacheViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if let image = vm.startingImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .clipped()
                        .cornerRadius(10)
                }
                Text(vm.message)
                    .font(.headline)
                    .foregroundColor(.orange)
                HStack {
                    Button(action: {
                        vm.saveToCache()
                    }, label: {
                        Text("Save to cache")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    })
                    Button(action: {
                        vm.removeFromCache()
                    }, label: {
                        Text("Delte from cache")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.red)
                            .cornerRadius(10)
                    })
                }
                
                Button(action: {
                    vm.getFromCache()
                }, label: {
                    Text("Get from cache")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(10)
                })
                
                
                if let image = vm.cachedImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .clipped()
                        .cornerRadius(10)
                }
                
                
                Spacer()
            }
            .navigationTitle("Cache Practice")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
