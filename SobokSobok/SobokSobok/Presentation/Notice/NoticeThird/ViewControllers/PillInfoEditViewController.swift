//
//  PillInfoEditViewController.swift
//  SobokSobok
//
//  Created by 정은희 on 2022/01/17.
//

import UIKit

import Then
import SnapKit

enum TermType: Int, CaseIterable {
    case everyday = 0
    case specificDay
    case specificTerm
}

final class PillInfoEditViewController: BaseViewController {
    
    // MARK: - @IBOutlet Properties
    @IBOutlet weak var pillNameTextField: UITextField!
    @IBOutlet weak var periodSelectButton: UIButton!
    @IBOutlet var selectButtons: [UIButton]!
    @IBOutlet weak var specificDayView: UIView!
    @IBOutlet weak var specificTermView: UIView!
    @IBOutlet weak var takeDayLabel: UILabel!
    @IBOutlet weak var takeTermLabel: UILabel!
    @IBOutlet weak var selectTimeCollectionView: UICollectionView!
    
    // MARK: - Properties
    private var timeList: [String] = [] {
        didSet {
            selectTimeCollectionView.reloadData()
        }
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        assignDelegation()
        registerXib()
    }
    
    // MARK: - Functions
    private func setUI() {
        selectButtons.forEach {
            $0.cornerRadius = 10
        }
        [pillNameTextField, periodSelectButton, specificDayView, specificTermView].forEach {
            $0?.makeRoundedWithBorder(radius: 12, color: Color.gray300.cgColor)
        }
    }
    
    func presentViewController(viewControllers: UIViewController.Type) {
        let viewController = viewControllers.instanceFromNib()
        viewController.modalPresentationStyle = .overCurrentContext
        viewController.modalTransitionStyle = .crossDissolve
        self.present(viewController, animated: true)
    }
    
    func updateTermButtonAttributes(button: UIButton, width: CGFloat, borderColor: CGColor, backgroundColor: UIColor, setTitleColor: UIColor) {
        button.layer.borderWidth = width
        button.layer.borderColor = borderColor
        button.backgroundColor = backgroundColor
        button.setTitleColor(setTitleColor, for: .normal)
    }
    
    func assignDelegation() {
        selectTimeCollectionView.delegate = self
        selectTimeCollectionView.dataSource = self
    }

    func registerXib() {
        selectTimeCollectionView.register(PillTimeInfoCollectionViewCell.self)
        selectTimeCollectionView.register(PillTimeInfoFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: PillTimeInfoFooterView.reuseIdentifier)
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
                updateTermButtonAttributes(button: selectButtons[0], width: 1, borderColor: Color.darkMint.cgColor, backgroundColor: Color.lightMint, setTitleColor: Color.darkMint)
                updateTermButtonAttributes(button: selectButtons[1], width: 0, borderColor: Color.gray100.cgColor, backgroundColor: Color.gray100, setTitleColor: Color.gray500)
                updateTermButtonAttributes(button: selectButtons[2], width: 0, borderColor: Color.gray100.cgColor, backgroundColor: Color.gray100, setTitleColor: Color.gray500)
            } else {
                updateTermButtonAttributes(button: selectButtons[0], width: 0, borderColor: Color.gray100.cgColor, backgroundColor: Color.gray100, setTitleColor: Color.gray500)
            }
        case TermType.specificDay.rawValue:
            if sender.isSelected {
                specificDayView.isHidden = false
                specificTermView.isHidden = true
                selectButtons[0].isSelected = false
                selectButtons[2].isSelected = false
                updateTermButtonAttributes(button: selectButtons[1], width: 1, borderColor: Color.darkMint.cgColor, backgroundColor: Color.lightMint, setTitleColor: Color.darkMint)
                updateTermButtonAttributes(button: selectButtons[0], width: 0, borderColor: Color.gray100.cgColor, backgroundColor: Color.gray100, setTitleColor: Color.gray500)
                updateTermButtonAttributes(button: selectButtons[2], width: 0, borderColor: Color.gray100.cgColor, backgroundColor: Color.gray100, setTitleColor: Color.gray500)
            } else {
                specificDayView.isHidden = true
                specificTermView.isHidden = true
                updateTermButtonAttributes(button: selectButtons[1], width: 0, borderColor: Color.gray100.cgColor, backgroundColor: Color.gray100, setTitleColor: Color.gray500)
            }
        case TermType.specificTerm.rawValue:
            if sender.isSelected {
                specificDayView.isHidden = true
                specificTermView.isHidden = false
                selectButtons[0].isSelected = false
                selectButtons[1].isSelected = false
                updateTermButtonAttributes(button: selectButtons[2], width: 1, borderColor: Color.darkMint.cgColor, backgroundColor: Color.lightMint, setTitleColor: Color.darkMint)
                updateTermButtonAttributes(button: selectButtons[0], width: 0, borderColor: Color.gray100.cgColor, backgroundColor: Color.gray100, setTitleColor: Color.gray500)
                updateTermButtonAttributes(button: selectButtons[1], width: 0, borderColor: Color.gray100.cgColor, backgroundColor: Color.gray100, setTitleColor: Color.gray500)
            } else {
                specificDayView.isHidden = true
                specificTermView.isHidden = true
                updateTermButtonAttributes(button: selectButtons[2], width: 0, borderColor: Color.gray100.cgColor, backgroundColor: Color.gray100, setTitleColor: Color.gray500)
            }
        default: break
        }
    }
    
    @IBAction func touchUpToPeriodButton(_ sender: UIButton) {
        // TODO: - 화면전환
        presentViewController(viewControllers: MedicineCalendarViewController.self)
    }
    
    @IBAction func touchUpToDayButton(_ sender: Any) {
        presentViewController(viewControllers: WeekSelectViewController.self)
    }
    
    @IBAction func touchUpToTermButton(_ sender: Any) {
        presentViewController(viewControllers: TermSelectViewController.self)
    }
}

// MARK: - Extensions
extension PillInfoEditViewController: UICollectionViewDelegate {
    }

extension PillInfoEditViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return timeList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: PillTimeInfoCollectionViewCell.self)
            cell.makeRoundedWithBorder(radius: 12, color: Color.darkMint.cgColor)
            cell.timeLabel.text = timeList[indexPath.row]
            cell.deleteCellClosure = {
                self.timeList.remove(at: 0)
            }
            return cell
        }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let cell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: PillTimeInfoFooterView.reuseIdentifier, for: indexPath) as? PillTimeInfoFooterView else { return UICollectionReusableView()}
        cell.addCellClosure = {
            self.timeList.append("")
        }
        return cell
    }
}

extension PillInfoEditViewController: UICollectionViewDelegateFlowLayout {
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
            return CGSize(width: 333, height: 53)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 40, height: 150)
    }
}
