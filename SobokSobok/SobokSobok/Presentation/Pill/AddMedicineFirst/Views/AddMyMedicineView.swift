//
//  AddMyMedicineView.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/01/10.
//

import UIKit

import SnapKit
import Then

final class AddMyMedicineView: UIView {

    let navigationTitleLabel = UILabel().then {
        $0.text = "내 약 추가하기"
        $0.font = UIFont.font(.pretendardRegular, ofSize: 17)
    }
    
    let xButton = UIButton().then {
        $0.setImage(Image.icBack48, for: .normal)
    }
    
    let nextButton = UIButton().then {
        $0.setTitle("다음", for: .normal)
        $0.setTitleColor(Color.mint, for: .normal)
        $0.titleLabel?.font = UIFont.font(.pretendardMedium, ofSize: 17)
    }
    
    let medicinePeopleLabel = UILabel().then {
        $0.textColor = .black // 추후 컬러 수정
        $0.font = .systemFont(ofSize: 15) // 폰트 수정
        $0.text = "약 먹을 사람"
    }
    
    let peopleLabel = UILabel().then {
        $0.textColor = .black // 추후 컬러 수정
        $0.font = .systemFont(ofSize: 18) // 폰트 수정
        $0.text = "나"
    }
    
    let morePillImage = UIImageView().then {
        $0.image = Image.icMore48
    }
    
    let peopleSelectButton = UIButton().then {
        $0.layer.cornerRadius = 10
        $0.layer.borderWidth = 1
        $0.layer.borderColor = Color.gray300.cgColor
    }
    
    let whoLabel = UILabel().then {
        $0.textColor = .gray // 추후 컬러 수정
        $0.font = .systemFont(ofSize: 15) // 폰트 수정
        $0.text = "내가 먹을 약이에요"
    }
    
    let medicineLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 15)
        $0.text = "약 이름"
    }
    
    let progressImage = UIImageView().then {
        $0.image = Image.icProgress1
    }
 
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        
        $0.register(AddMyMedicineCollectionViewCell.self)
        $0.register(AddMyMedicineFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: AddMyMedicineFooterView.reuseIdentifier)
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .vertical
        $0.backgroundColor = .white
        $0.contentInset = UIEdgeInsets.init(top: 8, left: 20, bottom: 0, right: 20)
        $0.showsVerticalScrollIndicator = false
        $0.collectionViewLayout = layout
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupView() {
        [navigationTitleLabel, xButton, nextButton, medicinePeopleLabel, peopleLabel, peopleSelectButton, morePillImage, whoLabel, medicineLabel, collectionView, progressImage].forEach {
            addSubview($0)
        }
    }
    
    func setConstraints() {
        navigationTitleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(safeAreaLayoutGuide).inset(13)
            $0.height.equalTo(24)
        }
        
        xButton.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalTo(safeAreaLayoutGuide).inset(1)
            $0.centerY.equalTo(navigationTitleLabel)
            $0.height.equalTo(48)
            $0.width.equalTo(48)
        }
        
        nextButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.centerY.equalTo(navigationTitleLabel)
            $0.height.equalTo(44)
            $0.width.equalTo(44)
        }
        
        medicinePeopleLabel.snp.makeConstraints {
            $0.top.equalTo(navigationTitleLabel.snp.bottom).offset(48)
            $0.leading.equalToSuperview().inset(20)
        }
        
        peopleSelectButton.snp.makeConstraints {
            $0.top.equalTo(medicinePeopleLabel.snp.bottom).offset(11)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(54)
        }
        
        morePillImage.snp.makeConstraints {
            $0.top.trailing.equalTo(peopleSelectButton).inset(3)
            $0.height.width.equalTo(48)
        }
        
        peopleLabel.snp.makeConstraints {
            $0.top.equalTo(peopleSelectButton.snp.top).offset(15)
            $0.leading.equalTo(peopleSelectButton.snp.leading).offset(16)
            $0.centerY.equalTo(peopleSelectButton)
        }
        
        whoLabel.snp.makeConstraints {
            $0.top.equalTo(peopleSelectButton.snp.bottom).offset(5)
            $0.leading.equalToSuperview().inset(25)
        }
        
        medicineLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().multipliedBy(0.78)
            $0.leading.equalToSuperview().inset(20)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(medicineLabel.snp.bottom)
            $0.leading.trailing.equalTo(safeAreaLayoutGuide)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(50)
        }
        
        progressImage.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(26)
        }
    }
}
