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
        addCellClosure?()
    }
}
