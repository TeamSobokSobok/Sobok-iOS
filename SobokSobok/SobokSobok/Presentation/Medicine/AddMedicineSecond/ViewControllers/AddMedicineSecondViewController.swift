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
 
    enum TossPill: Int {
        case me, friend
    }
    
    var tossPill: TossPill?
    var medicineData: [String] = []
    
    var dayData = String()
    var specificData = String()
    // MARK: - @IBOutlets
    @IBOutlet var selectDateButtons: [UIButton]!
    @IBOutlet var medicinePeriodButton: UIButton!
    @IBOutlet var medicineDateButtons: [UIButton]!
    @IBOutlet weak var specificDayView: UIView!
    @IBOutlet weak var specificPeriodView: UIView!
    @IBOutlet weak var takeMedicineDayLabel: UILabel!
    @IBOutlet weak var takeMedicinePeriodLabel: UILabel!
    @IBOutlet weak var navigationTitleLabel: UILabel!
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setButtons()
        divideTossPill()
        print(medicineData)
    }
    
    override func style() {
        view.backgroundColor = .white
    }
    
    func divideTossPill() {
        navigationTitleLabel.text = tossPill == .me ? "내 약 추가하기" : "약 전송하기"
    }
    
    // MARK: - Functions
    func pushMedicineThirdViewController(tossPill: AddMedicineThirdViewController.TossPill) {
        let addMyMedicineViewController = AddMedicineThirdViewController.instanceFromNib()
        addMyMedicineViewController.tossPill = tossPill
        addMyMedicineViewController.medicineData = medicineData
        addMyMedicineViewController.day = dayData
        addMyMedicineViewController.specific = specificData
        navigationController?.pushViewController(addMyMedicineViewController, animated: true)
    }
    
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
    // 추후 코드 리팩토링
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
            if sender.isSelected {
                UserDefaults.standard.removeObject(forKey: "period")
                print(UserDefaults.standard.removeObject(forKey: "period"))
                specificDayView.isHidden = false
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
                UserDefaults.standard.removeObject(forKey: "day")
                print(UserDefaults.standard.removeObject(forKey: "day"))
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
        navigationController?.pushViewController(MedicineCalendarViewController.instanceFromNib(), animated: true)
    }
    
    // 추후 코드 리팩토링
    @IBAction func specificDayButtonClicked(_ sender: UIButton) {
        let medicineSpecificDayViewController = MedicineSpecificDayViewController.instanceFromNib()
        medicineSpecificDayViewController.modalPresentationStyle = .overCurrentContext
        medicineSpecificDayViewController.modalTransitionStyle = .crossDissolve
        medicineSpecificDayViewController.sendDelegate = self
        self.present(medicineSpecificDayViewController, animated: true)
    }
    
    @IBAction func specificPeriodButtonClicked(_ sender: UIButton) {
        let medicineSpecificPeriodViewController = MedicineSpecificPeriodViewController.instanceFromNib()
        medicineSpecificPeriodViewController.modalPresentationStyle = .overCurrentContext
        medicineSpecificPeriodViewController.modalTransitionStyle = .crossDissolve
        medicineSpecificPeriodViewController.sendPeriodDelegate = self
        self.present(medicineSpecificPeriodViewController, animated: true)
    }
    
    @IBAction func backButtonClicked(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func nextButtonClicked(_ sender: UIButton) {
        tossPill == .me ? pushMedicineThirdViewController(tossPill: .me) : pushMedicineThirdViewController(tossPill: .friend)
    }
}

// MARK: Delegate
extension AddMedicineSecondViewController: SendPillDayDelegate {
    func sendDay(day: String) {
        takeMedicineDayLabel.text = "\(day)"
        dayData = takeMedicineDayLabel.text!
        
    }
}

extension AddMedicineSecondViewController: SendPeriodDelegate {
    func sendPeriod(day: String) {
        takeMedicinePeriodLabel.text = "\(day)"
        specificData = takeMedicinePeriodLabel.text!

    }
}
