//
//  AddPillFooterView.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/05/02.
//
import UIKit

final class AddPillFooterView: UICollectionReusableView {
    
    let viewModel = PillThirdViewModel()
    
    lazy var addPillLabel = UILabel().then {
        $0.text = "약 추가"
        $0.textColor = Color.gray500
        $0.font = UIFont.font(.pretendardMedium, ofSize: 18)
    }
    
    lazy var addPillButton = UIButton().then {
        $0.makeRoundedWithBorder(radius: 10, color: Color.gray150.cgColor, borderWith: 1)
        $0.backgroundColor = Color.gray100
        $0.addTarget(self, action: #selector(addPillCellButtonClicked), for: .touchUpInside)
    }
    
    lazy var plusImageView = UIImageView().then {
        $0.image = Image.icPlusGray
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(addPillButton)
        addPillButton.addSubviews(addPillLabel, plusImageView)
    }
    
    @objc func addPillCellButtonClicked() {
            viewModel.addCellClosure?()
        }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addPillLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
        }
        
        addPillButton.snp.makeConstraints {
            $0.top.equalTo(11)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(UIScreen.main.bounds.width - 40)
            $0.height.equalTo(54)
        }
        
        plusImageView.snp.makeConstraints {
            $0.width.height.equalTo(20)
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(14)
        }
    }
}
