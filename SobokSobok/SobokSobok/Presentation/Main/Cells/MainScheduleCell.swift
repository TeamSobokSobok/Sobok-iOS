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
    func moreButtonTapped(_ cell: MainScheduleCell)
}

final class MainScheduleCell: ScheduleCell {
    
    // MARK: - Properties
    
    weak var delegate: MainScheduleCellDelegate?
    var isChecked = false {
        didSet {
            updateUI()
        }
    }
    
    var currentDate = Date() {
        didSet {
            updateUI()
        }
    }
    
    lazy var dateFormatter = DateFormatter()
    
    
    // MARK: - UI Components

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
        $0.addTarget(self, action: #selector(moreButtonTapped), for: .touchUpInside)
    }
    
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        addObservers()
    }
    
    deinit {
        removeObservers()
    }
    
    
    // MARK: - Override Functions
    
    override func configureUI() {
        super.configureUI()
    }
    
    override func configureLayout() {
        super.configureLayout()
        
        addSubview(homeButtonHStackView)
        homeButtonHStackView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(4)
            $0.height.equalTo(56)
            $0.centerY.equalTo(topHStackView)
        }
    }
}


// MARK: - Private Functions

extension MainScheduleCell {
    
    private func updateUI() {
        if isChecked {
            checkButton.setImage(Image.icCheckSelect56, for: .normal)
        }
        else {
            checkButton.setImage(Image.icCheckUnselect56, for: .normal)
        }
        
        let day = days()
        
        if day > 0 {
            checkButton.isHidden = true
        } else {
            checkButton.isHidden = false
        }
    }
    
    private func addObservers() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(editStarted),
                                               name: NSNotification.Name("edit"),
                                               object: nil)
    }
    
    private func removeObservers() {
        NotificationCenter.default.removeObserver(self,
                                                  name: NSNotification.Name("edit"),
                                                  object: nil)
    }
}


// MARK: - Objc Functions

extension MainScheduleCell {
    
    @objc func checkButtonTapped() {
        delegate?.checkButtonTapped(self)
    }
    
    @objc func moreButtonTapped() {
        delegate?.moreButtonTapped(self)
    }
    
    @objc func editStarted(notification: NSNotification) {
        let day = days()
        
        if day > 0 {
            checkButton.isHidden = true
            moreButton.isHidden.toggle()
        } else {
            checkButton.isHidden.toggle()
            moreButton.isHidden.toggle()
        }
    }
}

extension MainScheduleCell {
    
    func days() -> Int {
        let newDate = Calendar.current.dateComponents([.day], from: Date().addingTimeInterval(-86400), to: currentDate)
        guard let day = newDate.day else { return 0 }
        return day
    }
}
