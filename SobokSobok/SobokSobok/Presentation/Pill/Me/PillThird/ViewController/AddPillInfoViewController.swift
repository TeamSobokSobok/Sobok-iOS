//
//  AddPillInfoViewController.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/05/04.
//

import UIKit

import RxCocoa
import RxSwift

protocol AddPillInfoProtocol: StyleProtocol, BindProtocol {}

final class AddPillInfoViewController: UIViewController, AddPillInfoProtocol {
    
    private let addPillInfoView = AddPillInfoView()
    
    let pillArray: [String] = ["김승찬", "김선영", "김태현", "정은희", "아요짱"]
    
    private let sendPillViewModel: SendPillViewModel
    
    private let disposeBag = DisposeBag()
    
    init(sendPillViewModel: SendPillViewModel) {
        self.sendPillViewModel = sendPillViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    enum Height {
        case minHeight
        case normalHeight
        case expandedHeight
    }
    
    var height: Height?
    
    var minHeight: CGFloat = UIScreen.main.bounds.height * 0.3
    var normalHeight: CGFloat = UIScreen.main.bounds.height * 0.5
    var expandedHeight: CGFloat = UIScreen.main.bounds.height * 0.9
    
    override func loadView() {
        self.view = addPillInfoView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewPanGesture()
        assignDelegation()
        bind()
        style()
    }
    
    func style() {
        view.backgroundColor = UIColor(white: 0.1, alpha: 0.5)
    }
    
    func bind() {
        addPillInfoView.sendButton.rx.tap.bind {
            self.sendPillViewModel.postFriendPill()
        }
        .disposed(by: disposeBag)
        
        switch sendPillViewModel.takeInterval {
        case 1:
            self.addPillInfoView.pillPeriodTimeView.pillSpecificLabel.text = "매일"
            self.addPillInfoView.pillPeriodTimeView.periodLabel.text = "월, 화, 수, 목, 금, 토, 일"
        case 2:
            self.addPillInfoView.pillPeriodTimeView.pillSpecificLabel.text = "특정 요일"
            self.addPillInfoView.pillPeriodTimeView.periodLabel.text = sendPillViewModel.day
        case 3:
            self.addPillInfoView.pillPeriodTimeView.pillSpecificLabel.text = "특정 간격"
            self.addPillInfoView.pillPeriodTimeView.periodLabel.text = sendPillViewModel.specific
        default:
            break
        }
        
        self.addPillInfoView.pillNameView.pillPeriodInfoLabel.text = "\(sendPillViewModel.start) ∼ \(sendPillViewModel.end)"
     
        
//        lazy var pillSpecificLabel = UILabel().then {
//            $0.text = "특정 주기"
//            $0.font = UIFont.font(.pretendardMedium, ofSize: 17)
//            $0.textColor = Color.darkMint
//        }
//
//        lazy var periodLabel = UILabel().then {
//            $0.text = "월, 화, 수, 목, 금, 토, 일"
//            $0.textColor = Color.gray800
//            $0.font = UIFont.font(.pretendardRegular, ofSize: 17)
//        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showBottomSheet()
    
    }
    
    private func assignDelegation() {
        addPillInfoView.pillPeriodTimeView.timeCollectionView.delegate = self
        addPillInfoView.pillPeriodTimeView.timeCollectionView.dataSource = self
        
        addPillInfoView.pillNameView.pillTableView.delegate = self
        addPillInfoView.pillNameView.pillTableView.dataSource = self
    }
    
    private func setViewPanGesture() {
        let backgroundViewTap = UITapGestureRecognizer(target: self, action: #selector(backgroundViewTapped(_:)))
        addPillInfoView.backgroundView.addGestureRecognizer(backgroundViewTap)
        addPillInfoView.backgroundView.isUserInteractionEnabled = true
        
        let viewPan = UIPanGestureRecognizer(target: self, action: #selector(viewPanned(_:)))
        viewPan.delaysTouchesBegan = false
        viewPan.delaysTouchesEnded = false
        view.addGestureRecognizer(viewPan)
    }
    
    @objc private func viewPanned(_ panGestureRecognizer: UIPanGestureRecognizer) {
        let translation = panGestureRecognizer.translation(in: self.view)
        
        switch panGestureRecognizer.state {
        case .began:
            setHeight(height: expandedHeight, bool: false)
        case .changed:
            if normalHeight + translation.y ~= normalHeight {
                setHeight(height: expandedHeight, bool: false)
            }
            
            if expandedHeight - translation.y < expandedHeight {
                setHeight(height: normalHeight, bool: true)
            }
            
            if normalHeight - translation.y < minHeight {
                setHeight(height: 0, bool: false)
                self.dismiss(animated: true, completion: nil)
            }
        
        default:
            break
        }
    }
    
    @objc private func backgroundViewTapped(_ tapRecognizer: UITapGestureRecognizer) {
        hideBottomSheet()
    }
    
    private func setHeight(height: CGFloat, bool: Bool) {
        addPillInfoView.bottomSheetView.snp.remakeConstraints {
            $0.height.equalTo(height)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
            self.addPillInfoView.pillNameView.isHidden = bool
        }, completion: nil)
    }
    
    private func showBottomSheet() {
        setHeight(height: normalHeight, bool: true)
    }
    
    private func hideBottomSheet() {
        setHeight(height: expandedHeight, bool: false)
        self.dismiss(animated: true, completion: nil)
    }
}

extension AddPillInfoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pillArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = addPillInfoView.pillNameView.pillTableView.dequeueReusableCell(for: indexPath, cellType: PillTableViewCell.self)
        
        cell.pillLabel.text = pillArray[indexPath.row]
        
        return cell
    }
}

extension AddPillInfoViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sendPillViewModel.time.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  addPillInfoView.pillPeriodTimeView.timeCollectionView.dequeueReusableCell(for: indexPath, cellType: TakePillTimeCollectionViewCell.self)
        
        cell.makeRoundedWithBorder(radius: 8, color: Color.darkMint.cgColor)
        cell.timeLabel.text = sendPillViewModel.time[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: sendPillViewModel.time[indexPath.item].size(withAttributes: [NSAttributedString.Key.font: UIFont.font(.pretendardRegular, ofSize: 17)]).width + 20, height: 32)
    }
}
