//
//  StoryTabViewController.swift
//  SecretAgent
//
//  Created by JiwKang on 2022/12/01.
//

import UIKit

private enum ViewSize {
    static let vStackViewTopInset = UIScreen.main.bounds.height / 4.85
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
    
    private let goToStoryButton = StoryCell(image: ImageLiteral.kiyoPlayButton, subTitle: "도입", title: "요원으로 임명\n한다!")
    
    private let showOnboardingButton = StoryCell(image: ImageLiteral.biyoPlayButton, subTitle: "규칙서", title: "앱 사용 설명서")
    
    private let openSourceLicenceButton: UIButton = {
        let button = UIButton()
        button.setTitle("오픈소스 라이선스", for: .normal)
        button.titleLabel?.font = .regularCaption1
        button.setTitleColor(.yoGray5, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configStackView()
        addTargets()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        (navigationController as? BaseNavigationController)?.navigationButtons.isHidden = false
        tabBarController?.tabBar.isHidden = false
    }
    
    override func render() {
        view.addSubview(vStackView)
        vStackView.snp.makeConstraints { make in
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(ViewSize.vStackViewTopInset)
            make.size.equalTo(ViewSize.stackViewSize)
        }
        
        view.addSubview(openSourceLicenceButton)
        openSourceLicenceButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(UIScreen.main.bounds.height / 7.60)
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
        
        vStackView.addArrangedSubview(showOnboardingButton)
        showOnboardingButton.snp.makeConstraints { make in
            make.size.equalTo(ViewSize.buttonSize)
        }
    }
    
    private func addTargets() {
        showOnboardingButton.addTarget(self, action: #selector(viewOnBoarding), for: .touchUpInside)
        goToStoryButton.addTarget(self, action: #selector(viewStory), for: .touchUpInside)
        openSourceLicenceButton.addTarget(self, action: #selector(viewOpenSourceLicence), for: .touchUpInside)
    }
    
    @objc func viewStory() {
        (navigationController as? BaseNavigationController)?.navigationButtons.isHidden = true
        tabBarController?.tabBar.isHidden = true
        navigationController?.pushViewController(StoryViewController(), animated: true)
    }
    
    @objc func viewOnBoarding() {
        let onBoardingVC = OnBoardingViewController()
        onBoardingVC.modalPresentationStyle = .fullScreen
        onBoardingVC.showAgain()
        navigationController?.present(onBoardingVC, animated: true)
    }
    
    @objc func viewOpenSourceLicence() {
        navigationController?.pushViewController(OpenSourceViewController(), animated: true)
        (navigationController as? BaseNavigationController)?.navigationButtons.isHidden = true
    }
}
