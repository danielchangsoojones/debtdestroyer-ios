//
//  ConfigurationParse.swift
//  debtdestroyer
//
//  Created by Daniel Jones on 2/26/23.
//

import Foundation
import Parse

class ConfigurationParse: SuperParseObject, PFSubclassing {
    @NSManaged var onboardingOrder: [String]

    class func parseClassName() -> String {
        return "ConfigurationParse"
    }
}
