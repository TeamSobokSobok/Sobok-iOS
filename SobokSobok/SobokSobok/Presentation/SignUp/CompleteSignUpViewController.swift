//
//  CompleteSignUpViewController.swift
//  SobokSobok
//
//  Created by 김선오 on 2022/01/16.
//

import UIKit

protocol CompleteSingUpProtocol: StyleProtocol {}

final class CompleteSignUpViewController: UIViewController, CompleteSingUpProtocol {

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
    }
    
    func style() {
        navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: - @IBAction Properties
    @IBAction func touchUpToStart(_ sender: UIButton) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.transitionToMainViewController()
        }
    }
    
    func transitionToMainViewController() {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        sceneDelegate?.window?.rootViewController = TabBarController()
        sceneDelegate?.window?.makeKeyAndVisible()
    }
}
