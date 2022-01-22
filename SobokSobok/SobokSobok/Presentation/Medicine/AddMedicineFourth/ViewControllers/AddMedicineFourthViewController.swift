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
    var medicine : [Any] = []
    var pillNumber = Int()
    
    var checkCount = Int()
    var checkPillCount = Int()
    var number: Int = 0
    
    var medicineData: [String] = []
    var time: [String] = []
    var day = String()
    var specific = String()
    

    private var medicineList: [String] = [] {
        didSet {
            medicineInfoCollectionView.reloadData()
        }
    }
    
    // MARK: @IBOutlets
    @IBOutlet weak var addView: UIView!
    @IBOutlet weak var peopleNameLabel: UILabel!
    @IBOutlet weak var navigationTitleLabel: UILabel!
    @IBOutlet weak var addNumberLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var medicineInfoCollectionView: UICollectionView!
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionView()
        divideTossPill()
        getMyPillCount()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        divideTossPill()
    }
    
    override func style() {
        super.style()
        addView.makeRounded(radius: 8)
    }
    
    // MARK: Functions
    
    func pushAddMedicineViewController(tossPill: AddMyMedicineViewController.TossPill) {
        let addMyMedicineViewController = AddMyMedicineViewController.instanceFromNib()
        addMyMedicineViewController.tossPill = tossPill
        navigationController?.pushViewController(addMyMedicineViewController, animated: true)
    }
    
    private func divideTossPill() {
        guard let nickname = UserDefaults.standard.string(forKey: "friendName") else { return }
        switch tossPill {
        case .me:
            navigationTitleLabel.text = "내 약 목록"
            peopleNameLabel.text = "내가 먹을 약이에요"
            getMyPillCount()
            saveButton.setTitle("저장", for: .normal)
            addView.isHidden = false
        case .friend:
            navigationTitleLabel.text = "약 전송 목록"
            peopleNameLabel.text = "\(nickname)에게 전송할 약이에요"
            getFriendPillCount(userId: 24)
            saveButton.setTitle("전송", for: .normal)
            addView.isHidden = true
            peopleNameLabel.text = "\(nickname)에게 전송할 약이에요"
        default:
            break
        }
    }
    
    private func updateData(data: PillCount) {
        switch tossPill {
        case .me :
            if data.pillCount < 0 {
                checkCount = -data.pillCount + medicineData.count
                addNumberLabel.text = "저장 가능한 약 개수가 \(checkCount)개 초과되었어요"
                addView.backgroundColor = Color.lightPink
                addNumberLabel.textColor = Color.pillColorRed
                saveButton.setTitleColor(Color.gray400, for: .normal)
                saveButton.isEnabled = false
            } else if data.pillCount == 0 {
                if data.pillCount - medicineData.count < 0 {
                    checkCount = medicineData.count
                    addNumberLabel.text = "저장 가능한 약 개수가 \(checkCount)개 초과되었어요"
                    addView.backgroundColor = Color.lightPink
                    addNumberLabel.textColor = Color.pillColorRed
                    saveButton.setTitleColor(Color.gray400, for: .normal)
                    saveButton.isEnabled = false
                } else {
                    checkPillCount = 0
                    addNumberLabel.text = "\(checkPillCount)개 더 추가할 수 있어요"
                    addView.backgroundColor = Color.lightMint
                    addNumberLabel.textColor = Color.darkMint
                    saveButton.setTitleColor(Color.mint, for: .normal)
                    saveButton.isEnabled = true
                }
            } else {
                if data.pillCount - medicineData.count < 0 {
                    checkCount = -(data.pillCount - medicineData.count)
                    addNumberLabel.text = "저장 가능한 약 개수가 \(checkCount)개 초과되었어요"
                    addView.backgroundColor = Color.lightPink
                    addNumberLabel.textColor = Color.pillColorRed
                    saveButton.setTitleColor(Color.gray400, for: .normal)
                    saveButton.isEnabled = false
                } else if data.pillCount - medicineData.count == 0 {
                    checkCount = 0
                    addNumberLabel.text = "\(checkCount)개 더 추가할 수 있어요"
                    addView.backgroundColor = Color.lightMint
                    addNumberLabel.textColor = Color.darkMint
                    saveButton.setTitleColor(Color.mint, for: .normal)
                    saveButton.isEnabled = true
                } else {
                    checkPillCount = data.pillCount - medicineData.count
                    addNumberLabel.text = "\(checkPillCount)개 더 추가할 수 있어요"
                    addView.backgroundColor = Color.lightMint
                    addNumberLabel.textColor = Color.darkMint
                    saveButton.setTitleColor(Color.mint, for: .normal)
                    saveButton.isEnabled = true
                }
            }
            pillNumber = data.pillCount
            medicineInfoCollectionView.reloadData()
        case .friend:
            print("friend")
        default:
            break
        }
    }
    
    private func setCollectionView() {
        medicineInfoCollectionView.delegate = self
        medicineInfoCollectionView.dataSource = self
        // register
        medicineInfoCollectionView.register(MedicineInfoCollectionViewCell.self)
        medicineInfoCollectionView.register(AddMyMedicineFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: AddMyMedicineFooterView.reuseIdentifier)

        // flowLayout
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.estimatedItemSize = CGSize(width: UIScreen.main.bounds.width - 40, height: 166)
        medicineInfoCollectionView.collectionViewLayout = flowLayout
    }
    
    @IBAction func backButtonClicked(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveButtonClicked(_ sender: UIButton) {
        guard let nickname = UserDefaults.standard.string(forKey: "friendName") else { return }
        switch tossPill {
        case .me:
            addMyFill()
            let tabbarController = TabBarController.instanceFromNib()
            navigationController?.pushViewController(tabbarController, animated: true)
        case .friend:
            showAlert(title: "\(nickname)에게 \n\(medicineData.count)개의 약 정보를 보낼게요", message: "", completionTitle: "보내기", cancelTitle: "취소") {_ in
                let tabbarController = TabBarController.instanceFromNib()
                self.navigationController?.pushViewController(tabbarController, animated: true)
            }
        default:
            break
        }
    }
}

