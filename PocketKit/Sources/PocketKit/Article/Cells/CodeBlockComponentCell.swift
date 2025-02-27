import UIKit

class CodeBlockComponentCell: UICollectionViewCell, ArticleComponentTextCell, ArticleComponentTextViewDelegate {
    struct Constants {
        static let contentInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }

    private var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(.ui.grey5).cgColor
        view.backgroundColor = UIColor(.ui.grey6)
        view.contentInset = Constants.contentInset
        return view
    }()

    lazy var textView: ArticleComponentTextView = {
        let view = ArticleComponentTextView()
        view.dataDetectorTypes = []
        view.actionDelegate = self
        return view
    }()

    weak var delegate: ArticleComponentTextCellDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubview(scrollView)
        scrollView.addSubview(textView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        textView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: contentView.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            textView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            textView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            textView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            textView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("Unable to instantiate \(Self.self) from xib/storyboard")
    }
}
