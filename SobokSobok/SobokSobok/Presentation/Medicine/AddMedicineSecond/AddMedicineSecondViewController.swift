//
//  AddMedicineSecondViewController.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/01/12.
//

import UIKit

enum MedicineDayType: Int, CaseIterable {
    case everyday = 0
    case specificDay
    case specificPeriod
}

final class AddMedicineSecondViewController: BaseViewController {
    
    // MARK: - @IBOutlets
    
    @IBOutlet var selectDateButtons: [UIButton]!
    @IBOutlet var medicinePeriodButton: UIButton!
    @IBOutlet var medicineDateButtons: [UIButton]!
    @IBOutlet var specificDayView: UIView!
    @IBOutlet var specificPeriodView: UIView!
    @IBOutlet var takeMedicineDayLabel: UILabel!
    @IBOutlet var takeMedicinePeriodLabel: UILabel!
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setButtons()
    }
    
    override func style() {
        view.backgroundColor = .white
    }
    
    // MARK: - Functions
    
    private func setButtons() {
        medicineDateButtons.forEach {
            $0.makeRounded(radius: 10)
        }
        selectDateButtons.forEach {
            $0.makeRoundedWithBorder(radius: 10, color: Color.gray300.cgColor)
        }
    }
    
    private func updateMedicineButtonAttributes(button: UIButton, width: CGFloat, boardColor: CGColor, backgroundColor: UIColor, setTitleColor: UIColor) {
        button.layer.borderWidth = width
        button.layer.borderColor = boardColor
        button.backgroundColor = backgroundColor
        button.setTitleColor(setTitleColor, for: .normal)
    }
    
    // 코드 줄일라고 만든 함수
    // UIViewController.Type을 매개변수로 가지고 .instanceFromNib()
    private func presentViewController(viewControllers: UIViewController.Type) {
        let viewController = viewControllers.instanceFromNib()
        viewController.modalPresentationStyle = .overCurrentContext
        viewController.modalTransitionStyle = .crossDissolve
        self.present(viewController, animated: true)
    }
    
    // MARK: - @IBActions
    
    @IBAction func selectMedicinePeriodButton(_ sender: UIButton) {
        sender.isSelected.toggle()
        let index = sender.tag
        switch index {
        case MedicineDayType.everyday.rawValue:
            if sender.isSelected {
                specificDayView.isHidden = true
                specificPeriodView.isHidden = true
                medicineDateButtons[2].isSelected = false
                medicineDateButtons[1].isSelected = false
                updateMedicineButtonAttributes(button: medicineDateButtons[0], width: 1, boardColor: Color.darkMint.cgColor, backgroundColor: Color.lightMint, setTitleColor: Color.darkMint)
                updateMedicineButtonAttributes(button: medicineDateButtons[1], width: 0, boardColor: Color.gray100.cgColor, backgroundColor: Color.gray100, setTitleColor: Color.gray500)
                updateMedicineButtonAttributes(button: medicineDateButtons[2], width: 0, boardColor: Color.gray100.cgColor, backgroundColor: Color.gray100, setTitleColor: Color.gray500)
            } else {
                updateMedicineButtonAttributes(button: medicineDateButtons[0], width: 0, boardColor: Color.gray100.cgColor, backgroundColor: Color.gray100, setTitleColor: Color.gray500)
            }
        case MedicineDayType.specificDay.rawValue:
            if sender.isSelected {                specificDayView.isHidden = false
                specificPeriodView.isHidden = true
                medicineDateButtons[0].isSelected = false
                medicineDateButtons[2].isSelected = false
                updateMedicineButtonAttributes(button: medicineDateButtons[1], width: 1, boardColor: Color.darkMint.cgColor, backgroundColor: Color.lightMint, setTitleColor: Color.darkMint)
                updateMedicineButtonAttributes(button: medicineDateButtons[0], width: 0, boardColor: Color.gray100.cgColor, backgroundColor: Color.gray100, setTitleColor: Color.gray500)
                updateMedicineButtonAttributes(button: medicineDateButtons[2], width: 0, boardColor: Color.gray100.cgColor, backgroundColor: Color.gray100, setTitleColor: Color.gray500)
            } else {
                specificDayView.isHidden = true
                specificPeriodView.isHidden = true
                updateMedicineButtonAttributes(button: medicineDateButtons[1], width: 0, boardColor: Color.gray100.cgColor, backgroundColor: Color.gray100, setTitleColor: Color.gray500)
            }
        case MedicineDayType.specificPeriod.rawValue:
            if sender.isSelected {
                specificDayView.isHidden = true
                specificPeriodView.isHidden = false
                medicineDateButtons[0].isSelected = false
                medicineDateButtons[1].isSelected = false
                updateMedicineButtonAttributes(button: medicineDateButtons[2], width: 1, boardColor: Color.darkMint.cgColor, backgroundColor: Color.lightMint, setTitleColor: Color.darkMint)
                updateMedicineButtonAttributes(button: medicineDateButtons[0], width: 0, boardColor: Color.gray100.cgColor, backgroundColor: Color.gray100, setTitleColor: Color.gray500)
                updateMedicineButtonAttributes(button: medicineDateButtons[1], width: 0, boardColor: Color.gray100.cgColor, backgroundColor: Color.gray100, setTitleColor: Color.gray500)
            } else {
                specificDayView.isHidden = true
                specificPeriodView.isHidden = true
                updateMedicineButtonAttributes(button: medicineDateButtons[2], width: 0, boardColor: Color.gray100.cgColor, backgroundColor: Color.gray100, setTitleColor: Color.gray500)
            }
        default: break
        }
    }
    
    @IBAction func medicinePeriodButtonClicked(_ sender: UIButton) {
        presentViewController(viewControllers: MedicineCalendarViewController.self)
    }
    
    @IBAction func specificDayButtonClicked(_ sender: UIButton) {
        presentViewController(viewControllers: MedicineSpecificDayViewController.self)
    }
    
    @IBAction func specificPeriodButtonClicked(_ sender: UIButton) {
        presentViewController(viewControllers: MedicineSpecificPeriodViewController.self)
    }
}
