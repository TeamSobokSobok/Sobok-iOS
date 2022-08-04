//
//  PillScheduleCell.swift
//  SobokSobok
//
//  Created by taehy.k on 2022/06/21.
//

import UIKit

class ScheduleCell: UICollectionViewCell {
    
    // MARK: - Properties
    var pill: Pill?
    
    // MARK: - UI Components
    
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
    
    lazy var topHStackView = UIStackView().then {
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
    
    private lazy var stickerHStackView = UIStackView().then {
        for index in 0..<4 {
            let stickerButton = UIButton()
            stickerButton.setImage(Image.bigSticker1, for: .normal)
            stickerButton.addTarget(self, action: #selector(stickerButtonTapped), for: .touchUpInside)
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
}

extension ScheduleCell {
    private func setupUI() {
        backgroundColor = Color.gray100
        makeRounded(radius: 12)
        pillColorView.makeRounded(radius: 4)
        stickerHStackView.arrangedSubviews.forEach { $0.isHidden = true }
    }
    
    private func setupConstraints() {
        addSubviews(containerVStackView, countLabel)
        
        containerVStackView.snp.makeConstraints {
            $0.leading.bottom.equalToSuperview().inset(20)
            $0.top.equalToSuperview().inset(19)
        }
        
        pillColorView.snp.makeConstraints {
            $0.width.height.equalTo(8)
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
    
    func configureCell(with pill: Pill) {
        self.pill = pill
        self.pillColorView.backgroundColor = pillColors[pill.color]
        self.pillNameLabel.text = pill.pillName
        
        let stickers: [Int] = [2, 3, 4, 2, 2, 3]
        countLabel.text = stickers.count > 4 ? "+ \(stickers.count - 4)" : ""
        configureStickers(with: stickers)
    }
    
    private func configureStickers(with stickerId: [Int]?) {
        if let stickerId = stickerId,
           !stickerId.isEmpty {
            stickerHStackView.isHidden = false
            for index in 0..<4 {
                let stickerView = stickerHStackView.arrangedSubviews[index] as? UIButton
                stickerView?.isHidden = false
                stickerView?.setImage(stickers[stickerId[index]], for: .normal)
            }
        } else {
            stickerHStackView.isHidden = true
        }
    }
    
    @objc func stickerButtonTapped(_ sender: UIButton) {
        guard let scheduleId = pill?.scheduleId else { return }
        NotificationCenter.default.post(name: Notification.Name("sticker"), object: nil, userInfo: ["scheduleId" : scheduleId])
    }
}
