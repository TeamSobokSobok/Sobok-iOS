//
//  SendInfoViewController.swift
//  SobokSobok
//
//  Created by 정은희 on 2022/01/11.
//

import UIKit

import Then
import SnapKit
import Lottie

final class SendInfoViewController: UIViewController {
    
    /*
     1. 헤더뷰 불러오기 (case)
     2. 날짜 형식 변환 ✔️
     3. 날짜 start, end 합치기 ✔️
     4. 시간 배열 3개씩 끊어서 꺼내오기 ✔️
     5. 이미지 이름 처리 ✔️
     6. 뷰컨에 2~5 적용
     7. 테이블뷰 셀 간격 피그마 디자인 수정 반영 ✔️
     */
    
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
}
