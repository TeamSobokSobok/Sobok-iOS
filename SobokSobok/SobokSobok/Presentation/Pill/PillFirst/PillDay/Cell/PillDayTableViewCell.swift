//
//  PillDayTableViewCell.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/03/05.
//

import UIKit

import SnapKit
import Then

final class PillDayTableViewCell: UITableViewCell {
    
    lazy var dayLabel = UILabel().then {
        $0.textColor = Color.black
        $0.font = UIFont.font(.pretendardMedium, ofSize: 18)
        $0.textAlignment = .center
    }
    
    let checkImage = UIImageView().then {
        $0.image = Image.isVImage
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupView() {
        [dayLabel, checkImage].forEach {
            addSubview($0)
        }
    }
    
    private func setConstraints() {
        dayLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
            $0.width.equalTo(44)
            $0.height.equalTo(48)
        }
        
        checkImage.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20)
            $0.width.equalTo(44)
            $0.height.equalTo(48)
        }
    }
    
    func updateCell(_ dayViewModel: PillDayViewModel, indexPath: IndexPath) {
        
        let value = dayViewModel.weekArray
        
        dayLabel.text = value[indexPath.row]

        checkImage.isHidden = true
    }
    
    func checkImageIsHidden(_ dayViewModel: PillDayViewModel, indexPath: IndexPath) {
        checkImage.isHidden.toggle()
        isSelected.toggle()
        dayViewModel.selectDay(index: indexPath.row, isSelected: checkImage.isHidden)
    }
}
