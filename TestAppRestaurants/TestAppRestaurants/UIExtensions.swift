//
//  UIExtensions.swift
//  TestAppRestaurants
//
//  Created by David V on 3/11/20.
//  Copyright © 2020 davidv. All rights reserved.
//

import UIKit

/** Implementations know their (i.e. reuse or storyboard) identifiers. */
protocol IViewInstantiable {

    /** The story board identifier for this view controller. */
    static var identifier: String { get }
}

extension IViewInstantiable {

static var identifier: String { return String(describing: self) }
}

/** The reuse identifier for the cell. */
extension UITableViewCell: IViewInstantiable { }

extension UITableView {

    func register<T: UITableViewCell>(_ type: T.Type) {
        register(UINib(nibName: String(describing: type), bundle: nil), forCellReuseIdentifier: T.identifier)
    }

    func dequeue<T: UITableViewCell>(_ type: T.Type, indexPath: IndexPath) -> T {
        if let cell = dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as? T {
            return cell
        }
        fatalError("Could not create cell with identifier: \(T.identifier)")
    }
}
