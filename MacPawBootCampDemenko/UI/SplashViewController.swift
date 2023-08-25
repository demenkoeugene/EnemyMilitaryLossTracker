//
//  SplashViewController.swift
//  MacPawBootCampDemenko
//
//  Created by Eugene Demenko on 25.08.2023.
//

import UIKit

class SplashViewController: UIViewController {
    
    private let backgroundImageNames = ["logo-macpaw"] // Replace with your image names
    private var currentImageIndex = 0
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit // Adjust content mode as needed
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "by Yevhenii Demenko for"
        label.font = UIFont.systemFont(ofSize: 16)
        label.alpha = 0 // Make the label initially transparent
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(backgroundImageView)
        view.addSubview(label)
        
        // Add constraints to center the image view and set a fixed size
        NSLayoutConstraint.activate([
            backgroundImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backgroundImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            backgroundImageView.widthAnchor.constraint(equalToConstant: 300),
            backgroundImageView.heightAnchor.constraint(equalToConstant: 300),
            
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.bottomAnchor.constraint(equalTo: backgroundImageView.topAnchor, constant: -10)
        ])
        
        animateImages()
    }
    
    private func animateImages() {
        guard currentImageIndex < backgroundImageNames.count else {
            transitionToTabbarController()
            return
        }
        
        let imageName = backgroundImageNames[currentImageIndex]
        backgroundImageView.image = UIImage(named: imageName)
        
        backgroundImageView.transform = CGAffineTransform(scaleX: 0.65, y: 0.65)
        UIView.animate(withDuration: 2.0, delay: 0, options: .curveEaseOut, animations: { [weak self] in
            self?.backgroundImageView.transform = .identity
        }) { [weak self] (_) in
            self?.animateLabel()
        }
    }
    
    private func animateLabel() {
        UIView.animate(withDuration: 1.0, animations: { [weak self] in
            self?.label.alpha = 1.0
        }) { [weak self] (_) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
                self?.currentImageIndex += 1
                self?.animateImages()
            }
        }
    }
    
    private func transitionToTabbarController() {
        let tabBarController = TabbarController()
        tabBarController.modalPresentationStyle = .fullScreen
        self.present(tabBarController, animated: true, completion: nil)
    }
}
