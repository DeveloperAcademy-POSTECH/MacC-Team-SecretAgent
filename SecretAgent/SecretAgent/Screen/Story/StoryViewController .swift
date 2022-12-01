//
//  StoryViewController .swift
//  SecretAgent
//
//  Created by JiwKang on 2022/11/30.
//

import UIKit

private enum ViewSize {
    static let screenHeight = UIScreen.main.bounds.height
    static let screenWidth = UIScreen.main.bounds.width
    static let isLandscapeToPortrait = UIScreen.main.bounds.height > UIScreen.main.bounds.width
    
    static let skipButtonTopInset = isLandscapeToPortrait ? screenHeight / 29.10 : screenWidth / 29.10
    static let skipButtonTrailingInset = isLandscapeToPortrait ? screenWidth / 5.27 : screenHeight / 5.27
    static let linesLabelBottomInset = isLandscapeToPortrait ? screenHeight / 28.13 : screenWidth / 28.13
    static let linesLabelHeight = isLandscapeToPortrait ? screenHeight / 15.35 : screenWidth / 15.35
    static let linesLabelHorizontalInset = isLandscapeToPortrait ? screenWidth / 3.79 : screenHeight / 3.79
    static let preNextButtonHorizontalInset = isLandscapeToPortrait ? screenWidth / 4.81 : screenHeight / 4.81
}

class StoryViewController: BaseViewController {
    // MARK: - Properties
    
    private var sceneNo: Int = 0
    private var linesNo: Int = 0
    
    // MARK: - UI Properties
    
    private let storyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let skipButton: UIButton = {
        let button = UIButton()
        button.setTitle("건너뛰기", for: .normal)
        button.titleLabel?.font = .oneMobile(textStyle: .body)
        button.setTitleColor(.black, for: .normal)
        button.setBackgroundImage(ImageLiteral.storySkipButton, for: .normal)
        return button
    }()
    
    private let linesLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.layer.cornerRadius = 20
        label.layer.masksToBounds = true
        label.backgroundColor = UIColor(hex: "FFFBEC")
        label.font = .oneMobile(textStyle: .body)
        label.textColor = .black
        return label
    }()
    
    private let preButton: UIButton = {
        let button = UIButton()
        button.setImage(ImageLiteral.preButton, for: .normal)
        return button
    }()
    
    lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setImage(ImageLiteral.nextButton, for: .normal)
        return button
    }()
    
    // MARK: - Life Cycle
    
    override func loadView() {
        super.loadView()
        AppDelegate.AppUtility.changeOrientation(UIInterfaceOrientationMask.landscape)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        
        AppDelegate.AppUtility.changeOrientation(UIInterfaceOrientationMask.landscape)
        
        sceneNo = 0
        linesNo = 0
        storyImageView.image = Story.stories[sceneNo].sceneImage
        linesLabel.isHidden = true
        preButton.isHidden = true
        
        SoundManager.shared.setupSound(soundOption: SoundLiteral.scene1)
        SoundManager.shared.playSound()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTargets()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        AppDelegate.AppUtility.changeOrientation(UIInterfaceOrientationMask.portrait)
        SoundManager.shared.stopSound()
    }
    
    override func render() {
        view.addSubview(storyImageView)
        storyImageView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.top.bottom.equalToSuperview()
        }
        
        view.addSubview(skipButton)
        skipButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(ViewSize.skipButtonTopInset)
            make.trailing.equalToSuperview().inset(ViewSize.skipButtonTrailingInset)
        }
        
        view.addSubview(linesLabel)
        linesLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(ViewSize.linesLabelBottomInset)
            make.height.equalTo(ViewSize.linesLabelHeight)
            make.leading.equalToSuperview().inset(ViewSize.linesLabelHorizontalInset)
            make.trailing.equalToSuperview().inset(ViewSize.linesLabelHorizontalInset)
        }
        
        view.addSubview(preButton)
        preButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(ViewSize.preNextButtonHorizontalInset)
            make.centerY.equalTo(linesLabel)
        }
        
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(ViewSize.preNextButtonHorizontalInset)
            make.centerY.equalTo(linesLabel)
        }
    }
    
    override func configUI() {
        view.backgroundColor = .black
    }
    
    // MARK: - Func
    
    private func addTargets() {
        skipButton.addTarget(self, action: #selector(skipStory), for: .touchUpInside)
        preButton.addTarget(self, action: #selector(preStory), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(nextStory), for: .touchUpInside)
    }
    
    private func playSound(_ sound: SoundLiteral?, _ repeated: Bool = true) {
        SoundManager.shared.setupSound(soundOption: sound ?? .choiceLikeGoOut, repeated: repeated)
        SoundManager.shared.playSound()
    }
    
    private func nextSceneNoSet() {
        if sceneNo >= Story.stories.count, linesNo + 1 >= Story.stories.last?.lines.count ?? 0 {
            return
        }
        
        if (Story.stories[sceneNo].lines.count) - 1 > linesNo {
            linesNo += 1
        } else {
            sceneNo += 1
            linesNo = 0
            playSceneSound()
        }
    }
    
    private func preSceneNoSet() {
        if sceneNo > 0, linesNo <= 0 {
            sceneNo -= 1
            linesNo = (Story.stories[sceneNo].lines.count) - 1
            playSceneSound()
        } else if linesNo > 0 {
            linesNo -= 1
        }
    }
    
    private func drawStory() {
        let lines: String = linesNo >= 0 ? Story.stories[sceneNo].lines[linesNo] : ""
        if lines == "" {
            linesLabel.isHidden = true
        } else {
            linesLabel.isHidden = false
        }
        
        if sceneNo == 0, linesNo < 0 {
            preButton.isHidden = true
        } else {
            preButton.isHidden = false
        }
        
        storyImageView.image = Story.stories[sceneNo].sceneImage
        linesLabel.text = lines
    }

    private func playSceneSound() {
        if sceneNo < 7 {
            SoundManager.shared.stopSound()
            if Story.stories[sceneNo].backgroundSound != nil {
                playSound(Story.stories[sceneNo].backgroundSound, false)
            }
        } else if sceneNo == 7 {
            SoundManager.shared.stopSound()
            if Story.stories[sceneNo].backgroundSound != nil {
                playSound(Story.stories[sceneNo].backgroundSound)
            }
        }
    }
    
    @objc func preStory() {
        preSceneNoSet()
        drawStory()
    }
    
    @objc func nextStory() {
        preButton.isHidden = false
        nextSceneNoSet()
        
        if sceneNo
            >= Story.stories.count, linesNo + 1 >= Story.stories.last?.lines.count ?? 0 {
            navigationController?.pushViewController(AgentSelectionViewController(), animated: true)
            return
        }
        
        drawStory()
    }
    
    @objc func skipStory() {
        navigationController?.pushViewController(AgentSelectionViewController(), animated: true)
    }
}
