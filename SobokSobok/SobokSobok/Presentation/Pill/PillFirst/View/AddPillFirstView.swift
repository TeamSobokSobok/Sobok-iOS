//
//  AddPillFirstView.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/03/01.
//

import UIKit

import SnapKit
import Then

enum Specific {
    case everyday
    case day
    case period
}

final class AddPillFirstView: UIView {
    
    let navigationView = NavigationView()
    
    var specific: Specific?
    
    private lazy var scrollView = UIScrollView().then {
        $0.backgroundColor = Color.white
        $0.alwaysBounceVertical = true
    }
    
    let periodLabel = UILabel().then {
        $0.font = UIFont.font(.pretendardSemibold, ofSize: 15)
        $0.textColor = Color.gray800
        $0.text = "얼마나 자주 먹는 약인가요?"
    }
    
    lazy var everydayButton = SpecificButton(specific: .everyday)
    lazy var specificDayButton = SpecificButton(specific: .day)
    lazy var specificPeriodButton = SpecificButton(specific: .period)
    lazy var specificView = SpecificView().then {
        $0.makeRoundedWithBorder(radius: 8, color: Color.gray300.cgColor)
    }
    
    let nextButton = SobokButton.init(frame: CGRect(), mode: .inactive, text: "다음", fontSize: 18)
    
    let horizontalStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.alignment = .center
        $0.spacing = 10
    }
    
    let verticalStackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.alignment = .center
        $0.spacing = 10
    }
    
    let timeLabel = UILabel().then {
        $0.font = UIFont.font(.pretendardSemibold, ofSize: 15)
        $0.textColor = Color.gray800
        $0.text = "몇시에 약을 드셔야 하나요?"
    }
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.register(PillTimeCollectionViewCell.self)
        $0.register(AddMyMedicineFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: AddMyMedicineFooterView.reuseIdentifier)
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 40, height: 54)
        layout.scrollDirection = .vertical
        $0.backgroundColor = .white
        $0.showsVerticalScrollIndicator = false
        $0.collectionViewLayout = layout
    }
    
    convenience init(specific: Specific) {
           self.init()
           self.specific = specific
      
       }
    
    func setConfiguration() {
        switch specific {
        case .day:
            setDay()
            print("day")
        case .period:
            setPeriod()
            print("period")
        case .everyday:
            print("none")
        default:
            break
        }
    }

    func setDay() {
        specificView.specificLabel.text = "무슨 요일에 먹나요?"
    }

    func setPeriod() {
        specificView.specificLabel.text = "며칠 간격으로 먹나요?"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setConstraints()
        hideBottomView()
        self.setConfiguration()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func hideBottomView() {
        [navigationView.bottomSecondView, navigationView.bottomThirdView].forEach {
            $0.isHidden = true
        }
    }
    
    func setupView() {
        [navigationView, scrollView].forEach {
            addSubview($0)
        }
        
        [horizontalStackView, verticalStackView, periodLabel, everydayButton, specificDayButton, specificPeriodButton, specificView, timeLabel, collectionView, nextButton].forEach {
            scrollView.addSubview($0)
        }
        
        [everydayButton, specificDayButton, specificPeriodButton].forEach {
            horizontalStackView.addArrangedSubview($0)
        }
        
        [periodLabel, horizontalStackView, specificView].forEach {
            verticalStackView.addArrangedSubview($0)
        }
    }
    
    func setConstraints() {
        navigationView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(55)
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(navigationView.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(safeAreaInsets)
        }
        
        periodLabel.snp.makeConstraints {
            $0.top.equalTo(verticalStackView)
            $0.leading.equalTo(verticalStackView.snp.leading)
            $0.height.equalTo(48)
        }
        
        verticalStackView.snp.makeConstraints {
            $0.top.equalTo(scrollView.snp.top)
            $0.leading.equalTo(scrollView.snp.leading).inset(20)
            $0.trailing.equalTo(scrollView.snp.trailing).inset(20)
            $0.width.equalTo(UIScreen.main.bounds.width - 40)
        }
        
        horizontalStackView.snp.makeConstraints {
            $0.top.equalTo(periodLabel.snp.bottom)
            $0.leading.trailing.equalTo(verticalStackView)
            $0.width.equalTo(UIScreen.main.bounds.width - 40)
        }
        
        everydayButton.snp.makeConstraints {
            $0.height.equalTo(48)
            $0.width.equalTo(UIScreen.main.bounds.width - 40)
        }
        
        specificDayButton.snp.makeConstraints {
            $0.height.equalTo(48)
            $0.width.equalTo(UIScreen.main.bounds.width - 40)
        }
        
        specificPeriodButton.snp.makeConstraints {
            $0.height.equalTo(48)
            $0.width.equalTo(UIScreen.main.bounds.width - 40)
        }
        
        specificView.snp.makeConstraints {
            $0.top.equalTo(horizontalStackView.snp.bottom).inset(-10)
            $0.leading.trailing.equalTo(verticalStackView)
            $0.height.equalTo(54)
        }
        
        timeLabel.snp.makeConstraints {
            $0.top.equalTo(verticalStackView.snp.bottom).offset(60)
            $0.leading.equalToSuperview().inset(20)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(timeLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(nextButton.snp.top).inset(10)
        }
        
        nextButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(safeAreaLayoutGuide)
            $0.height.equalTo(54)
        }
    }
}
