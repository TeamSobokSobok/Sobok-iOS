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
    
    var isEdit: Bool {
        didSet {
            checkButton.isHidden = isEdit
            moreButton.isHidden = !isEdit
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
        isEdit = false
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        checkButton.isHidden = false
        moreButton.isHidden = true
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
        Notification.Name.editSchedule.addObserver { [weak self] noti in
            guard
                let self = self,
                let userInfo = noti.userInfo,
                let isEdit = userInfo["isEdit"] as? Bool else { return }
            
            let day = self.days()

            self.isEdit = isEdit
            if day > 0 {
                self.checkButton.isHidden = true
            }
        }
    }
    
    private func removeObservers() {
        Notification.Name.editSchedule.removeObserver(observer: self)
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
}

extension MainScheduleCell {
    
    func days() -> Int {
        let newDate = Calendar.current.dateComponents([.day], from: Date().addingTimeInterval(-86400), to: currentDate)
        guard let day = newDate.day else { return 0 }
        return day
    }
}
