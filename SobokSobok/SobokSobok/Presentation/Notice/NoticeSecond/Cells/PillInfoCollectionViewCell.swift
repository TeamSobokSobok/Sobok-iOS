//
//  SendInfoCollectionViewCell.swift
//  SobokSobok
//
//  Created by 정은희 on 2022/01/11.
//

import UIKit

import SnapKit
import Then

final class PillInfoCollectionViewCell: UICollectionViewCell {

    // MARK: - Properties
    lazy var openEditView: (() -> ()) = {}
    
    private let pillColor = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    private let pillNameLabel = UILabel().then {
        $0.font = UIFont.font(.pretendardMedium, ofSize: 18)
        $0.textAlignment = .left
        $0.textColor = Color.black
    }
    private let editButton = UIButton().then {
        $0.contentMode = .scaleAspectFit
        $0.setImage(Image.icPencil48, for: .normal)
        $0.tintColor = Color.gray800
    }
    private let topStack = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fill
        $0.spacing = 10
    }
    private let dateImage = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = Image.icCalender
    }
    private let dateLabel = UILabel().then {
        $0.font = UIFont.font(.pretendardMedium, ofSize: 14)
        $0.textAlignment = .left
        $0.textColor = Color.gray500
    }
    private let middleStack = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fill
        $0.spacing = 7
    }
    private let termLabel = UILabel().then {
        $0.font = UIFont.font(.pretendardMedium, ofSize: 15)
        $0.textAlignment = .left
        $0.textColor = Color.gray700
    }
    private let timeLabel = UILabel().then {
        $0.font = UIFont.font(.pretendardMedium, ofSize: 15)
        $0.lineBreakMode = .byWordWrapping
        $0.numberOfLines = 0
        $0.setContentCompressionResistancePriority(UILayoutPriority.required, for: .vertical)
        $0.textAlignment = .left
        $0.textColor = Color.gray700
    }
    private let labelStack = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .fill
        $0.spacing = 12
    }
    private let lineView = UIView().then {
        $0.backgroundColor = Color.gray500
    }
    private let bottomStack = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fill
        $0.spacing = 13
    }
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addEditViewButton()
        setUI()
        setConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Functions
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        super.preferredLayoutAttributesFitting(layoutAttributes)
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        var frame = layoutAttributes.frame
        frame.size.height = ceil(size.height)
        layoutAttributes.frame = frame
        return layoutAttributes
    }
    
    // MARK: - Functions
    private func addEditViewButton() {
        editButton.addTarget(self, action: #selector(editViewButtonClicked), for: .touchUpInside)
    }
    
    @objc
    func editViewButtonClicked() {
        openEditView()
    }
    
    private func setUI() {
        [topStack, editButton, middleStack, bottomStack].forEach {
            contentView.addSubview($0)
        }
        topStack.addArrangedSubviews(pillColor, pillNameLabel)
        middleStack.addArrangedSubviews(dateImage, dateLabel)
        labelStack.addArrangedSubviews(termLabel, timeLabel)
        bottomStack.addArrangedSubviews(lineView, labelStack)
        self.backgroundColor = Color.white
        self.makeRoundedWithBorder(radius: 12, color: Color.gray300.cgColor)
    }
    
    private func setConstraints() {
        pillColor.snp.makeConstraints {
            $0.width.equalTo(8)
            $0.height.equalTo(8)
        }
        topStack.snp.makeConstraints {
            $0.width.equalTo(242)
            $0.height.equalTo(26)
            $0.top.equalToSuperview().offset(15)
            $0.leading.equalToSuperview().offset(20)
        }
        editButton.snp.makeConstraints {
            $0.width.equalTo(48)
            $0.height.equalTo(48)
            $0.centerX.equalTo(topStack)
            $0.top.equalToSuperview().offset(1)
            $0.trailing.equalToSuperview().inset(1)
        }
        dateImage.snp.makeConstraints {
            $0.width.equalTo(15)
            $0.height.equalTo(14)
        }
        dateLabel.snp.makeConstraints {
            $0.height.equalTo(17)
        }
        middleStack.snp.makeConstraints {
            $0.top.equalTo(topStack.snp.bottom).offset(7)
            $0.leading.equalToSuperview().offset(22)
        }
        timeLabel.snp.makeConstraints {
            $0.width.equalTo(240)
        }
        lineView.snp.makeConstraints {
            $0.width.equalTo(1)
        }
        bottomStack.snp.makeConstraints {
            $0.top.equalTo(middleStack.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(24)
            $0.bottom.equalToSuperview().offset(-16)
        }
    }
    
    func setData(pillInfoData: SendInfoListData) {
        pillColor.image = pillInfoData.medicineColorName
        pillNameLabel.text = pillInfoData.medicineName
        dateLabel.text = pillInfoData.dateInfo
        termLabel.text = pillInfoData.termInfo
        timeLabel.text = pillInfoData.timeInfo
    }
}
