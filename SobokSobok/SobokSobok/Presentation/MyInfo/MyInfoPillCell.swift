//
//  MyInfoPillCell.swift
//  SobokSobok
//
//  Created by taekki on 2022/08/27.
//

import UIKit

import SnapKit
import Then

final class MyInfoPillCell: UITableViewCell {
    
    let pillColorImageView = UIImageView()
    let pillNameLabel = UILabel()
    let arrowImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
        configureLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 4, left: 0, bottom: 4, right: 0))
    }
    
    func configureUI() {
        
        selectionStyle = .none
        
        contentView.do {
            $0.layer.cornerRadius = 12
            $0.layer.borderColor = Color.gray300.cgColor
            $0.layer.borderWidth = 1
        }
        
        arrowImageView.do {
            $0.image = Image.icMoreBlack48
        }
    }
    
    func configureLayout() {
        
        contentView.addSubviews(pillColorImageView, pillNameLabel, arrowImageView)
        
        pillColorImageView.snp.makeConstraints {
            $0.size.equalTo(8)
            $0.leading.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
        }
        
        pillNameLabel.snp.makeConstraints {
            $0.leading.equalTo(pillColorImageView.snp.trailing).offset(10)
            $0.centerY.equalToSuperview()
        }
        
        arrowImageView.snp.makeConstraints {
            $0.size.equalTo(48)
            $0.trailing.equalToSuperview().inset(3)
            $0.centerY.equalToSuperview()
        }
    }
}

extension MyInfoPillCell {
    
    func configure(with data: UserPillList?) {
        let image = UIImage(named: data?.color.colorTypeToImageName() ?? "")
        
        pillNameLabel.text = data?.pillName
        pillColorImageView.image = image
    }
}
