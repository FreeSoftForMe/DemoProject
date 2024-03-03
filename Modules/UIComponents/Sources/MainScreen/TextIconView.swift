//
//  TextIconView.swift
//  UI
//
//  Created by Dmitrii on 3/2/24.
//

import UIKit
import PinLayout
import UIInfrastructure

public final class TextIconView: UIView, ContentView {
    private let label = UILabel()
    private let icon = UIImageView()
    public var props: Props = .empty {
        didSet {
            render()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public override func sizeThatFits(_ size: CGSize) -> CGSize {
        return Self.size(for: size, props: props)
    }
    
    private func commonInit() {
        addSubviews(label, icon)
    }
    
    private func render() {
        let style = props.style
        icon.image = .init(systemName: props.iconName)?.withRenderingMode(.alwaysTemplate)
        icon.tintColor = style.imageColor
        label.attributedText = props.title.attributedString(style.title)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    
    private func layout() {
        let metrics = props.metrics
        icon.pin
            .vCenter()
            .end(metrics.horizontalMargin)
            .size(.init(metrics.iconSize))
        label.pin
            .vCenter()
            .left(metrics.verticalMargin)
            .left(of: icon)
            .marginRight(metrics.verticalMargin)
            .sizeToFit(.width)
    }
    
    public static func size(for size: CGSize, props: Props) -> CGSize {
        let verticalSpacing = props.metrics.verticalMargin * 2
        let titleHeight = props.title.attributedString(props.style.title).estimatedSizeFor(size: size).height
        let totalHeight = verticalSpacing + titleHeight
        return .init(width: size.width, height: totalHeight)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func prepareForReuse() {
        resetViewFrame()
    }
}


public extension TextIconView {
    struct Props: Hashable {
        let title: String
        let iconName: String
        let metrics: Metrics
        let style: Style
        
        public init(title: String,
                    iconName: String = "chevron.right",
                    metrics: Metrics = .default,
                    style: Style = .default) {
            self.title = title
            self.iconName = iconName
            self.metrics = metrics
            self.style = style
        }
        
        public static let empty: Self = .init(title: "",
                                              iconName: "")
    }
    
    struct Metrics: Hashable {
        let horizontalMargin: CGFloat
        let verticalMargin: CGFloat
        let iconSize: CGFloat
        
        public static let `default`: Self = .init(horizontalMargin: .mediumSmallPadding,
                                                  verticalMargin: .mediumSmallPadding,
                                                  iconSize: 24)
    }
    
    struct Style: Hashable {
        let backgroundColor: UIColor
        let imageColor: UIColor
        let title: TextStyle
        
        public static let `default`: Self = .init(backgroundColor: .white,
                                                  imageColor: .gray,
                                                  title: .smallTitle.dsl.lineBreakingMode(NSLineBreakMode.byTruncatingTail))
    }
}

#Preview {
    let view = TextIconView()
    view.props = .init(title: "Hek;jiuhgyf   tdrdrftyuiopoiuytr ehjgfghjkkj  lhgfgllo")
    return view
}
