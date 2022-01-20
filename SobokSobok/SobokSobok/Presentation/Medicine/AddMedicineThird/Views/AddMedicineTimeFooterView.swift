//
//  AddMedicineTimeFooterView.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/01/15.
//

import UIKit

final class AddMedicineTimeFooterView: UICollectionReusableView {

    // MARK: Property
    var addCellClosure: (() -> Void)?
    let addMedicineCellButton = UIButton().then {
        $0.addTarget(self, action: #selector(addMedicineCellButtonClicked), for: .touchUpInside)
        $0.makeRoundedWithBorder(radius: 10, color: Color.gray150.cgColor, borderWith: 1)
        $0.backgroundColor = Color.gray100
        // 이미지 수정
        $0.setImage(Image.icPlusGray, for: .normal)
    }
    
    let countCautionLabel = UILabel().then {
        $0.textAlignment = .center
        $0.text = "최대 6개의 알림 시간을 설정할 수 있습니다."
        $0.font = UIFont.font(.pretendardMedium, ofSize: 15)
        $0.textColor = Color.gray500
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        countCautionLabel.isHidden = true
        [countCautionLabel, addMedicineCellButton].forEach {
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
        
        countCautionLabel.snp.makeConstraints {
            $0.top.equalTo(34)
            $0.centerX.equalToSuperview()
        }
    }
    
    // MARK: - Functions
    // 클로저 활용해서 버튼 클릭되게
    @objc func addMedicineCellButtonClicked() {
        addCellClosure?()
    }
}
