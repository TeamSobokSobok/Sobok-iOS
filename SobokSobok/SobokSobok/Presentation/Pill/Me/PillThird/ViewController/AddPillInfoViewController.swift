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
    
    let addPillInfoView = AddPillInfoView()
    
    let timeArray: [String] = ["오전 10:00", "오후 12:30", "오후 3:00", "오후 5:20", "오후 7:30", "오후 10:50"]
    
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
    }
    
    func style() {
        view.backgroundColor = UIColor(white: 0.1, alpha: 0.5)
    }
    
    func bind() {
        addPillInfoView.sendButton.rx.tap.bind {
            self.sendPillViewModel.postFriendPill()
        }
        .disposed(by: disposeBag)
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
        return timeArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  addPillInfoView.pillPeriodTimeView.timeCollectionView.dequeueReusableCell(for: indexPath, cellType: TakePillTimeCollectionViewCell.self)
        
        cell.makeRoundedWithBorder(radius: 8, color: Color.darkMint.cgColor)
        cell.timeLabel.text = timeArray[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: timeArray[indexPath.item].size(withAttributes: [NSAttributedString.Key.font: UIFont.font(.pretendardRegular, ofSize: 17)]).width + 20, height: 32)
    }
}
