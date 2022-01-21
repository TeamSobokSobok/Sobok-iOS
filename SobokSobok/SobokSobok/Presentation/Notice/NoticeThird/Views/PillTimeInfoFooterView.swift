//
//  PillTimeInfoFooterView.swift
//  SobokSobok
//
//  Created by 정은희 on 2022/01/18.
//

import UIKit

import SnapKit
import Then

final class PillTimeInfoFooterView: UICollectionReusableView {

    // MARK: Property
    var addCellClosure: (() -> Void)?
    var buttonClosure: (() -> Void)?
    let addTimeCellButton = UIButton().then {
        $0.addTarget(self, action: #selector(addTimeCellButtonClicked), for: .touchUpInside)
        $0.makeRoundedWithBorder(radius: 10, color: Color.gray150.cgColor, borderWith: 1)
        $0.backgroundColor = Color.gray100
        $0.setImage(Image.icPlusGray, for: .normal)
    }
    let deleteButton = UIButton().then {
        $0.setTitleColor(Color.darkMint, for: .normal)
        $0.addTarget(self, action: #selector(deleteButtonClicked), for: .touchUpInside)
        $0.makeRounded(radius: 12)
        $0.backgroundColor = Color.lightMint
        $0.setTitle("삭제", for: .normal)
    }
    let confirmButton = UIButton().then {
        $0.setTitleColor(Color.white, for: .normal)
        $0.addTarget(self, action: #selector(confirmButtonClicked), for: .touchUpInside)
        $0.makeRounded(radius: 12)
        $0.backgroundColor = Color.mint
        $0.setTitle("확인", for: .normal)
    }
    let buttonStack = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 11
        $0.alignment = .center
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        [addTimeCellButton, buttonStack, confirmButton, deleteButton].forEach {
            addSubview($0)
        }
        buttonStack.addArrangedSubviews(deleteButton, confirmButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addTimeCellButton.snp.makeConstraints {
            $0.top.equalTo(11)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(UIScreen.main.bounds.width - 40)
            $0.height.equalTo(54)
        }
        deleteButton.snp.makeConstraints {
            $0.top.leading.bottom.equalTo(buttonStack)
            $0.height.equalTo(54)
        }
        confirmButton.snp.makeConstraints {
            $0.top.trailing.bottom.equalTo(buttonStack)
            $0.height.equalTo(54)
        }
        
        buttonStack.snp.makeConstraints {
            $0.top.equalTo(addTimeCellButton.snp.bottom).offset(10)
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(54)
            $0.width.equalTo(UIScreen.main.bounds.width - 40)
        }
    }
    
    // MARK: - Functions
    @objc func addTimeCellButtonClicked() {
        addCellClosure?()
    }
    @objc func deleteButtonClicked() {
        buttonClosure?()
    }
    @objc func confirmButtonClicked() {
        buttonClosure?()
    }
}
