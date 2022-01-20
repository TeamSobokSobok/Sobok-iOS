//
//  AddMedicineFourthViewController.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/01/16.
//

import UIKit
import Moya

final class AddMedicineFourthViewController: BaseViewController {
    
    enum TossPill: Int {
        case me, friend
    }
    
    // MARK: Property
    var tossPill: TossPill?
    var pillNumber = Int()
    private var medicineList: [String] = [] {
        didSet {
            medicineInfoCollectionView.reloadData()
        }
    }
    
    // MARK: @IBOutlets
    @IBOutlet weak var navigationTitleLabel: UILabel!
    @IBOutlet weak var medicineInfoCollectionView: UICollectionView!
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionView()
        divideTossPill()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFriendPillCount(userId: 24)
    }
    
    // MARK: Functions
    
    private func divideTossPill() {
        navigationTitleLabel.text = tossPill == .me ? "내 약 목록" : "약 전송 목록"
    }
    
    private func updateData(data: PillCount) {
        pillNumber = data.pillCount
        medicineInfoCollectionView.reloadData()
    }

    private func setCollectionView() {
        medicineInfoCollectionView.delegate = self
        medicineInfoCollectionView.dataSource = self
        // register
        medicineInfoCollectionView.register(MedicineInfoCollectionViewCell.self)
        medicineInfoCollectionView.register(AddMyMedicineFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: AddMyMedicineFooterView.reuseIdentifier)
        medicineInfoCollectionView.register(MedicineInfoHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MedicineInfoHeaderView.reuseIdentifier)
        // flowLayout
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.estimatedItemSize = CGSize(width: UIScreen.main.bounds.width - 40, height: 166)
        medicineInfoCollectionView.collectionViewLayout = flowLayout
    }
    
    @IBAction func backButtonClicked(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveButtonClicked(_ sender: UIButton) {
        let sendInfoViewController = SendPillInfoViewController.instanceFromNib()
        sendInfoViewController.modalPresentationStyle = .overCurrentContext
        sendInfoViewController.modalTransitionStyle = .crossDissolve
        addMyFill()
        self.present(sendInfoViewController, animated: true)
    }
}

// MARK: UICollectionViewDelegate
extension AddMedicineFourthViewController: UICollectionViewDelegate {
    
}

// MARK: UICollectionViewDataSource
extension AddMedicineFourthViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return medicineList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: MedicineInfoCollectionViewCell.self)
        cell.deleteCellClosure = {
            self.medicineList.remove(at: 0)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MedicineInfoHeaderView.reuseIdentifier, for: indexPath) as? MedicineInfoHeaderView else { return UICollectionReusableView()}
            headerView.addPillLabel.text = "\(pillNumber)개 더 추가할 수 있어요"
            return headerView
            
        case UICollectionView.elementKindSectionFooter:
            
            guard let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: AddMyMedicineFooterView.reuseIdentifier, for: indexPath) as? AddMyMedicineFooterView else { return UICollectionReusableView()}
            
            // footerView 재사용
            footerView.withLabel.text = "새로운 약 추가하기"
            
            footerView.addMedicineCellClosure = {
                self.medicineList.append("")
                self.getMyPillCount()
            }
            return footerView
        default:
            assert(false, "응 아니야")
        }
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension AddMedicineFourthViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 40, height: 75)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 40, height: 54)
    }
}

extension AddMedicineFourthViewController {
    
    func getMyPillCount() {
        PillCountAPI.shared.getMyPillCount(completion: { (result) in
            switch result {
            case .success(let pill):
                if let data = pill as? PillCount {
                    print(data)
                }
            case .requestErr(let message):
                print("requestErr", message)
            case .pathErr:
                print(".pathErr")
            case .serverErr:
                print("serverErr")
            case .networkFail:
                print("networkFail")
            }
        })
    }
    
    func getFriendPillCount(userId: Int) {
        PillCountAPI.shared.getFriendPillCount(userId: userId, completion: { (result) in
            switch result {
            case .success(let pill):
                if let data = pill as? PillCount {
                    self.updateData(data: data)
                }
            case .requestErr(let message):
                print("requestErr", message)
            case .pathErr:
                print(".pathErr")
            case .serverErr:
                print("serverErr")
            case .networkFail:
                print("networkFail")
            }
        })
    }
    
    func addMyFill() {
        AddPillAPI.shared.addMyPill(pillName: "홍삼", isStop: false, color: "1", start: "2022-01-09", end: "2022-01-15", cycle: "1", day: "월, 수, 금, 일", time: ["07:00:00", "19:00:00"], specific: "1week") { response in
            print(response)
            switch response {
            case .success(let data):
                print(data)
            default:
                return
            }
        }
    }
}
