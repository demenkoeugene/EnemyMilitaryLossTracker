//
//  SplashViewController.swift
//  MacPawBootCampDemenko
//
//  Created by Eugene Demenko on 25.08.2023.
//

import UIKit

class SplashViewController: UIViewController {
    private let backgroundImageNames = ["logo-macpaw"]
    private var currentImageIndex = 0
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "by Yevhenii Demenko for"
        label.font = UIFont.systemFont(ofSize: 18)
        label.alpha = 0
        label.textAlignment = .center
        label.numberOfLines = 2 
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        [backgroundImageView, label].forEach { view.addSubview($0) }
        setupConstraints()
        animateImages()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backgroundImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20),
            backgroundImageView.widthAnchor.constraint(equalToConstant: 300),
            backgroundImageView.heightAnchor.constraint(equalToConstant: 400),
            
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.bottomAnchor.constraint(equalTo: backgroundImageView.topAnchor, constant: 0)
        ])
    }
    
    private struct AnimationConstants {
        static let scale: CGFloat = 0.65
        static let imageDuration: TimeInterval = 2.0
        static let labelDuration: TimeInterval = 1.0
        static let transitionDelay: TimeInterval = 1.5
    }
    
    private func animateImages() {
        guard currentImageIndex < backgroundImageNames.count else {
            transitionToTabbarController()
            return
        }
        
        backgroundImageView.image = UIImage(named: backgroundImageNames[currentImageIndex])
        backgroundImageView.transform = .init(scaleX: AnimationConstants.scale, y: AnimationConstants.scale)
        
        UIView.animate(withDuration: AnimationConstants.imageDuration, delay: 0, options: .curveEaseOut) { [weak self] in
            self?.backgroundImageView.transform = .identity
        } completion: { [weak self] _ in
            self?.animateLabel()
        }
    }
    
    private func animateLabel() {
        UIView.animate(withDuration: AnimationConstants.labelDuration) { [weak self] in
            self?.label.alpha = 1
        } completion: { [weak self] _ in
            self?.backgroundImageView.delay(AnimationConstants.transitionDelay) { [weak self] in
                self?.currentImageIndex += 1
                self?.animateImages()
            }
        }
    }
    
    private func transitionToTabbarController() {
        let tabBarController = TabbarController()
        tabBarController.modalPresentationStyle = .fullScreen
        present(tabBarController, animated: true, completion: nil)
    }
}

extension UIView {
    func delay(_ delay: TimeInterval, closure: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: closure)
    }
}
