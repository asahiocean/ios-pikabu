import Foundation
import UIKit

/// Delegate for communication between TopBar and CollectionView in profile
///
/// Moving the indicator to the required point
/// ```
/// func move(to: CGPoint)
/// ```
/// Switch to cell with required IndexPath
/// ```
/// func tabIndex(i index: IndexPath)
/// ```
protocol TBDelegate: class {
    func move(to: CGPoint)
    func tabIndex(i index: IndexPath)
}

/// Delegate to switch the position of collection view cells
protocol PageDelegate: class {
    func page(i indexPath: IndexPath)
}
