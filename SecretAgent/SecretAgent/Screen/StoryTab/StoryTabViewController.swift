//
//  StoryTabViewController.swift
//  SecretAgent
//
//  Created by JiwKang on 2022/12/01.
//

import UIKit

class StoryTabViewController: BaseViewController {
    private let vStackView: UIStackView = {
        let stackView = UIStackView()
        return stackView
    }()
    
    private let goToStoryButton: UIButton = {
        let button = UIButton()
        button.setImage(ImageLiteral.kiyoPlayButton, for: .normal)
        return button
    }()
    
    private let showStoryButton: UIButton = {
        let button = UIButton()
        button.setImage(ImageLiteral.biyoPlayButton, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func render() {
        view.addSubview(vStackView)
        vStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func configUI() {}
    
    func configStackView() {
        vStackView.addArrangedSubview(goToStoryButton)
        vStackView.addArrangedSubview(showStoryButton)
    }
}
