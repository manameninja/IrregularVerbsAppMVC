//
//  TrainViewController.swift
//  Verregular
//
//  Created by Даниил Павленко on 23.04.2023.
//
import UIKit
import SnapKit

final class TrainViewController: UIViewController {
    
    enum State {
        case select, unselect
        
        var image: UIImage {
            switch self {
            case .select:
                return UIImage.checkmark
            case .unselect:
                return UIImage(systemName: "circlebadge") ?? UIImage.add
            }
        }
    }
    
    // MARK: - GUI Variables
    private lazy var pastSimpleImageView: UIImageView = {
        let view = UIImageView()
        
        view.image = State.unselect.image
        view.contentMode = .center
        
        return view
    }()
    
    private lazy var participleImageView: UIImageView = {
        let view = UIImageView()
        
        view.image = State.unselect.image
        view.contentMode = .center
        
        return view
    }()
    
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
        hideKeyboardWhenTappedAround()
        infinitiveLabel.text = dataSource.first?.infinitive
        checkingOnEmptySelectVerbs()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        registerForKeyboardNotification()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        unregisterForKeyboardNotification()
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
            pastSimpleImageView.image = State.unselect.image
            participleImageView.image = State.unselect.image
        } else {
            checkButton.backgroundColor = UIColor(named: "MyRedColor")
            checkButton.setTitle("Try again..".localized, for: .normal)
        }
    }
    
    private func checkAnswers() -> Bool {
        pastSimpleImageView.image == State.select.image &&
        participleImageView.image == State.select.image
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        switch textField {
        case pastSimpleTextField:
            let isValidPastSimple = pastSimpleTextField.text?.lowercased() == currentVerb?.pastSimple
            if isValidPastSimple {
                pastSimpleImageView.image = State.select.image
            } else {
                pastSimpleImageView.image = State.unselect.image
            }
        case participleTextField:
            let isValidParticiple = participleTextField.text?.lowercased() == currentVerb?.participle
            
            if isValidParticiple {
                participleImageView.image = State.select.image
            } else {
                participleImageView.image = State.unselect.image
            }
        default: print("unknown textField")
        }
        
    }
    
    private func checkingOnEmptySelectVerbs() {
        if maxPoints == 0 {
            pointsLabel.text = "Choice verbs in main menu".localized
            pastSimpleTextField.isEnabled = false
            participleTextField.isEnabled = false
            checkButton.isHidden = true
        } else {
            pastSimpleTextField.isEnabled = true
            participleTextField.isEnabled = true
            checkButton.isHidden = false
        }
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
            checkButton,
            pastSimpleImageView,
            participleImageView
        ])
        
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
            make.height.equalTo(40)
        }
        
        participleLabel.snp.makeConstraints { make in
            make.top.equalTo(pastSimpleTextField.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(edgeInsets)
        }
        
        participleTextField.snp.makeConstraints { make in
            make.top.equalTo(participleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(edgeInsets)
            make.height.equalTo(40)
        }
        
        checkButton.snp.makeConstraints { make in
            make.top.equalTo(participleTextField.snp.bottom).offset(100)
            make.leading.trailing.equalToSuperview().inset(edgeInsets)
            make.height.equalTo(50)
        }
        
        pastSimpleImageView.snp.makeConstraints { make in
            make.width.height.equalTo(20)
            make.top.equalTo(pastSimpleLabel.snp.bottom).offset(20)
            make.leading.equalTo(pastSimpleTextField.snp.trailing).inset(-4)
        }
        
        participleImageView.snp.makeConstraints { make in
            make.width.height.equalTo(20)
            make.top.equalTo(participleLabel.snp.bottom).offset(20)
            make.leading.equalTo(participleTextField.snp.trailing).inset(-4)
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unregisterForKeyboardNotification() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
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
