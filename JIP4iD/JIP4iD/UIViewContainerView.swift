import SwiftUI

public class UIViewContainerView<ContentView: UIView>: UIView {
    private var contentView: ContentView? {
        willSet {
            contentView?.removeFromSuperview()
        }
        didSet {
            if let contentView: ContentView = contentView {
                addSubview(contentView)
                contentView.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
                    contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
                    contentView.topAnchor.constraint(equalTo: topAnchor),
                    contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
                ])
            }
        }
    }
}
