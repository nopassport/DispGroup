//
//  ViewController.swift
//  DispGoup
//
//  Created by Volodymyr D on 19.02.2023.
//

import UIKit


class MainViewController: UIViewController {
    
    private var stackView: UIStackView = {
        let stackView = UIStackView(frame: CGRect(origin: .zero, size: CGSize(width: 260, height: 180)))
        stackView.alignment = .fill
        stackView.spacing = 6
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var buttonSameTime = {
        let button = UIButton()
        button.setTitle("Wait until all are downloaded", for: .normal)
        return button
    }()
    
    private lazy var buttonSingly = {
        let button = UIButton()
        button.setTitle("Load pictures individually", for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStackView()
        
     }
    
    private func setStackView() {
        stackView.center = view.center
        view.addSubview(stackView)
        [buttonSameTime, buttonSingly].enumerated().forEach{ ind, button in
            button.frame = CGRect(origin: .zero, size: CGSize(width: 169, height: 54))
            button.backgroundColor = .red
            button.layer.cornerRadius = 12
            button.tag = ind
            button.titleLabel?.tintColor = .white
            button.addTarget(self, action: #selector(didTapButtom), for: .touchUpInside)
            stackView.addArrangedSubview(button)
            stackView.addArrangedSubview(button)
        }
        
    }
 
    @objc private func didTapButtom(_ sender: UIButton) { 
        let vc = ImagesCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout(),
                                                networkManager: Networking(),
                                                typeLoading: sender.tag == 0 ? .showSimultaneously : .showSingly)
        navigationController?.pushViewController(vc, animated: true)
    }
    
}


 

