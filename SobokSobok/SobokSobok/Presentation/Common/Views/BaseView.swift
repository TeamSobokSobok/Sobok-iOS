//
//  BaseView.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/04/29.
//

import UIKit

class BaseView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupView() {}
    func setupConstraints() {}
}
