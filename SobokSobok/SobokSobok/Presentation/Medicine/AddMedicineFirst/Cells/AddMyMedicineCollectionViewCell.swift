//
//  AddMyMedicineCollectionViewCell.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/01/10.
//

import UIKit

protocol AddMyMedicineCollectionViewCellDelegate: AnyObject {
    func cellTextFieldChange(for cell: AddMyMedicineCollectionViewCell)
}

final class AddMyMedicineCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    var medicineTextFieldText = String()
    var deleteCellClosure: (() -> Void)?
    var cellHeightClosure: (() -> Void)?
    var index: Int?
    weak var delegate: AddMyMedicineCollectionViewCellDelegate?
    
    // MARK: - @IBOutlets
    
    @IBOutlet weak var rootView: UIView!
    @IBOutlet weak var medicineMainView: UIView!
    @IBOutlet weak var medicineTextField: UITextField!
    @IBOutlet weak var deleteTextButton: UIButton!
    @IBOutlet weak var deleteMedicineCellButton: UIButton!
    @IBOutlet weak var writingCountLabel: UILabel!
    @IBOutlet weak var medicineCellHeight: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
        setTextField()
        assignDelegate()
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        super.preferredLayoutAttributesFitting(layoutAttributes)
        layoutIfNeeded()
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        var frame = layoutAttributes.frame
        frame.size.height = ceil(size.height)
        layoutAttributes.frame = frame
        return layoutAttributes
    }
    
    // MARK: - Functions
    
    private func setUI() {
        medicineMainView.makeRoundedWithBorder(radius: 10, color: Color.gray300.cgColor)
    }
    
    private func assignDelegate() {
        medicineTextField.delegate = self
    }
    
    private func setTextField() {
        medicineTextField.addTarget(self, action: #selector(AddMyMedicineCollectionViewCell.medicineTextFieldDidChange(_:)), for: UIControl.Event.allEditingEvents)
    }
    
    // Color, Bool을 매개변수로 가지는 함수
    private func checkMedicineTextField(color: CGColor, bool: Bool) {
        medicineMainView.layer.borderColor = color
        deleteTextButton.isHidden = bool
        deleteMedicineCellButton.isHidden = true
        writingCountLabel.isHidden = false
    }
    
    private func updateUI() {
        writingCountLabel.isHidden = true
        deleteTextButton.isHidden = true
        deleteMedicineCellButton.isHidden = false
    }
    
    @objc func medicineTextFieldDidChange(_ textField: UITextField) {
        if let medicineText = medicineTextField.text {
            !medicineText.isEmpty ?
            checkMedicineTextField(color: Color.gray600.cgColor, bool: false) :
            checkMedicineTextField(color: Color.gray300.cgColor, bool: true)
        }
        
        // 글자 수 나타내기
        medicineTextField.attributedText = setAttributedText(text: medicineTextField.text!)
        writingCountLabel.attributedText = setAttributedText(text: "\(String(medicineTextField.text?.count ?? 0)) / 10")
        
    }
    
    // 글자 수 나타내기
    func setAttributedText(text: String) -> NSAttributedString {
        let attributeString = NSMutableAttributedString(string: text)
        attributeString.addAttribute(.foregroundColor, value: UIColor.black, range: (text as NSString).range(of: "/ 10자"))
        return attributeString
    }
    
    // MARK: - @IBActions
    // Delete버튼 클릭 시, 텍스트필드, 글자 수 초기화
    @IBAction func deleteButtonClicked(_ sender: UIButton) {
        medicineTextField.text = ""
        writingCountLabel.text = "0 / 10"
    }
    // 클로저를 활용해서 AddMyMedicineViewController에서 셀 삭제 가능하게 만듦
    @IBAction func deleteCellButtonClicked(_ sender: UIButton) {
        deleteCellClosure?()
    }
}

// MARK: UITextField Delegate
extension AddMyMedicineCollectionViewCell: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        guard let medicineText = medicineTextField.text else { return }
        checkMedicineTextField(color: Color.gray300.cgColor, bool: true)
        updateUI()
        cellHeightClosure?()
        medicineTextFieldText = medicineText
        self.delegate?.cellTextFieldChange(for: self)
    }
    
    // 텍스트필드 10글자까지 입력 가능하게 / 10글자 이상이면 입력 안 됨
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let medicineText = medicineTextField.text ?? ""
        guard let stringRange = Range(range, in: medicineText) else { return false }
        let updatedText = medicineText.replacingCharacters(in: stringRange, with: string)
        return updatedText.count <= 10
    }
}
