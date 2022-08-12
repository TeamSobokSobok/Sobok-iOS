//
//  PillDayView.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/03/05.
//

import UIKit

import SnapKit
import Then

class PillDayView: BaseView {
    
    let backgroundView = UIView().then {
        $0.makeRounded(radius: 15)
        $0.backgroundColor = Color.white
    }
    
    lazy var tableView = UITableView().then {
        $0.register(PillDayTableViewCell.self)
        $0.isScrollEnabled = false
        $0.rowHeight = 48
    }
    
    let confirmButton = UIButton().then {
        $0.setTitle("확인", for: .normal)
        $0.setTitleColor(Color.darkMint, for: .normal)
        $0.titleLabel?.font = UIFont.font(.pretendardSemibold, ofSize: 18)
    }
    
    override func setupView() {
        [backgroundView, tableView, confirmButton].forEach {
            addSubview($0)
        }
    }
    
    override func setupConstraints() {
        backgroundView.snp.makeConstraints {
            $0.height.equalTo(395)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(safeAreaLayoutGuide)
        }
        
        confirmButton.snp.makeConstraints {
            $0.top.equalTo(backgroundView.snp.top).offset(21)
            $0.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(30)
            $0.width.equalTo(41)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(confirmButton.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}
