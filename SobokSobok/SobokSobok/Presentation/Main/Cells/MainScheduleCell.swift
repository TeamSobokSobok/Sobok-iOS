//
//  MainScheduleCell.swift
//  SobokSobok
//
//  Created by taekki on 2022/07/29.
//

import EasyKit
import UIKit

protocol MainScheduleCellDelegate: AnyObject {
    func checkButtonTapped(_ cell: MainScheduleCell)
}

final class MainScheduleCell: ScheduleCell {
    
    weak var delegate: MainScheduleCellDelegate?
    var isChecked: Bool = false {
        didSet {
            isChecked ?
            checkButton.setImage(Image.icCheckSelect56, for: .normal) :
            checkButton.setImage(Image.icCheckUnselect56, for: .normal)
        }
    }

    lazy var homeButtonHStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fill
        $0.spacing = 0
        $0.addArrangedSubviews(checkButton, moreButton)
    }
    
    lazy var checkButton = UIButton().then {
        $0.contentMode = .scaleAspectFill
        $0.setImage(Image.icCheckUnselect56, for: .normal)
        $0.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
    }
    
    lazy var moreButton = UIButton().then {
        $0.setImage(Image.icEdit40, for: .normal)
        $0.isHidden = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setupConstraints()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(editStarted),
                                               name: NSNotification.Name("edit"),
                                               object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self,
                                                  name: NSNotification.Name("edit"),
                                                  object: nil)
    }
}

extension MainScheduleCell {
    private func setupUI() {
        moreButton.isHidden = true
    }
    
    private func setupConstraints() {
        addSubview(homeButtonHStackView)
        homeButtonHStackView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(4)
            $0.width.height.equalTo(56)
            $0.centerY.equalTo(topHStackView)
        }
    }
    
    @objc func checkButtonTapped() {
        delegate?.checkButtonTapped(self)
    }
    
    @objc func editStarted(notification: NSNotification) {
        checkButton.isHidden.toggle()
        moreButton.isHidden.toggle()
    }
}
