//
//  AddMedicineThirdViewController.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/01/14.
//

import UIKit

final class AddMedicineThirdViewController: BaseViewController {
 
    enum TossPill: Int {
        case me, friend
    }
    
    // MARK: - Properties
    private var medicineTimeData: [String] = ["오전 8:00", "오후 1:00", "오후 7:00"] {
        didSet {
            timeCollectionView.reloadData()
            UserDefaults.standard.set(medicineTimeData, forKey: "time")
        }
    }
    
    var medicineData: [String] = []
    var day = String()
    var specific = String()
    
    var tossPill: TossPill?
    var timeData = String()
    
    // MARK: @IBOutlet
    @IBOutlet weak var navigationTitleLabel: UILabel!
    @IBOutlet weak var timeCollectionView: UICollectionView!
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionView()
        
        print(medicineData)
        print(day)
        print(specific)
        switch tossPill {
        case .me:
            navigationTitleLabel.text = "내 약 추가하기"
        case .friend:
            navigationTitleLabel.text = "약 전송하기"
        default :
            break
        }
    }
    
    // MARK: Function
    
    func pushMedicineFourthViewController(tossPill: AddMedicineFourthViewController.TossPill) {
        let addMyMedicineViewController = AddMedicineFourthViewController.instanceFromNib()
        addMyMedicineViewController.tossPill = tossPill
        addMyMedicineViewController.medicineData = medicineData
        addMyMedicineViewController.time = medicineTimeData
        addMyMedicineViewController.day = day
        addMyMedicineViewController.specific = specific
        navigationController?.pushViewController(addMyMedicineViewController, animated: true)
    }
    
    private func setCollectionView() {
        timeCollectionView.dataSource = self
        timeCollectionView.delegate = self
        // register
        timeCollectionView.register(AddTimeCollectionViewCell.self)
        timeCollectionView.register(AddMedicineTimeFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: AddMedicineTimeFooterView.reuseIdentifier)
        // CollectionViewFlowLayout
        let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        timeCollectionView.contentInset = UIEdgeInsets.init(top: 8, left: 20, bottom: 0, right: 20)
        timeCollectionView.showsVerticalScrollIndicator = false
        timeCollectionView.collectionViewLayout = flowLayout
    }
    
    @IBAction func backButtonClicked(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func nextButtonClicked(_ sender: UIButton) {
        tossPill == .me ? pushMedicineFourthViewController(tossPill: .me) : pushMedicineFourthViewController(tossPill: .friend)
    }
}

// MARK: UICollectionViewDelegate
extension AddMedicineThirdViewController: UICollectionViewDelegate {
    
}

// MARK: UICollectionViewDataSource
extension AddMedicineThirdViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return medicineTimeData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: AddTimeCollectionViewCell.self)
        cell.timeLabel.text = medicineTimeData[indexPath.row]
        cell.deleteCellClosure = {
            // delete했을 때 자신의 index값을 지워야 함
            self.medicineTimeData.remove(at: indexPath.row)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard let cell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: AddMedicineTimeFooterView.reuseIdentifier, for: indexPath) as? AddMedicineTimeFooterView else { return UICollectionReusableView()}
        
        // FooterView +버튼 클릭 시 셀 추가
        cell.addCellClosure = {
            let addMedicineTimeSheet = MedicineTimeViewController.instanceFromNib()
            addMedicineTimeSheet.modalPresentationStyle = .overCurrentContext
            addMedicineTimeSheet.modalTransitionStyle = .crossDissolve
            addMedicineTimeSheet.sendTimeDelegate = self
            self.present(addMedicineTimeSheet, animated: false
            ) {
                DispatchQueue.main.async {
                    addMedicineTimeSheet.sheetWithAnimation()
                }
            }
        }
        if medicineTimeData.count == 6 {
            cell.addMedicineCellButton.isHidden = true
            cell.countCautionLabel.isHidden = false
        } else {
            cell.addMedicineCellButton.isHidden = false
            cell.countCautionLabel.isHidden = true
        }
        
        return cell
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension AddMedicineThirdViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 40, height: 54)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 40, height: 54)
    }
}

// MARK: Delegate
extension AddMedicineThirdViewController: SendPillTimeDelegate {
    func sendTimeData(pillTime: String) {
        medicineTimeData.append(pillTime)
    }
}
