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
    
    let firstNameView = FirstPillNameView(frame: CGRect(), sendPillViewModel: SendPillViewModel())
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
    
    let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
        $0.backgroundColor = .white
    }
    
    let wholeStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 10
    }
    
    lazy var firstStackView = UIStackView().then {
        $0.backgroundColor = .red
        $0.axis = .vertical
        $0.distribution = .fill
        $0.alignment = .center
        
      
        $0.addArrangedSubview(firstNameView)
    }
  
    let footerView = AddPillFooterView()
    
    lazy var nextButton = SobokButton.init(frame: CGRect(), mode: .inactive, text: "추가하기", fontSize: 18)
    

    override func setupView() {
        addSubviews(navigationView, pillNameInfoLabel, pillPeriodInfoLabel, pillCountLabel, pillCountInfoLabel, countInfoButton, scrollView, nextButton, tooltipImage)
        
        scrollView.addSubviews(wholeStackView, footerView)
        
        footerView.isHidden = true
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
        
        pillPeriodInfoLabel.snp.makeConstraints {
            $0.top.equalTo(pillNameInfoLabel.snp.bottom).offset(4)
            $0.leading.equalToSuperview().offset(20)
        }
        
        pillCountLabel.snp.makeConstraints {
            $0.top.equalTo(pillPeriodInfoLabel.snp.bottom).offset(34)
            $0.leading.equalTo(pillNameInfoLabel.snp.leading)
        }
        
        pillCountInfoLabel.snp.makeConstraints {
            $0.leading.equalTo(pillCountLabel.snp.trailing).offset(3)
            $0.top.equalTo(pillPeriodInfoLabel.snp.bottom).offset(34)
        }
        
        countInfoButton.snp.makeConstraints {
            $0.centerY.equalTo(pillCountLabel)
            $0.leading.equalTo(pillCountInfoLabel.snp.trailing).offset(1)
            $0.width.height.equalTo(22)
        }
        
        tooltipImage.snp.makeConstraints {
            $0.top.equalTo(countInfoButton.snp.bottom)
            $0.centerX.equalTo(countInfoButton.snp.centerX)
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(pillCountLabel.snp.bottom).offset(6)
            $0.leading.trailing.equalTo(safeAreaInsets)
            $0.bottom.equalTo(nextButton.snp.top).inset(1)
        }
        
        wholeStackView.snp.makeConstraints {
            $0.top.equalTo(scrollView.snp.top)
            $0.width.equalTo(UIScreen.main.bounds.width - 40)
            $0.leading.equalTo(scrollView.snp.leading).inset(20)
            $0.trailing.equalTo(scrollView.snp.trailing).inset(20)
        }
        
        footerView.snp.makeConstraints {
            $0.top.equalTo(wholeStackView.snp.bottom)
            $0.height.equalTo(54)
            $0.leading.trailing.equalToSuperview()
        }
 
        nextButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(22)
            $0.height.equalTo(54)
        }
    }
}

