//
//  UIStoryboard+Extension.swift
//  StanwoodCore
//
//  Created by Tal Zion on 27/12/2017.
//  Copyright © 2017 stanwood GmbH. All rights reserved.
//

import Foundation

extension UIStoryboard {
    
    open func instantiate<Element: UIViewController>(viewController type: Element.Type) -> Element {
        guard let viewController = instantiateViewController(withIdentifier: type.identifier) as? Element else {
            fatalError("Cannot instantiate viewController of type: \(type.identifier)")
        }
        return viewController
    }
}
