import CoreGraphics

public enum LineBreakMode {
    case byTruncatingTail
    case none
}

public enum LineHeight {
    case explicit(CGFloat)
    case multiplier(CGFloat)
}

public struct ParagraphStyle {
    public let alignment: TextAlignment
    public let lineBreakMode: LineBreakMode
    public let lineSpacing: CGFloat?
    public let lineHeight: LineHeight?
    public let verticalAlignment: VerticalTextAlignment

    public init(
        alignment: TextAlignment,
        lineBreakMode: LineBreakMode = .none,
        lineSpacing: CGFloat? = nil,
        lineHeight: LineHeight? = nil,
        verticalAlignment: VerticalTextAlignment = .default
    ) {
        self.alignment = alignment
        self.lineBreakMode = lineBreakMode
        self.lineSpacing = lineSpacing
        self.lineHeight = lineHeight
        self.verticalAlignment = verticalAlignment
    }

    public func with(alignment: TextAlignment) -> ParagraphStyle {
        return ParagraphStyle(alignment: alignment, lineBreakMode: lineBreakMode, lineSpacing: lineSpacing, lineHeight: lineHeight, verticalAlignment: verticalAlignment)
    }

    public func with(lineBreakMode: LineBreakMode) -> ParagraphStyle {
        return ParagraphStyle(alignment: alignment, lineBreakMode: lineBreakMode, lineSpacing: lineSpacing, lineHeight: lineHeight, verticalAlignment: verticalAlignment)
    }

    public func with(lineSpacing: CGFloat?) -> ParagraphStyle {
        return ParagraphStyle(alignment: alignment, lineBreakMode: lineBreakMode, lineSpacing: lineSpacing, lineHeight: lineHeight, verticalAlignment: verticalAlignment)
    }

    public func with(lineHeight: LineHeight?) -> ParagraphStyle {
        return ParagraphStyle(alignment: alignment, lineBreakMode: lineBreakMode, lineSpacing: lineSpacing, lineHeight: lineHeight, verticalAlignment: verticalAlignment)
    }

    public func with(verticalAlignment: VerticalTextAlignment) -> ParagraphStyle {
        return ParagraphStyle(alignment: alignment, lineBreakMode: lineBreakMode, lineSpacing: lineSpacing, lineHeight: lineHeight, verticalAlignment: verticalAlignment)
    }
}
