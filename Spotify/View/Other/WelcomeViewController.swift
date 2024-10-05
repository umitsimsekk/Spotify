//
//  WelcomeViewController.swift
//  Spotify
//
//  Created by Ümit Şimşek on 3.10.2024.
//

import UIKit

class WelcomeViewController: UIViewController {
    private let signInButton: UIButton = {
       let btn = UIButton()
        btn.backgroundColor = .white
        btn.setTitle("Sign In With Spotify", for: .normal)
        btn.setTitleColor(.blue, for: .normal)
        return btn
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .darkGray
        title = "Spotify"
        view.addSubview(signInButton)
        signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        signInButton.frame = CGRect(x: 20,
                                    y: view.height-50-view.safeAreaInsets.bottom,
                                    width: view.width-40,
                                    height: 50)
    }
    @objc func didTapSignIn() {
        let vc = AuthViewController()
        vc.completionHandler = { [weak self] success in
            DispatchQueue.main.async {
                self?.handleSignIn(success: success)
            }
            
        }
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: false)
    }
    
    private func handleSignIn(success : Bool) {
        //Log user in or error
    }

}
