//
//  NavigationHeaderView.swift
//  SobokSobok
//
//  Created by 정은희 on 2022/05/01.
//

import UIKit

import SnapKit
import Then

final class NavigationHeaderView: BaseView {
    
    enum NavigationMode: Int, CaseIterable {
        case back
        case next
    }
    
    // MARK: - Properties
    private var mode: NavigationMode
    private var title: String
    private let navigationButton = UIButton().then {
        $0.contentMode = .scaleAspectFit
        $0.setImage(Image.icBack48, for: .normal)
    }
    private let navigationTitle = UILabel().then {
        $0.font = UIFont.font(.pretendardRegular, ofSize: 17)
    }
    
    // MARK: - Initialization
    init(frame: CGRect, mode: NavigationMode, title: String) {
        self.mode = mode
        self.title = title
        
        super.init(frame: frame)
        
        setupMode(mode: mode)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func setupView() {
        super.setupView()
        
        addSubviews(navigationButton, navigationTitle)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        self.snp.makeConstraints { make in
            make.width.equalTo(UIScreen.main.bounds.width)
            make.height.equalTo(102)
        }
        navigationButton.snp.makeConstraints { make in
            make.width.height.equalTo(48)
            make.top.equalToSuperview().offset(45)
            make.leading.equalToSuperview().offset(1)
        }
        navigationTitle.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(navigationButton)
        }
    }
    
    private func setupMode(mode: NavigationMode) {
        self.mode = mode
        switch self.mode {
        case .back:
            navigationButton.setImage(Image.icBack48, for: .normal)
            navigationTitle.text = title
        case .next:
            navigationButton.setImage(Image.icNext16, for: .normal)
            navigationTitle.text = title
        }
    }
}
