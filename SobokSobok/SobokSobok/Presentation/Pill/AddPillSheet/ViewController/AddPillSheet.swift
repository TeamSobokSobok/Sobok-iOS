//
//  AddMedicineSheet.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/01/09.
//

import UIKit

import RxCocoa
import RxSwift

protocol AddPillSheetDismiss: AnyObject {
    func addPillSheetDismiss()
    func pushAddFirstViewController()
}

protocol AddPillProtocol: StyleProtocol {}

final class AddPillSheet: UIViewController, AddPillProtocol {

    // MARK: Properties
    var pillNumber: Int = 10
    
    private lazy var input = AddPillSheetViewModel.Input(requestPillCount: requestPillCount.asSignal())
    
    private lazy var output = viewModel.transform(input: input)
    
    private let requestPillCount = PublishRelay<Void>()
    private let disposeBag = DisposeBag()
    
    private var viewModel: AddPillSheetViewModel
    
    init(with viewModel: AddPillSheetViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "AddPillSheet", bundle: Bundle.main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        requestPillCount.accept(())
    }
    
    weak var delegate: AddPillSheetDismiss?
    private let targetListForMedicine = [
        (image: Image.icMyFillPlus, text: "내 약 추가"),
        (image: Image.icFillSend, text: "다른 사람에게 약 전송")
    ]
 
    // MARK: @IBOutlet Properties
    
    @IBOutlet var mainView: UIView!
    @IBOutlet var medicineTableView: UITableView!
    @IBOutlet var sheetHeight: NSLayoutConstraint!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assignDelegation()
        bind()
    }
    
    func bind() {
        output.didLoadPillCount.drive(onNext: { _ in })
        .disposed(by: disposeBag)
    }
    
    func style() {
        mainView.layer.cornerRadius = 20
        mainView.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
        sheetHeight.constant = 0
    }
    
    // MARK: - Functions
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: true) {
            self.delegate?.addPillSheetDismiss()
        }
    }

    func assignDelegation() {
        medicineTableView.dataSource = self
        medicineTableView.delegate = self
        medicineTableView.register(AddPillTableViewCell.self)
    }
    
    func sheetWithAnimation() {
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.sheetHeight.constant = 258
            self?.view.layoutIfNeeded()
        }
    }
    
    @IBAction func closeButtonClicked(_ sender: UIButton) {
        self.dismiss(animated: true) {
            self.delegate?.addPillSheetDismiss()
        }
    }
}

extension AddPillSheet {
    private func pushPillLimitViewController() {
        self.dismiss(animated: true)
        guard let viewController = self.presentingViewController as? UITabBarController else { return }
        guard let selectedViewController = viewController.selectedViewController as? UINavigationController else { return }
        let pillLimitViewController = PillLimitViewController.instanceFromNib()
        selectedViewController.pushViewController(pillLimitViewController, animated: true)
    }
    
    private func pushPillFirstViewController(style: PillStyle) {
        self.dismiss(animated: true)
        guard let viewController = self.presentingViewController as? UITabBarController else { return }
        guard let selectedViewController = viewController.selectedViewController as? UINavigationController else { return }
        let addPillFirstViewController = AddPillFirstViewController.instanceFromNib()
        addPillFirstViewController.divide(style: .myPill)
        selectedViewController.pushViewController(addPillFirstViewController, animated: true)
    }
    
    private func pushNicknameViewController(tossPill: TossPill) {
        self.dismiss(animated: true)
        guard let viewController = self.presentingViewController as? UITabBarController else { return }
        guard let selectedViewController = viewController.selectedViewController as? UINavigationController else { return }
        let sendPillFirstViewController = SendPillFirstViewController.instanceFromNib()
        sendPillFirstViewController.type = tossPill
        selectedViewController.pushViewController(sendPillFirstViewController, animated: true)
    }
}

// MARK: - UITableViewDelegate
extension AddPillSheet: UITableViewDelegate {}

// MARK: - UITableViewDataSource

extension AddPillSheet: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return targetListForMedicine.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let medicineCell = medicineTableView.dequeueReusableCell(for: indexPath, cellType: AddPillTableViewCell.self)
        // 셀이 선택 되었을 때 배경색 변하지 않게
        medicineCell.selectionStyle = .none
        
        medicineCell.medicineImageView.image = targetListForMedicine[indexPath.row].image
        medicineCell.medicineTextLabel.text = targetListForMedicine[indexPath.row].text
        return medicineCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            output.didLoadPillCount.drive(onNext: { pillCount in
                if pillCount < 0 || pillCount == 0 {
                    self.pushPillFirstViewController(style: .myPill)
                } else {
                    self.pushPillLimitViewController()
                }
            })
            .disposed(by: disposeBag)
        } else {
            pushNicknameViewController(tossPill: .friendPill)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 82
    }
}
