//
//  CalendarTopView.swift
//  SobokSobok
//
//  Created by taehy.k on 2022/06/20.
//

import UIKit

enum CalendarScopeState {
    case month, week
}

protocol CalendarTopViewDelegate: AnyObject {
    func calendarTopView(scope: CalendarScopeState)
}

final class CalendarTopView: BaseView {
    
    // MARK: - Properties
    
    var scopeState: CalendarScopeState = .week
    weak var delegate: CalendarTopViewDelegate?
    
    // MARK: - UI Properties
    
    lazy var dateLabel = UILabel().then {
        $0.textColor = Color.gray800
        $0.font = UIFont.font(.pretendardMedium, ofSize: 16)
    }
    
    lazy var scopeButton = UIButton().then {
        $0.setTitle("주", for: .normal)
        $0.setTitleColor(Color.gray800, for: .normal)
        $0.setImage(Image.icArrowDropDown16, for: .normal)
        $0.imageView?.contentMode = .scaleAspectFit
        $0.titleLabel?.font = UIFont.font(.pretendardSemibold, ofSize: 13)
        $0.backgroundColor = Color.gray150
        $0.makeRounded(radius: 6)
        $0.contentHorizontalAlignment = .center
        $0.semanticContentAttribute = .forceRightToLeft
        $0.imageEdgeInsets = .init(top: 0, left: 10, bottom: 0, right: 6)
    }
    
    // MARK: - Setup Methods

    override func setupView() {
        addSubviews(dateLabel, scopeButton)
        scopeButton.addTarget(self, action: #selector(scopeButtonDidTap(_:)), for: .touchUpInside)
    }
    
    override func setupConstraints() {
        dateLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(20)
            $0.bottom.equalToSuperview().inset(18)
        }
        
        scopeButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.width.equalTo(45)
            $0.height.equalTo(28)
            $0.centerY.equalTo(dateLabel.snp.centerY)
        }
    }
    
    @objc func scopeButtonDidTap(_ sender: UIButton) {
        self.scopeState = scopeState == .week ? .month : .week
        delegate?.calendarTopView(scope: scopeState)
    }
}
