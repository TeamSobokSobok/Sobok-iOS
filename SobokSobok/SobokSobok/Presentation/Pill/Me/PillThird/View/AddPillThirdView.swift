//
//  AddPillThirdView.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/04/30.
//

import UIKit

import SnapKit
import Then


final class AddPillThirdView: BaseView {
    
    lazy var navigationView = NavigationView()

    lazy var pillNameInfoLabel = UILabel().then {
        $0.text = "약 이름을 입력해 주세요"
        $0.font = UIFont.font(.pretendardSemibold, ofSize: 15)
        $0.textColor = Color.gray800
    }
    
    lazy var pillPeriodInfoLabel = UILabel().then {
        $0.text = "같은 주기에 먹는 약을 함께 추가할 수 있어요."
        $0.font = UIFont.font(.pretendardMedium, ofSize: 15)
        $0.textColor = Color.gray500
    }
    
    lazy var countInfoButton = UIButton().then {
        $0.setImage(Image.icInfo, for: .normal)
        $0.tintColor = Color.gray500
    }
    
    lazy var tooltipImage = UIImageView().then {
        $0.image = Image.tooltipImage
    }
    
    lazy var pillCountLabel = UILabel().then {
        $0.text = "4개"
        $0.font = UIFont.font(.pretendardMedium, ofSize: 15)
        $0.textColor = Color.darkMint
    }
    
    lazy var pillCountInfoLabel = UILabel().then {
        $0.text = "더 추가할 수 있어요"
        $0.font = UIFont.font(.pretendardMedium, ofSize: 15)
        $0.textColor = Color.gray500
    }

    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {

            $0.register(PillNameViewCell.self)
            $0.register(AddPillFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: AddPillFooterView.reuseIdentifier)
            let layout = UICollectionViewFlowLayout()

            layout.scrollDirection = .vertical
            $0.showsVerticalScrollIndicator = false
            $0.showsHorizontalScrollIndicator = false
            $0.collectionViewLayout = layout
        }
    
    lazy var nextButton = SobokButton.init(frame: CGRect(), mode: .inactive, text: "추가하기", fontSize: 18)
    

    override func setupView() {
        addSubviews(navigationView, pillNameInfoLabel, pillPeriodInfoLabel, pillCountLabel, pillCountInfoLabel, countInfoButton, collectionView, nextButton)
    }
    
    override func setupConstraints() {
            navigationView.snp.makeConstraints {
                $0.top.equalTo(safeAreaLayoutGuide)
                $0.leading.trailing.equalToSuperview()
                $0.height.equalTo(55)
            }

            pillNameInfoLabel.snp.makeConstraints {
                $0.top.equalTo(navigationView.snp.bottom).offset(37)
                $0.leading.equalToSuperview().offset(20)
            }

            pillCountLabel.snp.makeConstraints {
                $0.top.equalTo(pillNameInfoLabel.snp.bottom).offset(4)
                $0.leading.equalTo(pillNameInfoLabel.snp.leading)
            }

            pillCountInfoLabel.snp.makeConstraints {
                $0.leading.equalTo(pillCountLabel.snp.trailing).offset(3)
                $0.top.equalTo(pillNameInfoLabel.snp.bottom).offset(4)
            }

            countInfoButton.snp.makeConstraints {
                $0.centerY.equalTo(pillCountLabel)
                $0.leading.equalTo(pillCountInfoLabel.snp.trailing).offset(1)
                $0.width.height.equalTo(22)
            }

            collectionView.snp.makeConstraints {
                $0.top.equalTo(pillCountLabel.snp.bottom).offset(6)
                $0.leading.trailing.equalToSuperview()
                $0.bottom.equalTo(nextButton.snp.top).inset(1)
            }

            nextButton.snp.makeConstraints {
                $0.leading.trailing.equalToSuperview().inset(20)
                $0.bottom.equalTo(safeAreaLayoutGuide).inset(22)
                $0.height.equalTo(54)
            }
        }
}

