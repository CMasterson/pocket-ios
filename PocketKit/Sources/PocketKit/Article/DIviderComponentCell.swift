import UIKit


class DividerComponentCell: UICollectionViewCell {
    private struct Constants {
        static let dividerHeight: CGFloat = 1
    }
    
    private lazy var dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(.ui.grey6)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(dividerView)
        
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dividerView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            dividerView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            dividerView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            dividerView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unable to instantiate \(Self.self) from xib/storyboard")
    }
}
