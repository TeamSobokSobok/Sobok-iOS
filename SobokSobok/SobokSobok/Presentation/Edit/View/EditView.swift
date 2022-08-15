//
//  EditView.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/08/12.
//

import UIKit

import SnapKit
import Then

final class EditView: BaseView  {
    
    private lazy var scrollView = UIScrollView().then {
        $0.backgroundColor = Color.white
        $0.alwaysBounceVertical = true
    }
    
    lazy var nextButton = SobokButton.init(frame: CGRect(), mode: .inactive, text: "저장", fontSize: 18)
    
    lazy var navigationView = NavigationView()
    
    lazy var editPillNameView = EditPillNameView()
    
    lazy var editPillPeriodView = EditPillPeriodView()
    
    lazy var editPillTimeView = EditPillTimeView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        hideBottomView()
    }
    
    override func setupView() {
        [navigationView, scrollView].forEach {
            addSubview($0)
        }
        
        [editPillNameView, editPillPeriodView, editPillTimeView, nextButton]
            .forEach { scrollView.addSubview($0) }
    }
    
    override func setupConstraints() {
        scrollView.snp.makeConstraints {
            $0.top.equalTo(navigationView.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(safeAreaInsets)
        }
        
        navigationView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(55)
        }
        
        editPillNameView.snp.makeConstraints {
            $0.top.equalTo(navigationView.snp.bottom).offset(30)
            $0.leading.equalTo(scrollView.snp.leading).inset(20)
            $0.trailing.equalTo(scrollView.snp.trailing).inset(20)
            $0.height.equalTo(83)
        }
        
        editPillPeriodView.snp.makeConstraints {
            $0.top.equalTo(editPillNameView.snp.bottom).offset(39)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(143)
        }
        
        editPillTimeView.snp.makeConstraints {
            $0.top.equalTo(editPillPeriodView.verticalStackView.snp.bottom).offset(52)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(300)
        }
        
        nextButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(22)
            $0.height.equalTo(54)
        }

    }
    
    func hideBottomView() {
        [navigationView.bottomFirstView,
         navigationView.bottomSecondView,
         navigationView.bottomThirdView,
         navigationView.sendBottomFirstView,
         navigationView.sendBottomSecondView,
         navigationView.sendBottomThirdView,
         navigationView.sendBottomFourthView
        ].forEach {
            $0.isHidden = true
        }
        
        navigationView.cancelButton.setTitle("삭제", for: .normal)
    }
}
