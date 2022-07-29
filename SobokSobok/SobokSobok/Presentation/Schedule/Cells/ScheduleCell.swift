//
//  PillScheduleCell.swift
//  SobokSobok
//
//  Created by taehy.k on 2022/06/21.
//

import UIKit

final class ScheduleCell: UICollectionViewCell {
    private let pillColors: [String: UIColor] = [
        "1": Color.pillColorRed,
        "2": Color.pillColorOrange,
        "3": Color.pillColorPurple,
        "4": Color.pillColorBlue,
        "5": Color.pillColorPink
    ]
    
    private let stickers: [Int: UIImage] = [
        1: Image.sticker1,
        2: Image.sticker2,
        3: Image.sticker3,
        4: Image.sticker4,
        5: Image.sticker5,
        6: Image.sticker6
    ]
    
    private lazy var containerVStackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .fill
        $0.alignment = .leading
        $0.spacing = 12
        $0.addArrangedSubviews(topHStackView, stickerHStackView)
    }
    
    private lazy var topHStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fill
        $0.alignment = .center
        $0.spacing = 10
        $0.addArrangedSubviews(pillColorView, pillNameLabel)
    }
    
    private let pillColorView = UIView().then {
        $0.backgroundColor = .red
    }
    
    private let pillNameLabel = UILabel().then {
        $0.text = "약 명이 10글자일 땐 이렇게"
        $0.font = UIFont.font(.pretendardMedium, ofSize: 18)
    }
    
    private lazy var homeButtonHStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fill
        $0.spacing = 0
        $0.addArrangedSubviews(checkButton, moreButton)
    }
    
    private lazy var checkButton = UIButton().then {
        $0.contentMode = .scaleAspectFill
        $0.setImage(Image.icCheckUnselect56, for: .normal)
    }
    
    private lazy var moreButton = UIButton().then {
        $0.setImage(Image.icEdit40, for: .normal)
        $0.isHidden = true
    }
    
    lazy var stickerHStackView = UIStackView().then {
        for index in 0..<4 {
            let stickerButton = UIButton()
            stickerButton.setImage(Image.bigSticker1, for: .normal)
            $0.addArrangedSubview(stickerButton)
        }
        $0.isHidden = true
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 5
    }
    
    private let countLabel = UILabel().then {
        $0.text = "+ 15"
        $0.font = UIFont.font(.pretendardMedium, ofSize: 15)
        $0.textColor = Color.gray600
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setupConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupUI() {
        backgroundColor = Color.gray100
        moreButton.isHidden = true
        makeRounded(radius: 12)
        pillColorView.makeRounded(radius: 4)
        stickerHStackView.arrangedSubviews.forEach { $0.isHidden = true }
    }
    
    private func setupConstraints() {
        addSubviews(containerVStackView, homeButtonHStackView, countLabel)
        
        containerVStackView.snp.makeConstraints {
            $0.leading.bottom.equalToSuperview().inset(20)
            $0.top.equalToSuperview().inset(19)
        }
        
        pillColorView.snp.makeConstraints {
            $0.width.height.equalTo(8)
        }
        
        homeButtonHStackView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(4)
            $0.width.height.equalTo(56)
            $0.centerY.equalTo(topHStackView)
        }
        
        stickerHStackView.arrangedSubviews.forEach {
            $0.snp.makeConstraints {
                $0.width.height.equalTo(63)
            }
        }
        
        countLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(18)
            $0.bottom.equalToSuperview().inset(13)
        }
    }
}

extension ScheduleCell {
    func configureCell(with pill: Pill) {
        pillColorView.backgroundColor = pillColors[pill.color]
        pillNameLabel.text = pill.pillName
        countLabel.text = pill.stickerTotalCount > 0 ? "+ \(pill.stickerTotalCount)" : ""
//        configureStickers(with: pill.stickerId)
    }
    
    private func configureStickers(with stickerId: [StickerId]?) {
        if let stickerId = stickerId,
           !stickerId.isEmpty {
            stickerHStackView.isHidden = false
            for item in 0..<stickerId.count {
                let stickerView = stickerHStackView.arrangedSubviews[item] as? UIButton
                stickerView?.isHidden = false
                stickerView?.setImage(stickers[stickerId[item].stickerId], for: .normal)
            }
        } else {
            stickerHStackView.isHidden = true
        }
    }
}
