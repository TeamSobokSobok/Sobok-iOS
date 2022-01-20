//
//  SendInfoViewController.swift
//  SobokSobok
//
//  Created by 정은희 on 2022/01/11.
//

import UIKit

import Then
import SnapKit

final class SendInfoViewController: UIViewController {
    
    // MARK: - Properties
    let navigationView = UIView().then {
        $0.backgroundColor = .white
    }
    let navigationTitleLabel = UILabel().then {
        $0.text = "전송 받은 약"
        $0.font = .systemFont(ofSize: 17)
    }
    let xButton = UIButton().then {
        $0.setImage(Image.icClose48, for: .normal)
    }
    private var sendInfoList: PillMoreInfo? {
        didSet {
            sendInfoCollectionView.reloadData()
        }
    }
    var items: PillMoreInfo? {
        didSet {
            sendInfoCollectionView.reloadData()
        }
    }
    
    // MARK: - @IBOutlet Properties
    @IBOutlet weak var refuseButton: UIButton!
    @IBOutlet weak var acceptButton: UIButton!
    @IBOutlet weak var sendInfoCollectionView: UICollectionView!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setConstraints()
        assignDelegation()
        registerXib()
        getPillMoreInfo(senderId: 26, receiverId: 27, createdAt: "2022-01-13T16:59:57.168")
    }
    
    // MARK: - @IBAction Properties
    @IBAction func touchUpToClickAcceptButton(_ sender: UIButton) {
        // TODO: - 개수 초과 경고창 (데이터 전달)
        // TODO: - 화면 연결 (홈 화면)
        
    }
    @IBAction func touchUpToClickRejectButton(_ sender: UIButton) {
    }
    
    // MARK: - Functions
    private func setUI() {
        [navigationView, navigationTitleLabel, xButton].forEach {
            view.addSubview($0)
        }
        [refuseButton, acceptButton].forEach {
            $0?.makeRounded(radius: 12)
        }
        xButton.tintColor = Color.black
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
        
        xButton.snp.makeConstraints {
            $0.leading.equalTo(navigationView).inset(1)
            $0.centerY.equalTo(navigationTitleLabel)
        }
    }
    
    func assignDelegation() {
        sendInfoCollectionView.delegate = self
        sendInfoCollectionView.dataSource = self
    }
    
    func registerXib() {
        sendInfoCollectionView.register(SendInfoCollectionViewCell.self)
        sendInfoCollectionView.register(FooterCollectionViewCell.self)
        sendInfoCollectionView.register(SenderInfoCollectionViewCell.self)
    }
}

// MARK: - Extensions
extension SendInfoViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = items?.pillData?.count else { return 0 }
        return count + 1 // 푸터뷰 넣기 위해 +1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.row {
        case -1:    // TODO: - 0번째 셀인 case
            let header = collectionView.dequeueReusableCell(for: indexPath, cellType: SenderInfoCollectionViewCell.self)
            header.setData(sendInfoData: sendInfoList!)
            return header
        case items?.pillData?.count:
            let footer = collectionView.dequeueReusableCell(for: indexPath, cellType: FooterCollectionViewCell.self)
            return footer
        default:
            let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: SendInfoCollectionViewCell.self)
            if let pillData = items?.pillData?[indexPath.row] {
                cell.setData(sendInfoData: pillData)
            }
            cell.makeRoundedWithBorder(radius: 12, color: Color.gray300.cgColor)
            return cell
        }
    }
}

extension SendInfoViewController: UICollectionViewDelegate { }

extension SendInfoViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 11
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.row {
        case -1:
            return CGSize(width: 335, height: 48)
        case items?.pillData?.count:
            return CGSize(width: 335, height: 76)
        default:
            return CGSize(width: 335, height: 166)
        }
    }
}

extension SendInfoViewController {
    
    func getPillMoreInfo(senderId: Int, receiverId: Int, createdAt: String) {
        PillMoreInfoAPI.shared.getPillMoreInfo(senderId: senderId, receiverId: receiverId, createdAt: createdAt, completion: { [self] responseData in
            switch responseData {
            case .success(let pillInfoList):
                if let data = pillInfoList as? PillMoreInfo {
                    print("*** 넘어온 데이터 ***", data)
                    self.items = data
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
    
    func putAcceptPillInfo(sendGroupId: Int, isOkay: String) {
        AcceptPillInfoAPI.shared.putAcceptPillInfo(sendGroupId: sendGroupId, isOkay: isOkay, completion: { [self] responseData in
            switch responseData {
            case .success(let data):
                print("----", data)
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
}
