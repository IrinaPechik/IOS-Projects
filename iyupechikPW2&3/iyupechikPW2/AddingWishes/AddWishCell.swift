//
//  AddWishCell.swift
//  iyupechikPW2
//
//  Created by Печик Ирина on 14.11.2023.
//

import UIKit

final class AddWishCell: UITableViewCell {
    static let reuseId: String = "AddWishCell"
    private let wishLabel: UILabel = UILabel()
    
    private enum Constants {
        static let wrapColor: UIColor = .white
        static let wrapRadius: CGFloat = 16
        static let wrapOffsetV: CGFloat = 5
        static let wrapOffsetH: CGFloat = 10
        
        static let wishLabelOffset: CGFloat = 20
        
        static let textViewHeight: CGFloat = 80
        static let textViewFont: CGFloat = 18
        
        static let addWishButtonleftRightAnchor: CGFloat = 100
        static let addWishButtonTopAnchor: CGFloat = 90
    }

    let textView = UITextView()
    
    // Создаем кнопку для добавления желания.
    var addWishButton = UIButton()
    
    // Замыкание для добавления wishArray.
    var addWish: ((String) -> Void)?
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Отображение ячейки.
    private func configureUI() {
        selectionStyle = .none
        backgroundColor = .clear
        
        contentView.addSubview(textView)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.pinHorizontal(to: self, Constants.wrapOffsetH)
        textView.setHeight(Constants.textViewHeight)
        textView.backgroundColor = UIColor.white
        textView.layer.cornerRadius = Constants.wrapRadius
        textView.selectedTextRange = nil
        textView.textColor = .black
        textView.font = .systemFont(ofSize: Constants.textViewFont)
        textView.addPlaceholder("Enter you wish", textView: textView)
        textView.becomeFirstResponder()
        
        contentView.addSubview(addWishButton)
        addWishButton.translatesAutoresizingMaskIntoConstraints = false
        addWishButton.setTitle("Add wish", for: .normal)
        addWishButton.backgroundColor = .blue
        addWishButton.addTarget(self, action: #selector(addWishButtonTapped), for: .touchUpInside)
        addWishButton.layer.cornerRadius = Constants.wrapRadius
        
        addWishButton.pinLeft(to: contentView, Constants.addWishButtonleftRightAnchor)
        addWishButton.pinRight(to: contentView, Constants.addWishButtonleftRightAnchor)
        addWishButton.pinBottom(to: contentView)
        addWishButton.pinTop(to: contentView, Constants.addWishButtonTopAnchor)
    }
    
    // MARK: Обработка кнопки.
    @objc
    func addWishButtonTapped() {
        // Проверяем, что текст в UITextView не пустой.
        guard let text = textView.text,
              !text.isEmpty else {
            return
        }
        // Вызываем замыкание и передаем текст в качестве параметра.
        addWish?(text)
        // Очищаем поле UITextView.
        textView.text = ""
        textView.addPlaceholder("Enter you wish", textView: textView)
    }
}

// MARK: - AddPlaceholder
extension UITextView {
    func addPlaceholder(_ placeholder: String, textView: UITextView) {
        let placeholderLabel = UILabel()
        placeholderLabel.text = placeholder
        placeholderLabel.textColor = .lightGray
        placeholderLabel.font = self.font
        placeholderLabel.sizeToFit()
        placeholderLabel.isHidden = !self.text.isEmpty
        self.addSubview(placeholderLabel)
        placeholderLabel.frame.origin = CGPoint(x: 5, y: textView.selectedRange.location + 6)
        NotificationCenter.default.addObserver(forName: UITextView.textDidChangeNotification, object: self, queue: .main) { (notification) in
            placeholderLabel.isHidden = !self.text.isEmpty
        }
    }
}

