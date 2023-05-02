//
//  TrainViewController.swift
//  Verregular
//
//  Created by Даниил Павленко on 23.04.2023.
//
import UIKit
import SnapKit

final class TrainViewController: UIViewController {
    // MARK: - GUI Variables
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        
        view.showsVerticalScrollIndicator = false
        
        return view
    }()
    
    private lazy var contentView: UIView = UIView()
    
    private lazy var pointsLabel: UILabel = {
        let label = UILabel()
        
        label.text = "\(count + 1)/\(maxPoints)"
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var infinitiveLabel: UILabel = {
        let label = UILabel()
        
        label.font = .boldSystemFont(ofSize: 28)
        label.textColor = .black
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var pastSimpleLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 14)
        label.text = "Past Simple"
        label.textColor = .gray
        
        return label
    }()
    
    private lazy var participleLabel: UILabel = {
        
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.text = "Past participle"
        label.textColor = .gray
        
        return label
    }()
    
    private lazy var pastSimpleTextField: UITextField = {
        let textField = UITextField()
        
        textField.borderStyle = .roundedRect
        textField.delegate = self
        
        return textField
    }()
    
    private lazy var participleTextField: UITextField = {
        let textField = UITextField()
        
        textField.borderStyle = .roundedRect
        textField.delegate = self
        
        return textField
    }()
    
    private lazy var checkButton: UIButton = {
        let button = UIButton()
        
        button.layer.cornerRadius = 10
        button.backgroundColor = .systemGray5
        button.setTitle("Check".localized, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(checkAction), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - Properties
    private let edgeInsets = 30
    private let dataSource = IrregularVerbs.shared.selectVerbs
    private let maxPoints = IrregularVerbs.shared.selectVerbs.count
    private var currentVerb: Verb? {
        guard dataSource.count > count else { return nil }
        return dataSource[count]
    }
    
    private var count = 0 {
        didSet {
            infinitiveLabel.text = currentVerb?.infinitive
            pastSimpleTextField.text = ""
            participleTextField.text = ""
            //Return button to normal status
            checkButton.backgroundColor = .systemGray5
            checkButton.setTitle("Check".localized, for: .normal)
            //Update points
            pointsLabel.text = "\(count + 1)/\(maxPoints)"
        }
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Train verbs".localized
        setupUI()
        registerForKeyboardNotification()
        unregisterForKeyboardNotification()
        hideKeyboardWhenTappedAround()
        infinitiveLabel.text = dataSource.first?.infinitive
    }
    
    // MARK: - Private methods
    @objc
    private func checkAction() {
        if checkAnswers() {
            count += 1
            if count == maxPoints {
                pointsLabel.text = "Training is over".localized
                showAlert()
            }
        } else {
            checkButton.backgroundColor = .systemRed
            checkButton.setTitle("Try again..".localized, for: .normal)
        }
    }
    
    private func checkAnswers() -> Bool {
        pastSimpleTextField.text?.lowercased() == currentVerb?.pastSimple &&
        participleTextField.text?.lowercased() == currentVerb?.participle
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: "Nice!".localized, message: "You training all words - ".localized + "\(count)/\(maxPoints)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK".localized, style: .default,
                                      handler: { action in
            self.navigationController?.popViewController(animated: true)
        }))
        present(alert, animated: true)
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubviews([
            pointsLabel,
            infinitiveLabel,
            pastSimpleLabel,
            pastSimpleTextField,
            participleLabel,
            participleTextField,
            checkButton])
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.size.edges.equalToSuperview()
        }
        
        infinitiveLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(150)
            make.leading.trailing.equalToSuperview().inset(edgeInsets)
        }
        
        pointsLabel.snp.makeConstraints { make in
            make.top.equalTo(infinitiveLabel.snp.bottom).inset(5)
            make.leading.trailing.equalToSuperview().inset(edgeInsets)
        }
        
        pastSimpleLabel.snp.makeConstraints { make in
            make.top.equalTo(infinitiveLabel.snp.bottom).offset(60)
            make.leading.trailing.equalToSuperview().inset(edgeInsets)
        }
        
        pastSimpleTextField.snp.makeConstraints { make in
            make.top.equalTo(pastSimpleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(edgeInsets)
        }
        
        participleLabel.snp.makeConstraints { make in
            make.top.equalTo(pastSimpleTextField.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(edgeInsets)
        }
        
        participleTextField.snp.makeConstraints { make in
            make.top.equalTo(participleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(edgeInsets)
        }
        
        checkButton.snp.makeConstraints { make in
            make.top.equalTo(participleTextField.snp.bottom).offset(100)
            make.leading.trailing.equalToSuperview().inset(edgeInsets)
        }
    }
}

// MARK: - UITextFieldDelegate
extension TrainViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if pastSimpleTextField.isFirstResponder {
            participleTextField.becomeFirstResponder()
        } else {
            hideKeyboard()
        }
        return true
    }
}

// MARK: - Keyboard events
private extension TrainViewController {
    func registerForKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_: )), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    func unregisterForKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc
    func keyboardWillHide() {
        scrollView.contentInset.bottom = .zero - 30
    }
    
    @objc
    func keyboardWillShow(_ notification: Notification) {
        guard let frame =
                notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey]
                as? CGRect else {return}
        scrollView.contentInset.bottom = frame.height + 30
    }
    
    func hideKeyboardWhenTappedAround() {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        
        scrollView.addGestureRecognizer(recognizer)
    }
    
    @objc
    func hideKeyboard() {
        scrollView.endEditing(true)
    }
}
