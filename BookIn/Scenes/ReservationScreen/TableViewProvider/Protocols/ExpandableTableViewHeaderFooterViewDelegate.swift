import Foundation

protocol ExpandableTableViewHeaderFooterViewDelegate: AnyObject {
    func toggleHeaderView(from section: Int)
}
