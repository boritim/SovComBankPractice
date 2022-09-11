//
//  UIView+Embed.swift
//  SCBMonitorSwift
//
//  Created by Renat Murtazin on 12.07.2022.
//

import UIKit

extension UIView {

    struct EmbedInsets {
        let top: CGFloat?
        let left: CGFloat?
        let bottom: CGFloat?
        let right: CGFloat?
        
        init(top: CGFloat? = nil, left: CGFloat? = nil, bottom: CGFloat? = nil, right: CGFloat? = nil) {
            self.top = top
            self.left = left
            self.bottom = bottom
            self.right = right
        }
        
        static let zero: EmbedInsets = EmbedInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        static func all(_ distance: CGFloat) -> EmbedInsets { EmbedInsets(top: distance, left: distance, bottom: distance, right: distance) }
    }

    func embed(in container: UIView, using layoutGuide: UILayoutGuide? = nil, insets: EmbedInsets = .zero) {
        self.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(self)
        
        let topAnchor = layoutGuide?.topAnchor ?? container.topAnchor
        let leftAnchor = layoutGuide?.leftAnchor ?? container.leftAnchor
        let bottomAnchor = layoutGuide?.bottomAnchor ?? container.bottomAnchor
        let rightAnchor = layoutGuide?.rightAnchor ?? container.rightAnchor
        
        if let top = insets.top {
            self.topAnchor.constraint(equalTo: topAnchor, constant: top).isActive = true
        }
        if let left = insets.left {
            self.leftAnchor.constraint(equalTo: leftAnchor, constant: left).isActive = true
        }
        if let bottom = insets.bottom {
            bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: bottom).isActive = true
        }
        if let right = insets.right {
            rightAnchor.constraint(equalTo: self.rightAnchor, constant: right).isActive = true
        }
    }
}
