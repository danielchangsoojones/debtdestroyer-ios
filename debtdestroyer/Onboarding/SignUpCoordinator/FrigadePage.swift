//
//  FrigadePage.swift
//  debtdestroyer
//
//  Created by Christian Mathiesen on 2/8/23.
//

import Foundation
import UIKit
import Frigade

class FrigadePage: UIViewController {

    func getPageData() -> FlowModel? {
        let pages = FrigadeHelper.shared.signUpFlow?.getData() ?? []
        if (pages.indices.contains(SignUpCoordinator.shared.currentIndex)) {
            let page = pages[SignUpCoordinator.shared.currentIndex]
            return page
        }

        return nil
    }

    func next() {
        SignUpCoordinator.shared.next(self)
    }

    func back() {
        SignUpCoordinator.shared.back(self)
    }
}
