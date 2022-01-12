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
    
    var addMeidicineCellClosure : (() -> ())?
    
    let addMedicineCellButton = UIButton().then {
        $0.addTarget(self, action: #selector(addMedicineCellButtonClicked), for: .touchUpInside)
        $0.makeRoundedWithBorder(radius: 10, color: Color.gray300!.cgColor)
        $0.tintColor = .black
        // 이미지 수정
        $0.setImage(UIImage(systemName: "plus"), for: .normal)
    }
    
    let withMedicineLabel = UILabel().then {
        $0.text = "함께 먹는 약이 있나요?"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(addMedicineCellButton)
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
    }
    
    // MARK: - Functions
    
    // 클로저 활용해서 버튼 클릭되게
    @objc func addMedicineCellButtonClicked() {
        addMeidicineCellClosure?()
    }
}
