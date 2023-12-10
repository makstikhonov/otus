//
//  ButtonView.swift
//  SwiftUIStudy
//
//  Created by Mакс T on 10.12.2023.
//

import UIKit

protocol ButtonViewDelegate: AnyObject {
    func didButtonTap()
}

final class ButtonView: UIView {
    weak var delegate: ButtonViewDelegate?
    var text: String? {
        didSet {
            button.setTitle(text ?? "OK", for: .normal)
        }
    }
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("OK", for: .normal)
        button.addTarget(self, action: #selector(didTap), for: .touchUpInside)
        button.backgroundColor = .systemBlue
        return button
    }()
    
    @objc private func didTap() {
        delegate?.didButtonTap()
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
        ])
    }
}
