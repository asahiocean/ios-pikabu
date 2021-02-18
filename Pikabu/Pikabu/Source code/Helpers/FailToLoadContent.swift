import UIKit

func failContent(center view: UIView) -> UILabel {
    let label = UILabel()
    label.numberOfLines = 0
    label.textAlignment = .center
    label.textColor = .darkGray
    label.text = "Кажется, не удалось загрузить контент :(\nМы пытаемся это починить!"
    label.sizeToFit()
    return label
}
