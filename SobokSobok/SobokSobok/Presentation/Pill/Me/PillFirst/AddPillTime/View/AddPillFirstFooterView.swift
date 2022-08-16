//
//  AddPillFirstFooterView.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/06/09.
//

import Foundation

import UIKit

final class AddPillFirstFooterView: UICollectionReusableView {
    
    let viewModel = AddTimeViewModel()
    let editTimeViewModel = EditTimeViewModel()
    
    lazy var addTimeButton = UIButton().then {
        $0.makeRoundedWithBorder(radius: 10, color: Color.gray150.cgColor, borderWith: 1)
        $0.backgroundColor = Color.gray100
        $0.addTarget(self, action: #selector(addPillCellButtonClicked), for: .touchUpInside)
        $0.setTitle("  시간 추가", for: .normal)
        $0.setImage(Image.icPlusGray, for: .normal)
        $0.currentImage?.withTintColor(Color.gray600)
        let new = $0.currentImage?.resizedImage(Size: CGSize(width: 13, height: 13))
        $0.setImage(new, for: .normal)
        $0.setTitleColor(Color.gray600, for: .normal)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(addTimeButton)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        addTimeButton.snp.makeConstraints {
            $0.top.equalTo(11)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(UIScreen.main.bounds.width - 40)
            $0.height.equalTo(40)
        }
    }
    
    @objc func addPillCellButtonClicked() {
        viewModel.addCellClosure?()
    }
}
