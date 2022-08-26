//
//  SBIndicator.swift
//  SobokSobok
//
//  Created by taekki on 2022/08/24.
//

import UIKit

import Lottie
import SnapKit
import Then

final class SBIndicator: BaseView {
    
    static let shared = SBIndicator()
    
    private let contentView = UIView().then {
        $0.backgroundColor = .white
        $0.alpha = 0
    }
    
    private let loadingView = AnimationView(name: "loading").then {
        $0.loopMode = .loop
    }
    
    override func setupConstraints() {
        self.backgroundColor = .black.withAlphaComponent(0.3)
        
        self.addSubview(self.contentView)
        self.contentView.addSubview(self.loadingView)
        
        self.contentView.snp.makeConstraints {
            $0.center.equalTo(self.safeAreaLayoutGuide)
        }
        self.loadingView.snp.makeConstraints {
            $0.center.equalTo(self.safeAreaLayoutGuide)
            $0.size.equalTo(300)
        }
    }
    
    func show() {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        guard let sceneDelegate = windowScene?.delegate as? SceneDelegate else { return }
        
        guard !(sceneDelegate.window?.subviews.contains(where: { $0 is SBIndicator }))! else { return }
        sceneDelegate.window?.addSubview(self)
        self.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        self.layoutIfNeeded()
        
        self.loadingView.play()
        UIView.animate(
          withDuration: 0.7,
          animations: { self.contentView.alpha = 1 }
        )
    }
    
    func hide(completion: @escaping () -> () = {}) {
        self.loadingView.stop()
        self.removeFromSuperview()
        completion()
    }

}
