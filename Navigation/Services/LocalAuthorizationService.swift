//
//  LocalAuthorizationService.swift
//  Navigation
//
//  Created by Дмитрий Снигирев on 12.03.2024.
//

import Foundation
import LocalAuthentication


final class LocalAuthorizationService {
    
    enum BiometryType {
        case faceID
        case touchID
        case none
        
        var image: String {
            switch self {
            case .faceID:
                return "faceid"
            case .touchID:
                return "touchid"
            case .none:
                return "false"
            }
        }
    }
    
    var avaliableBiometryType: BiometryType {
        get {
            switch context.biometryType {
            case .faceID:
                return .faceID
            case .touchID:
                return .touchID
            case .none:
                return .none
            default:
                print("Error occured while gathering device biometry type")
                return .none
            }
        }
    }
    
    let context = LAContext()
    private var canEvaluatePolicy = false
    private var policy = LAPolicy.deviceOwnerAuthenticationWithBiometrics
    
    init() {
        
        var error: NSError? = nil
        canEvaluatePolicy = context.canEvaluatePolicy(policy, error: &error)
        
        if error != nil {
            print(error!)
        }
    }
    
    func authorizeIfPossible(_ authorizationFinished: @escaping (Bool, Error?) -> Void) {
        
        guard canEvaluatePolicy else { return }
        
        context.evaluatePolicy(policy, localizedReason: NSLocalizedString("biomRequest", comment: ""), reply: { success, error in
            
            if success {
                authorizationFinished(true, nil)
            } else {
                authorizationFinished(false, error)
                print(error.debugDescription)
            }
        })
        
    }
    
}
