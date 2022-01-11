//
//  SendInfoViewController.swift
//  SobokSobok
//
//  Created by 정은희 on 2022/01/11.
//

import UIKit

import Then
import SnapKit

final class SendInfoViewController: UIViewController {
    
    // MARK: - Properties
    let navigationView = UIView().then {
        $0.backgroundColor = .white
    }
    let navigationTitleLabel = UILabel().then {
        $0.text = "내 약 추가하기"
        $0.font = .systemFont(ofSize: 17)
    }
    let xButton = UIButton().then {
        $0.setImage(Image.icClose48, for: .normal)
    }
    let nextButton = UIButton().then {
        $0.setTitle("다음", for: .normal)
        $0.setTitleColor(Color.mint, for: .normal)
    }
    
    // MARK: - @IBOutlet Properties
    @IBOutlet weak var refuseButton: UIButton!
    @IBOutlet weak var acceptButton: UIButton!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setConstraints()
    }
    
    // MARK: - Functions
    private func setUI() {
        [navigationView, navigationTitleLabel, xButton, nextButton].forEach {
            view.addSubview($0)
        }
        [refuseButton, acceptButton].forEach {
            $0.cornerRadius = 12
        }
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
        
        nextButton.snp.makeConstraints {
            $0.trailing.equalTo(navigationView.snp.trailing).inset(20)
            $0.centerY.equalTo(navigationTitleLabel)
            $0.height.equalTo(44)
            $0.width.equalTo(44)
        }
        
    }
}



