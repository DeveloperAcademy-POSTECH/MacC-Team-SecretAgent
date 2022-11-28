//
//  UnlockViewController.swift
//  SecretAgent
//
//  Created by DaeSeong on 2022/11/28.
//

import UIKit

import SnapKit

private enum Size {
    static let defaultOffset = 31
}
class UnlockViewController: BaseViewController {

    // MARK: - Properties

    private let dismissButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark", withConfiguration: UIImage.SymbolConfiguration(pointSize: 36, weight: .bold)), for: .normal)
        button.tintColor = .black
        return button
    }()

    private let mainLabel = {
        let label = UILabel()
        label.text = "보호자 확인"
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        return label
    }()

    private let subLabel = {
        let label = UILabel()
        label.text = "부모님 확인을 위해 정답을 입력해주세요."
        label.font = .regularSubheadline
        return label
    }()

    private let labelVStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        return stackView
    }()

    private let flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 8.0
        layout.itemSize = CGSize(width: 56, height: 76)
        return layout
    }()

    private lazy var  numberCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: flowLayout)
        collectionView.register(cell: NumberCollectionViewCell.self)
        return collectionView
    }()

    private let resultView = CalculatorResultView()

    private let cancelButton = {
        let button = UIButton()
        button.setTitle("취소", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 18
        button.backgroundColor = .gray
        return button
    }()

    private let unlockButton = {
        let button = UIButton()
        button.setTitle("잠금해제", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemYellow.withAlphaComponent(0.3)
        button.layer.cornerRadius = 18
        button.tintColor = .white
        button.isEnabled = false
        return button
    }()

    private let buttonHStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 28
        return stackView
    }()

    private var firstOperand = 0
    private var secondOperand = 0
    private var resultText = ""

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegation()
        getRandomInt()
        configOperand()
        addActions()
    }

    override func viewDidLayoutSubviews() {
        resultView.addBottomBorder()
    }

    override func render() {
        view.addSubview(dismissButton)
        dismissButton.snp.makeConstraints { make in
            make.size.equalTo(36)
            make.top.equalToSuperview().offset(74)
            make.trailing.equalToSuperview().inset(29)
        }

        labelVStackView.addArrangedSubview(mainLabel)
        labelVStackView.addArrangedSubview(subLabel)
        view.addSubview(labelVStackView)
        labelVStackView.snp.makeConstraints { make in
            make.top.equalTo(dismissButton.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(Size.defaultOffset)
        }

        view.addSubview(resultView)
        resultView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(50)
            make.top.equalTo(labelVStackView.snp.bottom).offset(94)
            make.height.equalTo(45)
        }

        buttonHStackView.addArrangedSubview(cancelButton)
        cancelButton.snp.makeConstraints { make in
            make.width.equalTo(150)
            make.height.equalTo(60)
        }
        buttonHStackView.addArrangedSubview(unlockButton)
        unlockButton.snp.makeConstraints { make in
            make.width.equalTo(150)
            make.height.equalTo(60)
        }
        view.addSubview(buttonHStackView)
        buttonHStackView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(70)
            make.leading.trailing.equalToSuperview().inset(Size.defaultOffset)
        }

        view.addSubview(numberCollectionView)
        numberCollectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Size.defaultOffset)
            make.bottom.equalTo(buttonHStackView.snp.top).offset(-70) // inset(70)하면 안되는데 이유가..
            make.height.equalTo(160)
        }

    }

    override func configUI() {
        super.configUI()
    }

    // MARK: - Func

    private func setDelegation() {
        numberCollectionView.delegate = self
        numberCollectionView.dataSource = self
        resultView.resultField.delegate = self

    }
    private func addActions() {
        let unlockAction = UIAction { [weak self] _ in
            guard let self else { return }
            if self.firstOperand * self.secondOperand == Int(self.resultText) {
                print("정답")
            } else {
                self.resultView.resultField.textColor = .red
            }
        }
        unlockButton.addAction(unlockAction, for: .touchUpInside)
    }

    private func getRandomInt() {
        firstOperand = Int.random(in: 1..<10)
        secondOperand = Int.random(in: 1..<10)

    }
    private func configOperand() {
        resultView.firstOperand.text = String(firstOperand)
        resultView.secondOperand.text = String(secondOperand)

    }
}

// MARK: - UICollectionViewDataSource

extension UnlockViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withType: NumberCollectionViewCell.self, for: indexPath)
        cell.configure(with: indexPath.row + 1)

        return cell
    }

}

// MARK: - UICollectionViewDelegate

extension UnlockViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if resultText.count < 2 {
            resultText += String((indexPath.row + 1) % 10)
            resultView.resultField.text = resultText
            unlockButton.isEnabled = true
            unlockButton.backgroundColor = .systemYellow
        }
    }

}

// MARK: - UITextFieldDelegate

extension UnlockViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
    }

    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        resultText = ""
        unlockButton.isEnabled = false
        unlockButton.backgroundColor = .systemYellow.withAlphaComponent(0.3)
        resultView.resultField.textColor = .black
        return true
    }

}

