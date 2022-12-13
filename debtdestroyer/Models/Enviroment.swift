//
//  Enviroment.swift
//  debtdestroyer
//
//  Created by Daniel Jones on 8/3/22.
//

import Foundation

public enum Environment: String {
    case development = "Development"
    case production = "Production"
//    case localHost = "LocalHost"
    
    var appID: String {
        switch self {
        case .development:
            return "debtDestroyerDevelopment13749495030"
        case .production:
            return "debtDestroyerProduction58694069"
        }
    }
    
    var serverURL: String {
        switch self {
        case .development:
            return "https://debt-destroyer-development.herokuapp.com/parse"
        case .production:
            return "https://debt-destroyer-production.herokuapp.com/parse"
//        case .localHost:
//            return "https://nbawidgetdev.ngrok.io/parse"
        }
    }
}

class Configuration {
    static var environment: Environment = {
        return .development
    }()
}
