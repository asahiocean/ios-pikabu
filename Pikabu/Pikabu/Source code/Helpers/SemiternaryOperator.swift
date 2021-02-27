import Foundation

infix operator ?> : TernaryPrecedence
/// Semi-ternary operator with termination only for a positive value
/// - Parameters:
///   - iftrue: condition must be true
///   - doit: function to be performed
func ?>(iftrue: Bool, doit: Void) { iftrue ? doit : nil }
