//
//  homepage.swift
//  scannercode
//
//  Created by Hibah Abdullah Alatawi on 24/07/1444 AH.
//

import UIKit
import AuthenticationServices
import SwiftUI
class homepage: UIViewController {
    
    private let signInButton = ASAuthorizationAppleIDButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(signInButton)
        signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        signInButton.frame=CGRect(x:0, y:0 , width: 250 , height:50 )
        signInButton.center = view.center
    }
    @objc func didTapSignIn() {
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate=self
        controller.presentationContextProvider = self
        controller.performRequests()
        
    }
}
extension homepage: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
     print(" Failde ")
    }
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential{
        case let credentials as ASAuthorizationAppleIDCredential:
            let fiestName = credentials.fullName?.givenName
            let lastName = credentials.fullName?.givenName
            let email = credentials.email
            break
        default:
            break
    
        }
    }
}
extension homepage: ASAuthorizationControllerPresentationContextProviding{
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return view.window!
    }
}
