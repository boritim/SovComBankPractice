//
//  DefaultButton.swift
//  SCBMonitorSwift
//
//  Created by ANTON DOBRYNIN on 04.07.2022.
//

import UIKit

final class DefaultButton: UIButton {
        
    override var isHighlighted: Bool {
        didSet {
            transformAnimation(duration: isHighlighted ? 0.2 : 0.1, isHighlighted: isHighlighted)
        }
    }
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Private
private extension DefaultButton {
    
    enum Const {
        static let height: CGFloat = 48
    }
    
    func setup() {
        backgroundColor = MColors.spray
        layer.cornerRadius = Const.height / 2 
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
        
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: Const.height).isActive = true
    }
    
    func transformAnimation(duration: CGFloat, isHighlighted: Bool) {
        UIView.animate(withDuration: duration) {
            self.transform = isHighlighted ? CGAffineTransform(scaleX: 0.96, y: 0.96) : CGAffineTransform.identity
        }
    }
}
