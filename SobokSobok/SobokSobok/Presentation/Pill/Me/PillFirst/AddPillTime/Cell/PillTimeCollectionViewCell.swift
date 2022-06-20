//
//  PillTimeCollectionViewCell.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/03/02.
//

import UIKit

import SnapKit
import Then

final class PillTimeCollectionViewCell: UICollectionViewCell {
    
    let viewModel = PillTimeViewModel()
    
    lazy var timeLabel = UILabel().then {
        $0.font = UIFont.font(.pretendardSemibold, ofSize: 18)
        $0.textColor = Color.black
        $0.text = "오전 8:00"
    }
    
    lazy var deleteButton = UIButton().then {
        $0.setImage(Image.icPlusActive, for: .normal)
        $0.addTarget(self, action: #selector(deleteCellButtonTapped), for: .touchUpInside)
    }
    
    override init(frame: CGRect) {
           super.init(frame: frame)
        setUI()
        setConstraints()
        contentView.makeRoundedWithBorder(radius: 8, color: Color.darkMint.cgColor)
       }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        [timeLabel, deleteButton].forEach {
            contentView.addSubviews($0)
        }
    }
    
    private func setConstraints() {
        timeLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
        }
        
        deleteButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(3)
            $0.width.height.equalTo(48)
        }
    }
    
    func updateCell(_ timeViewModel: PillTimeViewModel, indexPath: IndexPath) {
        let value = timeViewModel.timeList.value
        timeLabel.text = value[indexPath.row]
    }
    
    @objc func deleteCellButtonTapped() {
        viewModel.deleteCellClosure?()
    }
}
