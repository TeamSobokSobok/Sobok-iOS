//
//  AppleLoginManager.swift
//  SobokSobok
//
//  Created by taekki on 2022/08/16.
//

import UIKit
import AuthenticationServices

protocol AppleLoginManagerDelegate: AnyObject {
    func appleLoginDidComplete(userID: String)
    func appleLoginDidFail()
}

final class AppleLoginManager: NSObject {
    weak var viewController: UIViewController?
    weak var delegate: AppleLoginManagerDelegate?
    
    func configureAppleLoginPresentationAnchorView(_ view: UIViewController) {
        self.viewController = view
    }
}

extension AppleLoginManager: ASAuthorizationControllerPresentationContextProviding {
    
    // 인증창을 띄워야 하는 뷰 반환
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return viewController!.view.window!
    }
}

extension AppleLoginManager: ASAuthorizationControllerDelegate {
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let credential = authorization.credential as? ASAuthorizationAppleIDCredential {

            let userID = credential.user
            delegate?.appleLoginDidComplete(userID: userID)
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        delegate?.appleLoginDidFail()
    }
}
