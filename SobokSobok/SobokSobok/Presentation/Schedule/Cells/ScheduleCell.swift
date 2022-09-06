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

    private lazy var containerVStackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .fill
        $0.alignment = .leading
        $0.spacing = 12.adjustedHeight
        $0.addArrangedSubviews(topHStackView, stickerHStackView)
    }
    
    lazy var topHStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fill
        $0.alignment = .center
        $0.spacing = 10.adjustedWidth
        $0.addArrangedSubviews(pillColorView, pillNameLabel)
    }
    
    private lazy var pillColorView = UIView()
    private lazy var pillNameLabel = UILabel().then {
        $0.font = UIFont.font(.pretendardMedium, ofSize: 18)
    }
    
    private lazy var stickerHStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 5.adjustedWidth
        $0.isHidden = true
    }
    
    private lazy var countLabel = UILabel().then {
        $0.font = UIFont.font(.pretendardMedium, ofSize: 15)
        $0.textColor = Color.gray600
    }
    
    
    // MARK: - Initialize
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.configureUI()
        self.configureLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    // MARK: - Configure Functions
    
    func configureUI() {
        self.backgroundColor = Color.white
        self.makeRounded(radius: 12)
        self.pillColorView.makeRounded(radius: 4)
        self.stickerHStackView.arrangedSubviews.forEach { $0.isHidden = true }
    }
    
    func configureLayout() {
        self.addSubviews(containerVStackView, countLabel)
        
        containerVStackView.snp.makeConstraints {
            $0.leading.bottom.equalToSuperview().inset(20.adjustedWidth)
            $0.top.equalToSuperview().inset(19.adjustedHeight)
        }
        
        pillColorView.snp.makeConstraints {
            $0.width.height.equalTo(8.adjustedWidth)
        }
        
        stickerHStackView.arrangedSubviews.forEach {
            $0.snp.makeConstraints {
                $0.width.height.equalTo(63.adjustedWidth)
            }
        }
        
        countLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(18.adjustedWidth)
            $0.bottom.equalToSuperview().inset(13.adjustedHeight)
        }
    }
}


// MARK: - Public Functions

extension ScheduleCell {
    
    func configure(withPill pill: Pill) {
        self.pill = pill
        self.pillColorView.backgroundColor = PillColorType.pillColors[pill.color]
        self.pillNameLabel.text = pill.pillName
    }
    
    func configure(withSticker stickerId: [Int]?) {
        stickerHStackView.removeAllArrangedSubviews()
        if let stickerId = stickerId, !stickerId.isEmpty {
            self.countLabel.text = stickerId.count > 4 ? "+ \(stickerId.count - 4)" : ""
            for value in stickerId {
                let stickerButton = UIButton()
                stickerButton.setImage(StickerType.stickers[value], for: .normal)
                stickerButton.addTarget(self, action: #selector(stickerButtonTapped), for: .touchUpInside)
                stickerHStackView.addArrangedSubview(stickerButton)
            }
            
            self.stickerHStackView.isHidden = false
        }
        else {
            self.stickerHStackView.isHidden = true
        }
    }
}


// MARK: - Objc Functions

extension ScheduleCell {
    
    @objc func stickerButtonTapped(_ sender: UIButton) {
        guard let scheduleId = pill?.scheduleId else { return }
        Notification.Name.showAllSticker.post(object: nil, userInfo: ["scheduleId" : scheduleId])
    }
}
