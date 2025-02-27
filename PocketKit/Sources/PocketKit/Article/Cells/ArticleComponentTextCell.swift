import UIKit

// An object that conforms to this protocol is commonly capable of responding to
// (overridden) events that occur within a PocketTextView nested within a PocketTextCell.
protocol ArticleComponentTextCellDelegate: AnyObject {
    func articleComponentTextCell(_ cell: ArticleComponentTextCell, didShareText: String?)
    func articleComponentTextCell(_ cell: ArticleComponentTextCell, shouldOpenURL url: URL) -> Bool
    func articleComponentTextCell(_ cell: ArticleComponentTextCell, contextMenuConfigurationForURL url: URL) -> UIContextMenuConfiguration?
}

// An object that conforms to this protocol is capable of delegating actions
// commonly performed within the cell, typically interactions with a PocketTextView.
protocol ArticleComponentTextCell: ArticleComponentTextViewDelegate {
    var delegate: ArticleComponentTextCellDelegate? { get set }
}

// Apply default implementations of PocketTextViewDelegate callbacks
// so that this code can be reused across conforming cells.
extension ArticleComponentTextCell {
    func articleComponentTextViewDidSelectShareAction(_ textView: ArticleComponentTextView) {
        let selectedText =  (textView.text as NSString).substring(with: textView.selectedRange)
        delegate?.articleComponentTextCell(self, didShareText: selectedText)
    }

    func articleComponentTextView(_ textView: ArticleComponentTextView, shouldOpenURL url: URL) -> Bool {
        return delegate?.articleComponentTextCell(self, shouldOpenURL: url) ?? true
    }

    func articleComponentTextView(_ textView: ArticleComponentTextView, contextMenuConfigurationForURL url: URL) -> UIContextMenuConfiguration? {
        return delegate?.articleComponentTextCell(self, contextMenuConfigurationForURL: url)
    }
}

// An object that conforms to this protocol is able to respond to (overridden)
// events that occur within a PocketTextView.
protocol ArticleComponentTextViewDelegate: AnyObject {
    func articleComponentTextViewDidSelectShareAction(_ textView: ArticleComponentTextView)
    func articleComponentTextView(_ textView: ArticleComponentTextView, shouldOpenURL url: URL) -> Bool
    func articleComponentTextView(_ textView: ArticleComponentTextView, contextMenuConfigurationForURL url: URL) -> UIContextMenuConfiguration?
}

// A subclass of UITextView that overrides certain actions (e.g Share),
// and delegates the response to these actions to its delegate.
class ArticleComponentTextView: UITextView {
    var actionDelegate: ArticleComponentTextViewDelegate?

    private var urlTextRange: UITextRange?

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)

        backgroundColor = .clear
        textContainerInset = .zero
        self.textContainer.lineFragmentPadding = .zero
        isEditable = false
        isScrollEnabled = false
        delegate = self

        interactions
            .filter { $0 is UIContextMenuInteraction }
            .forEach { removeInteraction($0) }
        addInteraction(UIContextMenuInteraction(delegate: self))
    }

    required init?(coder: NSCoder) {
        fatalError("Unable to instantiate \(Self.self) from xib/storyboard")
    }

    @objc
    func _share(_ sender: Any?) {
        actionDelegate?.articleComponentTextViewDidSelectShareAction(self)
    }
}

extension ArticleComponentTextView: UITextViewDelegate {
    func textView(
        _ textView: UITextView,
        shouldInteractWith URL: URL,
        in characterRange: NSRange,
        interaction: UITextItemInteraction
    ) -> Bool {
        return actionDelegate?.articleComponentTextView(self, shouldOpenURL: URL) ?? true
    }
}

extension ArticleComponentTextView: UIContextMenuInteractionDelegate {
    func contextMenuInteraction(
        _ interaction: UIContextMenuInteraction,
        configurationForMenuAtLocation location: CGPoint
    ) -> UIContextMenuConfiguration? {
        let index = layoutManager.characterIndex(for: location, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        var range = NSRange()
        let attributes = attributedText.attributes(at: index, effectiveRange: &range)
        let start = position(from: beginningOfDocument, offset: range.location)!
        let end = position(from: start, offset: range.length)!
        urlTextRange = textRange(from: start, to: end)!

        if let url = attributes[.link] as? URL {
            return actionDelegate?.articleComponentTextView(self, contextMenuConfigurationForURL: url)
        }

        return nil
    }

    func contextMenuInteraction(
        _ interaction: UIContextMenuInteraction,
        previewForHighlightingMenuWithConfiguration configuration: UIContextMenuConfiguration
    ) -> UITargetedPreview? {
        let previewParameters = UIPreviewParameters()
        previewParameters.backgroundColor = .clear
        let preview = UITargetedPreview(view: self, parameters: previewParameters)
        return preview
    }

    func contextMenuInteraction(
        _ interaction: UIContextMenuInteraction,
        previewForDismissingMenuWithConfiguration configuration: UIContextMenuConfiguration
    ) -> UITargetedPreview? {
        let previewParameters = UIPreviewParameters()
        previewParameters.backgroundColor = .clear
        let preview = UITargetedPreview(view: self, parameters: previewParameters)
        return preview
    }
}
