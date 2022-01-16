//
//  MedicineInfoEditViewController.swift
//  SobokSobok
//
//  Created by 정은희 on 2022/01/14.
//

import UIKit

import Then
import SnapKit

enum TermType: Int, CaseIterable {
    case everyday = 0
    case specificDay
    case specificTerm
}

final class MedicineInfoEditViewController: UIViewController {
    
    // MARK: - @IBOutlet Properties
    @IBOutlet weak var medicineNameTextField: UITextField!
    @IBOutlet weak var termSelectButton: UIButton!
    @IBOutlet var selectButtons: [UIButton]!
    @IBOutlet weak var specificDayView: UIView!
    @IBOutlet weak var specificTermView: UIView!
    @IBOutlet weak var takeDayLabel: UILabel!
    @IBOutlet weak var takeTermLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var acceptButton: UIButton!
    
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
        selectButtons.forEach {
            $0.cornerRadius = 10
        }
        [medicineNameTextField, termSelectButton, specificDayView, specificTermView].forEach {
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
    
    func presentViewController(viewControllers: UIViewController.Type) {
        let viewController = viewControllers.instanceFromNib()
        viewController.modalPresentationStyle = .overCurrentContext
        viewController.modalTransitionStyle = .crossDissolve
        self.present(viewController, animated: true)
    }
    
    func updateTermButtonAttributes(button: UIButton, width: CGFloat, boardColor: CGColor, backgroundColor: UIColor, setTitleColor: UIColor) {
        button.layer.borderWidth = width
        button.layer.borderColor = boardColor
        button.backgroundColor = backgroundColor
        button.setTitleColor(setTitleColor, for: .normal)
    }
    
    // MARK: - @IBAction Properties
    @IBAction func touchUpToSelectButton(_ sender: UIButton) {
        sender.isSelected.toggle()
        let index = sender.tag
        switch index {
        case TermType.everyday.rawValue:
            if sender.isSelected {
                specificDayView.isHidden = true
                specificTermView.isHidden = true
                selectButtons[2].isSelected = false
                selectButtons[1].isSelected = false
                updateTermButtonAttributes(button: selectButtons[0], width: 1, boardColor: Color.darkMint.cgColor, backgroundColor: Color.lightMint, setTitleColor: Color.darkMint)
                updateTermButtonAttributes(button: selectButtons[1], width: 0, boardColor: Color.gray100.cgColor, backgroundColor: Color.gray100, setTitleColor: Color.gray500)
                updateTermButtonAttributes(button: selectButtons[2], width: 0, boardColor: Color.gray100.cgColor, backgroundColor: Color.gray100, setTitleColor: Color.gray500)
            } else {
                updateTermButtonAttributes(button: selectButtons[0], width: 0, boardColor: Color.gray100.cgColor, backgroundColor: Color.gray100, setTitleColor: Color.gray500)
            }
        case TermType.specificDay.rawValue:
            if sender.isSelected {
                specificDayView.isHidden = false
                specificTermView.isHidden = true
                selectButtons[0].isSelected = false
                selectButtons[2].isSelected = false
                updateTermButtonAttributes(button: selectButtons[1], width: 1, boardColor: Color.darkMint.cgColor, backgroundColor: Color.lightMint, setTitleColor: Color.darkMint)
                updateTermButtonAttributes(button: selectButtons[0], width: 0, boardColor: Color.gray100.cgColor, backgroundColor: Color.gray100, setTitleColor: Color.gray500)
                updateTermButtonAttributes(button: selectButtons[2], width: 0, boardColor: Color.gray100.cgColor, backgroundColor: Color.gray100, setTitleColor: Color.gray500)
            } else {
                specificDayView.isHidden = true
                specificTermView.isHidden = true
                updateTermButtonAttributes(button: selectButtons[1], width: 0, boardColor: Color.gray100.cgColor, backgroundColor: Color.gray100, setTitleColor: Color.gray500)
            }
        case TermType.specificTerm.rawValue:
            if sender.isSelected {
                specificDayView.isHidden = true
                specificTermView.isHidden = false
                selectButtons[0].isSelected = false
                selectButtons[1].isSelected = false
                updateTermButtonAttributes(button: selectButtons[2], width: 1, boardColor: Color.darkMint.cgColor, backgroundColor: Color.lightMint, setTitleColor: Color.darkMint)
                updateTermButtonAttributes(button: selectButtons[0], width: 0, boardColor: Color.gray100.cgColor, backgroundColor: Color.gray100, setTitleColor: Color.gray500)
                updateTermButtonAttributes(button: selectButtons[1], width: 0, boardColor: Color.gray100.cgColor, backgroundColor: Color.gray100, setTitleColor: Color.gray500)
            } else {
                specificDayView.isHidden = true
                specificTermView.isHidden = true
                updateTermButtonAttributes(button: selectButtons[2], width: 0, boardColor: Color.gray100.cgColor, backgroundColor: Color.gray100, setTitleColor: Color.gray500)
            }
        default: break
        }
    }
    
    @IBAction func touchUpToTermButton(_ sender: UIButton) {
        presentViewController(viewControllers: MedicineCalendarViewController.self)
    }
    
    @IBAction func touchUpToDayButton(_ sender: Any) {
        presentViewController(viewControllers: WeekSelectViewController.self)
    }
    
    @IBAction func touchUpToPeriodButton(_ sender: Any) {
        presentViewController(viewControllers: TermSelectViewController.self)
    }
    
}
