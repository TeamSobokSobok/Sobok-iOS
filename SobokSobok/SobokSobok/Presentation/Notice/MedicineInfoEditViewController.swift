//
//  MedicineInfoEditViewController.swift
//  SobokSobok
//
//  Created by 정은희 on 2022/01/14.
//

import UIKit

import Then
import SnapKit

final class MedicineInfoEditViewController: UIViewController {
    
    // MARK: - @IBOutlet Properties
    @IBOutlet weak var medicineNameTextField: UITextField!
    @IBOutlet weak var termSelectButton: UIButton!
    @IBOutlet weak var dayButton: UIButton!
    @IBOutlet weak var weekButton: UIButton!
    @IBOutlet weak var termButton: UIButton!
    @IBOutlet weak var selectWeekButton: UIButton!
    @IBOutlet weak var selectTermButton: UIButton!
    
    // MARK: - Properties
    let navigationView = UIView().then {
        $0.backgroundColor = .white
    }
    let navigationTitleLabel = UILabel().then {
        $0.text = "복약 정보 수정"
        $0.font = .systemFont(ofSize: 17)
    }
    let backButton = UIButton().then {
        $0.setImage(Image.icBack48, for: .normal)
    }
    
    // MARK: - @IBOutlet Properties
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var acceptButton: UIButton!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setConstraints()
    }
    
    // MARK: - Functions
    private func setUI() {
        [navigationView, navigationTitleLabel, backButton].forEach {
            view.addSubview($0)
        }
        [deleteButton, acceptButton].forEach {
            $0?.cornerRadius = 12
        }
        [dayButton, weekButton, termButton].forEach {
            $0?.makeRoundedWithBorder(radius: 10, color: Color.darkMint.cgColor)
        }
        [medicineNameTextField, termSelectButton, selectWeekButton, selectTermButton].forEach {
            $0?.makeRoundedWithBorder(radius: 12, color: Color.gray300.cgColor)
        }
            
        // TODO: - 폰트 스타일 확인 필요
//        navigationTitleLabel.setTypoStyle(
//            font: TypoStyle.body5.font,
//            kernValue: TypoStyle.body5.labelDescription.kern,
//            lineSpacing: TypoStyle.body5.labelDescription.lineHeight)
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
        
        backButton.snp.makeConstraints {
            $0.leading.equalTo(navigationView).inset(1)
            $0.centerY.equalTo(navigationTitleLabel)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 사용자가 처음 화면을 터치할 때 키보드 호출.
        self.view.endEditing(true)
    }

}