// MARK: UICollectionViewDelegate
extension AddMedicineFourthViewController: UICollectionViewDelegate {
    
}

// MARK: UICollectionViewDataSource
extension AddMedicineFourthViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return medicineData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: MedicineInfoCollectionViewCell.self)
        
        cell.pillNameLabel.text = medicineData[indexPath.row]
        cell.timeLabel.text = setData(timeData: time)
        cell.deleteCellClosure = {
            self.medicineData.remove(at: indexPath.row)
            collectionView.reloadData()
            self.number -= -1
            switch self.tossPill {
            case .me :
                if self.checkCount > 0 {
                    self.addNumberLabel.text = "저장 가능한 약 개수가 \(self.checkCount - self.number)개 초과되었어요"
                    if self.checkCount - self.number == 0 {
                        self.addNumberLabel.text = "0개 더 추가할 수 있어요"
                        self.addView.backgroundColor = Color.lightMint
                        self.addNumberLabel.textColor = Color.darkMint
                        self.saveButton.setTitleColor(Color.mint, for: .normal)
                        self.saveButton.isEnabled = true
                    } else if self.checkCount - self.number < 1 {
                        self.addNumberLabel.text = "\(-(self.checkCount - self.number))개 더 추가할 수 있어요"
                        self.addView.backgroundColor = Color.lightMint
                        self.addNumberLabel.textColor = Color.darkMint
                        self.saveButton.setTitleColor(Color.mint, for: .normal)
                        self.saveButton.isEnabled = true
                    }
                } else if self.checkCount == 0 {
                    self.addNumberLabel.text = "\(self.checkCount + self.number)개 더 추가할 수 있어요"
                }
                if self.checkPillCount > 0 {
                    self.addNumberLabel.text = "\(self.checkPillCount + self.number)개 더 추가할 수 있어요"
                }
            case .friend :
                print("firend")
            default :
                break
            }
        }
        return cell
    }
    
    func setData(timeData: [String]) -> String {
           var scheduleString: String = ""
           let scheduleTime = timeData
           for (index, value) in scheduleTime.enumerated() {
               if index == scheduleTime.count - 1 {
                   scheduleString += "\(value)"
               } else if index % 3 == 2 {
                   scheduleString += "\(value)\n"
               } else {
                   scheduleString += "\(value), "
               }
           }
        return scheduleString
       }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
       
            guard let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: AddMyMedicineFooterView.reuseIdentifier, for: indexPath) as? AddMyMedicineFooterView else { return UICollectionReusableView()}
            
            // footerView 재사용
            footerView.withLabel.text = "새로운 약 추가하기"
            footerView.withMedicineLabel.text = tossPill == .me ? "복약 중인 약을 포함해 \n 최대 5개까지 저장할 수 있어요" : "최대 5개까지 전송할 수 있어요"
            footerView.addMedicineCellClosure = {
                self.tossPill == .me ? self.pushAddMedicineViewController(tossPill: .me) : self.pushAddMedicineViewController(tossPill: .friend)
            }
            return footerView
        }
}

// MARK: UICollectionViewDelegateFlowLayout
extension AddMedicineFourthViewController: UICollectionViewDelegateFlowLayout {

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
        let colorArray: [String] = ["1", "2", "3", "4", "5"]
        var items: [PillListRequest] = []
        for (index, value) in medicineData.enumerated() {
            let body = PillListRequest(value, false, colorArray.randomElement()!, "2022-01-22", "2022-02-26", "1", nil, ["08:00:00", "13:00:00", "19:00:00"], nil)
            items.append(body)
        }
        let lists = PillLists(pillList: items)
        AddPillAPI.shared.addMyPill(body: lists) { response in

            switch response {
            case .success(let data):
                print(data)
            case .requestErr(let message):
                print("requestErr", message)
            case .pathErr:
                print(".pathErr")
            case .serverErr:
                print("serverErr")
            case .networkFail:
                print("networkFail")
            }
        }
    }
    
    func addMyFriendFill() {
        let array: [String] = ["1", "2", "3", "4", "5"]
        let body = PillListRequest("홍삼", false, array.randomElement() ?? "2", "2022-01-22", "2022-02-01", "1", nil, [
            "08:00:00", "13:00:00", "19:00:00"
        ], nil)
        var items: [PillListRequest] = []
        items.append(body)
        let lists = PillLists(pillList: items)
        
        AddPillAPI.shared.addFriendPill(memberId: 24, body: lists) { response in
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
