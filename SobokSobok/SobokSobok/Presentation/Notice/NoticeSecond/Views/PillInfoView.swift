//
//  PillInfoView.swift
//  SobokSobok
//
//  Created by 정은희 on 2022/02/24.
//

import UIKit

final class PillInfoView: UIView {

    // MARK: - Properties
    lazy var closed: (() -> ()) = {}
    
    private let navigationView = UIView().then {
        $0.backgroundColor = .white
    }
    private let navigationTitleLabel = UILabel().then {
        $0.text = "전송 받은 약"
        $0.font = UIFont.font(.pretendardRegular, ofSize: 17)
    }
    private let xButton = UIButton().then {
        $0.setImage(Image.icClose48, for: .normal)
        $0.tintColor = Color.black
    }
    private let senderInfoLabel = UILabel().then {
        $0.font = UIFont.font(.pretendardMedium, ofSize: 15)
        $0.text = "효영님이 전송해준 약이에요"
        $0.textAlignment = .left
        $0.textColor = Color.gray700
    }
    private let refuseButton = SobokButton.init(frame: CGRect(), mode: .lightMint, text: "거절할래요", fontSize: 18)
    private let acceptButton = SobokButton.init(frame: CGRect(), mode: .mainMint, text: "받을래요", fontSize: 18)
    private let buttonStack = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 11
    }
    let pillInfoCollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init()).then {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: UIScreen.main.bounds.size.width - 40, height: 166)
        layout.footerReferenceSize = CGSize(width: UIScreen.main.bounds.size.width - 40, height: 66)
        layout.minimumInteritemSpacing = 11
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0)
        layout.scrollDirection = .vertical
        $0.backgroundColor = .clear
        $0.collectionViewLayout = layout
        $0.register(PillInfoCollectionViewCell.self)
        $0.register(PillInfoFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: PillInfoFooterView.reuseIdentifier)
        $0.showsVerticalScrollIndicator = false
    }
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addCloseButton()
        setUI()
        setConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Functions
    private func addCloseButton() {
        xButton.addTarget(self, action: #selector(xButtonClicked), for: .touchUpInside)
    }
    
    @objc
    func xButtonClicked() {
        closed()
    }
    
    private func setUI() {
        [navigationView, navigationTitleLabel, xButton, senderInfoLabel, pillInfoCollectionView, buttonStack].forEach {
            addSubview($0)
        }
        buttonStack.addArrangedSubviews(refuseButton, acceptButton)
        self.backgroundColor = Color.white
    }
    
    private func setConstraints() {
        navigationView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(102)
        }
        
        navigationTitleLabel.snp.makeConstraints {
            $0.centerX.equalTo(navigationView)
            $0.bottom.equalTo(navigationView).inset(20)
        }
        
        xButton.snp.makeConstraints {
            $0.leading.equalTo(navigationView).inset(1)
            $0.centerY.equalTo(navigationTitleLabel)
        }
        senderInfoLabel.snp.makeConstraints {
            $0.top.equalTo(navigationView.snp.bottom).offset(27)
            $0.leading.equalToSuperview().offset(20)
        }
        pillInfoCollectionView.snp.makeConstraints {
            $0.top.equalTo(senderInfoLabel.snp.bottom).inset(-11)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
        buttonStack.snp.makeConstraints {
            $0.width.equalTo(335)
            $0.height.equalTo(52)
            $0.top.equalTo(pillInfoCollectionView.snp.bottom).offset(66)
            $0.leading.equalToSuperview().offset(20)
            $0.bottom.equalTo(safeAreaLayoutGuide).offset(-22)
        }
    }

}
