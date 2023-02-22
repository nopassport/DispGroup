//
//  ImagesCollectionViewController.swift
//  DispGoup
//
//  Created by Volodymyr D on 20.02.2023.
//

import UIKit

enum TypeLoading{ case showSimultaneously, showSingly }

class ImagesCollectionViewController: UICollectionViewController {
    
    private var networking: NetworkingDelegate!
    private var typeLoading: TypeLoading!
    
    private var images = [UIImage](){
        didSet{ collectionView.reloadData() }
    }
    
    
    convenience init(collectionViewLayout: UICollectionViewLayout, networkManager: NetworkingDelegate, typeLoading: TypeLoading) {
        self.init(collectionViewLayout: collectionViewLayout)
        self.networking = networkManager
        self.typeLoading = typeLoading
    }
    
    let spiner = UIActivityIndicatorView(style: .large)
    

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSpiner()
        view.backgroundColor = .red
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: "item")
        setLayoutForCollectionView()
        loadData()
    }
    
    private func loadData() {
        guard typeLoading == .showSimultaneously else { return }
        networking.loadImagesFrom(addresses: addressesOfImage) { [unowned self] res in
            switch res {
            case .success(let images):
                self.images = images
                self.spiner.stopAnimating()
            case .failure(let failure):
                print(failure.localizedDescription)
                self.spiner.stopAnimating()
            }
        }
    }
    
    private func setSpiner() {
        guard typeLoading == .showSimultaneously else { return }
        view.addSubview(spiner)
        spiner.center = view.center
        spiner.startAnimating()
        
    }
    
    private func setLayoutForCollectionView() {
        let layout = (collectionViewLayout as! UICollectionViewFlowLayout)
        layout.itemSize = CGSize(width: (self.view.bounds.width / 3) - 1,
                                 height: self.view.bounds.width / 2)
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch typeLoading {
        case .showSimultaneously:
            return images.count
        case .showSingly:
            return addressesOfImage.count
        default: return 0
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "item", for: indexPath) as! ImageCollectionViewCell
        switch typeLoading {
        case .showSimultaneously:
            cell.set(image: images[indexPath.row])
        case .showSingly:
            networking.loadImage(fromAddress: addressesOfImage[indexPath.row]) {
                cell.set(image: $0)
            }
        default: break
        }
        return cell
    }

}





let addressesOfImage = [
"https://images.pexels.com/photos/2246476/pexels-photo-2246476.jpeg",
"https://images.pexels.com/photos/325185/pexels-photo-325185.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
"https://images.pexels.com/photos/1408221/pexels-photo-1408221.jpeg",
"https://images.pexels.com/photos/844297/pexels-photo-844297.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
"https://images.pexels.com/photos/2559941/pexels-photo-2559941.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
"https://images.pexels.com/photos/461940/pexels-photo-461940.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
"https://images.pexels.com/photos/2693529/pexels-photo-2693529.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
"https://images.pexels.com/photos/2356045/pexels-photo-2356045.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",

]
