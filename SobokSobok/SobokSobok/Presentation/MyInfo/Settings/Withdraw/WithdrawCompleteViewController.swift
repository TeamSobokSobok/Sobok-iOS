//
//  WithdrawCompleteViewController.swift
//  SobokSobok
//
//  Created by 정은희 on 2022/09/21.
//

import UIKit

import SnapKit
import Then

final class WithdrawCompleteViewController: UIViewController {
    private lazy var completionButton = UIButton().then {
        $0.backgroundColor = Color.black
        $0.makeRounded(radius: 8)
        $0.setTitleColor(Color.white, for: .normal)
        $0.titleLabel?.text = "탈퇴가 완료되었어요"
        $0.titleLabel?.font = UIFont.font(.pretendardSemibold, ofSize: 15)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
        setWithdraw()
    }
}

extension WithdrawCompleteViewController: LayoutProtocol {
    func layout() {
        self.view.addSubview(completionButton)
        completionButton.snp.makeConstraints { make in
            make.width.equalTo(335.adjustedWidth)
            make.height.equalTo(47.adjustedHeight)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(46)
        }
    }
    
    private func setWithdraw() {
        SBIndicator.shared.show()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            SBIndicator.shared.hide()
            self.modalTransitionStyle = .coverVertical
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
}
