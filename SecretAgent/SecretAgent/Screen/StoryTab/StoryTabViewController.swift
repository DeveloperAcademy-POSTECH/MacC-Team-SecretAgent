//
//  StoryTabViewController.swift
//  SecretAgent
//
//  Created by JiwKang on 2022/12/01.
//

import UIKit

private enum ViewSize {
    static var buttonSize = CGSize(width: 338, height: 201)
    static var stackViewSize = CGSize(width: 338, height: 426)
}

class StoryTabViewController: BaseViewController {
    private let vStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 24
        stackView.alignment = .center
        return stackView
    }()
    
    private let goToStoryButton = StoryCell(image: ImageLiteral.kiyoPlayButton, subTitle: "도입", title: "요원으로\n임명한다!")
    
    private let showStoryButton = StoryCell(image: ImageLiteral.biyoPlayButton, subTitle: "규칙서", title: "앱 사용 설명서")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configStackView()
    }
    
    override func render() {
        view.addSubview(vStackView)
        vStackView.snp.makeConstraints { make in
            make.top.centerX.equalTo(view.safeAreaLayoutGuide)
            make.size.equalTo(ViewSize.stackViewSize)
        }
    }
    
    override func configUI() {
        view.backgroundColor = .white
    }
    
    func configStackView() {
        vStackView.addArrangedSubview(goToStoryButton)
        goToStoryButton.snp.makeConstraints { make in
            make.size.equalTo(ViewSize.buttonSize)
        }
        
        vStackView.addArrangedSubview(showStoryButton)
        showStoryButton.snp.makeConstraints { make in
            make.size.equalTo(ViewSize.buttonSize)
        }
    }
}
