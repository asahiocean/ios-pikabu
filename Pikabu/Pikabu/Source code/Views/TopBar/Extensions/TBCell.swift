import UIKit

extension TopBar {
    /// Top Bar Cell
    internal class TBCell: UICollectionViewCell {
        
        weak var label: UILabel!
        
        override var isHighlighted: Bool {
            didSet {
                let v = isHighlighted // value
                let c = TBColors.isHighlighted.self // color
                backgroundColor = v ? c.true.bg : c.false.bg
                label.textColor = v ? c.true.text : c.false.text
            }
        }
        
        override var isSelected: Bool {
            didSet {
                let v = isSelected // value
                let c = TBColors.isSelected.self // color
                backgroundColor = v ? c.true.bg : c.false.bg
                label.textColor = v ? c.true.text : c.false.text
            }
        }
        
        fileprivate func setup() {
            //MARK: - Label Setup -
            let label = UILabel()
            label.textColor = TBColors.text
            label.textAlignment = .center
            self.addSubview(label)
            label.constraints(in: self, .all)
            self.label = label
            
            // cell are initially deactivated upon initialization
            // to highlight the required later
            self.isSelected = false
        }
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            self.setup()
        }
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            self.setup()
        }
    }
}
