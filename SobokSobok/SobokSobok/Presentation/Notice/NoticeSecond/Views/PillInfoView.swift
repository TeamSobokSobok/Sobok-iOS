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
    lazy var sendedPillAccept: (() -> ()) = {}
    lazy var sendedPillRefuse: (() -> ()) = {}
    
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
        layout.headerReferenceSize = CGSize(width: UIScreen.main.bounds.size.width - 40, height: 21)
        layout.minimumInteritemSpacing = 11
        layout.sectionInset = UIEdgeInsets(top: 11, left: 0, bottom: 16, right: 0)
        layout.scrollDirection = .vertical
        $0.backgroundColor = .clear
        $0.collectionViewLayout = layout
        $0.register(PillInfoCollectionViewCell.self)
        $0.register(PillInfoHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: PillInfoHeaderView.reuseIdentifier)
        $0.register(PillInfoFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: PillInfoFooterView.reuseIdentifier)
        $0.showsVerticalScrollIndicator = false
    }
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addAcceptButton()
        addCloseButton()
        addRefuseButton()
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
    
    private func addAcceptButton() {
        acceptButton.addTarget(self, action: #selector(acceptButtonClicked), for: .touchUpInside)
    }
    
    private func addRefuseButton() {
        refuseButton.addTarget(self, action: #selector(refuseButtonClicked), for: .touchUpInside)
    }
    
    @objc
    func xButtonClicked() {
        closed()
    }
    
    @objc
    func acceptButtonClicked() {
        sendedPillAccept()
    }
    
    @objc
    func refuseButtonClicked() {
        sendedPillRefuse()
    }
    
    private func setUI() {
        [navigationView, navigationTitleLabel, xButton, pillInfoCollectionView, buttonStack].forEach {
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
        pillInfoCollectionView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(129)
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
