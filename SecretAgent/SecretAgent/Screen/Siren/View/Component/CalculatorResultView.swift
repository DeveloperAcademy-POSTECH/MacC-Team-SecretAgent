//
//  CalculatorResultView.swift
//  SecretAgent
//
//  Created by DaeSeong on 2022/11/28.
//

import UIKit

final class CalculatorResultView: UIStackView {
    // MARK: - Properties

    let firstOperand: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        label.text = "1"
        label.textColor = .yoBlack
        label.textAlignment = .right // FIXME: - 추후 수정 필요
        return label
    }()

    let secondOperand: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        label.text = "1"
        label.textColor = .yoBlack
        label.textAlignment = .center
        return label
    }()

    private let multiplier: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        label.text = "x"
        label.textColor = .yoYellow1
        label.textAlignment = .center
        return label
    }()

    private let equalLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        label.text = "="
        label.textColor = .yoYellow1
        label.textAlignment = .center
        return label
    }()

    let resultField: UITextField = {
        let textfield = UITextField()
        textfield.textAlignment = .center
        textfield.borderStyle = .none
        textfield.clearButtonMode = .always
        textfield.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        return textfield
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
        configUI()
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Func

    private func render() {
        addArrangedSubview(firstOperand)
        addArrangedSubview(multiplier)
        addArrangedSubview(secondOperand)
        addArrangedSubview(equalLabel)
        addArrangedSubview(resultField)

        resultField.snp.makeConstraints { make in
            make.width.equalTo(124)
        }
    }

    private func configUI() {
        axis = .horizontal
        alignment = .center
        distribution = .fill
        spacing = 20
    }

    func addBottomBorder() {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: resultField.frame.size.height + 4, width: resultField.frame.size.width, height: 4)
        bottomLine.backgroundColor = UIColor.yoYellow1.cgColor
        resultField.layer.addSublayer(bottomLine)
    }
}
