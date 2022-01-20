//
//  AddMyMedicineFooterView.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/01/10.
//

import UIKit

import SnapKit
import Then

final class AddMyMedicineFooterView: UICollectionReusableView {
    
    // MARK: - Properties
    
    var addMedicineCellClosure : (() -> Void)?
    
    let addMedicineCellButton = UIButton().then {
        $0.addTarget(self, action: #selector(addMedicineCellButtonClicked), for: .touchUpInside)
        $0.makeRounded(radius: 10)
        $0.backgroundColor = Color.gray100
    }
    
    let plusImage = UIImageView().then {
        $0.image = Image.icPlusGray
        $0.tintColor = Color.gray500
    }

    let withLabel = UILabel().then {
        $0.text = "함께 먹는 약이 있나요?"
        $0.textColor = Color.gray500
    }
    
    let withMedicineLabel = UILabel().then {
        $0.text = "복약 중인 약을 포함해 \n 최대 5개까지 저장할 수 있어요"
        $0.textAlignment = .center
        $0.numberOfLines = 2
        $0.textColor = Color.gray500
        $0.font = UIFont.font(.pretendardMedium, ofSize: 15)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        [addMedicineCellButton, withMedicineLabel, plusImage, withLabel].forEach {
            addSubview($0)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addMedicineCellButton.snp.makeConstraints {
            $0.top.equalTo(11)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(UIScreen.main.bounds.width - 40)
            $0.height.equalTo(54)
        }
        
        withLabel.snp.makeConstraints {
            $0.centerY.equalTo(addMedicineCellButton)
            $0.leading.equalTo(addMedicineCellButton.snp.leading).inset(16)
        }
        
        plusImage.snp.makeConstraints {
            $0.centerY.equalTo(addMedicineCellButton)
            $0.trailing.equalTo(addMedicineCellButton.snp.trailing).inset(16)
        }
        
        withMedicineLabel.snp.makeConstraints {
            $0.top.equalTo(addMedicineCellButton.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
    }
    
    // MARK: - Functions
    
    // 클로저 활용해서 버튼 클릭되게
    @objc func addMedicineCellButtonClicked() {
        addMedicineCellClosure?()
    }
}
