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
    case localHost = "LocalHost"
    case localHostProd = "LocalHostProd"
    
    var appID: String {
        switch self {
        case .development, .localHost:
            return "debtDestroyerDevelopment13749495030"
        case .production, .localHostProd:
            return "debtDestroyerProduction58694069"
        }
    }
    
    var serverURL: String {
        switch self {
        case .development:
            return "https://debt-destroyer-development.herokuapp.com/parse"
        case .production:
            return "https://debt-destroyer-production.herokuapp.com/parse"
        case .localHost, .localHostProd:
            return "https://debtdestroyer.ngrok.io/parse"
        }
    }
}

class Configuration {
    static var environment: Environment = {
        return .production
    }()
}
