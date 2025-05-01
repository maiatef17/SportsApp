//
//  SplashViewController.swift
//  SportsApp
//
//  Created by Mai Atef  on 01/05/2025.
//

import UIKit

class SplashViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGreen
        
        setupLogo()
        navigateToHome()
    }
    
    private func setupLogo() {
        let logo = UIImageView(image: UIImage(named: "logo"))
        logo.contentMode = .scaleAspectFit
        logo.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(logo)
        
        NSLayoutConstraint.activate([
            logo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logo.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            logo.widthAnchor.constraint(equalToConstant: 250),
            logo.heightAnchor.constraint(equalToConstant: 250)
        ])
    }
    
    private func navigateToHome() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let tabBar = storyboard.instantiateViewController(withIdentifier: "tabBar")
            tabBar.modalPresentationStyle = .fullScreen
            self.present(tabBar, animated: true, completion: nil)
        }
    }
}
