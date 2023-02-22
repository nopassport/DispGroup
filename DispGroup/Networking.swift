//
//  Networking.swift
//  DispGoup
//
//  Created by Volodymyr D on 20.02.2023.
//

import UIKit


protocol NetworkingDelegate{
    func loadImagesFrom(addresses: [String], compl: @escaping (Result<[UIImage], Error>) -> Void)
    func loadImage(fromAddress address: String, compl: @escaping (UIImage?) -> Void)
}

class Networking: NetworkingDelegate {
    
    private let custDispatch = DispatchQueue(label: "CustDis", qos: .utility)
    private let custDispGroup = DispatchGroup()
    
    public func loadImagesFrom(addresses: [String], compl: @escaping (Result<[UIImage], Error>) -> Void) {
        var images = [UIImage]()
        
        custDispatch.async(group: custDispGroup) {
            addresses.forEach{ address in
                if let url = URL(string: address)   {
                    do {
                        let data = try Data(contentsOf: url)
                        guard let image = UIImage(data: data) else { return }
                        images.append(image)
                    }catch {
                        compl(.failure(error))
                    }
                }
            }
        }
        custDispGroup.notify(queue: .main) {
            compl(.success(images))
        }
    }
    
    public func loadImage(fromAddress address: String, compl: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: address) else { return }
        custDispatch.async {
            guard let data = try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async {
                compl(UIImage(data: data))
            }
        }
    }
    
    
    
    
}
