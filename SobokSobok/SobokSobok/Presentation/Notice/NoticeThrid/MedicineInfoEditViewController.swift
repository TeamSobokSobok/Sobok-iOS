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
    @IBOutlet weak var selectTimeCollectionView: UICollectionView!
    
    // MARK: - Properties
    private var timeList: [String] = ["오전 8 : 00"] {
        didSet {
            selectTimeCollectionView.reloadData()
        }
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setConstraints()
        assignDelegation()
        registerXib()
    }
    
    // MARK: - Functions
    private func setUI() {
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
    
    func assignDelegation() {
        selectTimeCollectionView.delegate = self
        selectTimeCollectionView.dataSource = self
    }
    
    func registerXib() {
        selectTimeCollectionView.register(MedicineTimeInfoCollectionViewCell.self)
        selectTimeCollectionView.register(MedicineTimeFooterView.self)
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

// MARK: - Extensions
extension MedicineInfoEditViewController: UICollectionViewDelegate { }

extension MedicineInfoEditViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return timeList.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.row {
        case timeList.count:
            let footer = collectionView.dequeueReusableCell(for: indexPath, cellType: MedicineTimeFooterView.self)
            footer.cornerRadius = 12
            footer.addCellClosure = {
                self.timeList.append("")
            }
            return footer
        default:
            let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: MedicineTimeInfoCollectionViewCell.self)
            cell.makeRoundedWithBorder(radius: 12, color: Color.darkMint.cgColor)
            cell.timeLabel.text = timeList[indexPath.row]
            cell.deleteCellClosure = {
                self.timeList.remove(at: 0)
            }
            return cell
        }
    }
}

extension MedicineInfoEditViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 11
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.row {
        case timeList.count:
            return CGSize(width: 335, height: 54)
        default:
            return CGSize(width: 335, height: 53)
        }
        
    }
}
