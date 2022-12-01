//
//  OnBoardingViewController.swift
//  SecretAgent
//
//  Created by JiwKang on 2022/11/30.
//

import UIKit

private enum FontSize {
    static let topLabelFontSize: Double = 28
}

private enum ViewSize {
    static let leadingInset = UIScreen.main.bounds.width / 13
    static let cornerRadius: Double = 30
    static let separatorInset = UIEdgeInsets(top: 0, left: leadingInset, bottom: 0, right: leadingInset)
    static let tipVStackViewMargin = UIEdgeInsets(top: UIScreen.main.bounds.height / 42.2, left: UIScreen.main.bounds.height / 42.2, bottom: UIScreen.main.bounds.height / 42.2, right: UIScreen.main.bounds.height / 42.2)
    
    static let titleLabelTopInset: Double = UIScreen.main.bounds.height / 17.22
    static let topHStackViewTopInset: Double = UIScreen.main.bounds.height / 7.74
    static let topHStackViewWidth: Double = UIScreen.main.bounds.width / 1.18
    static let guideLabelTopOffset: Double = UIScreen.main.bounds.height / 17.22
    static let guideLabelSize = CGSize(width: UIScreen.main.bounds.width / 1.18, height: 103)
    static let tipBodyHeight = UIScreen.main.bounds.width / 1.18
    static let tipVStackViewSize = CGSize(width: UIScreen.main.bounds.width / 1.18, height: UIScreen.main.bounds.height / UIScreen.main.bounds.width > 2 ? UIScreen.main.bounds.height / 6.15 : UIScreen.main.bounds.height / 6)
    static let tipVStackViewTopOffset: Double = UIScreen.main.bounds.height / 35.17
    static let showStoryButtonTopOffset: Double = UIScreen.main.bounds.height / 8.44
    static let showStoryButtonBottomInset: Double = UIScreen.main.bounds.height / 16.88
}

class OnBoardingViewController: BaseViewController {
    // MARK: - UI Properties
    
    let scrollView = UIScrollView()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "앱 사용 설명서"
        label.textColor = .black
        label.font = .regularSubheadline
        return label
    }()
    
    let topLabel: UILabel = {
        let label = UILabel()
        label.text = "부모님,\n꼭 읽어주세요"
        label.numberOfLines = 2
        label.font = .boldTitle1
        return label
    }()
    
    let topNextButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(ImageLiteral.skipButtonImage, for: .normal)
        return button
    }()
    
    lazy var topHStackView: UIStackView = {
        let hStackView = UIStackView()
        hStackView.distribution = .equalCentering
        hStackView.alignment = .center
        return hStackView
    }()
    
    let guideLabel: UILabel = {
        let label = UILabel()
        label.text = "비밀요원이 된 아이와 함께, 소음에 민감한\n'웅웅외계인'으로부터 우리 집을 지켜보아요!"
        label.numberOfLines = 3
        label.textAlignment = .center
        label.layer.cornerRadius = ViewSize.cornerRadius
        label.layer.masksToBounds = true
        label.textColor = UIColor(hex: "0087D3")
        label.backgroundColor = UIColor(hex: "0087D3").withAlphaComponent(0.1)
        label.textColor = .yoNavy
        label.layer.zPosition = 2
        label.font = .regularCallout
        return label
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorInset = ViewSize.separatorInset
        tableView.rowHeight = UITableView.automaticDimension
        tableView.isScrollEnabled = false
        tableView.estimatedRowHeight = UIScreen.main.bounds.width - 2 * ViewSize.leadingInset
        tableView.layer.zPosition = 1
        return tableView
    }()
    
    let tipVStackView: UIStackView = {
        let vStackView = UIStackView()
        vStackView.layer.cornerRadius = ViewSize.cornerRadius
        vStackView.layer.masksToBounds = true
        vStackView.backgroundColor = UIColor.yoYellow3
        vStackView.axis = .vertical
        vStackView.alignment = .leading
        vStackView.distribution = .equalSpacing
        vStackView.layoutMargins = ViewSize.tipVStackViewMargin
        vStackView.isLayoutMarginsRelativeArrangement = true
        return vStackView
    }()
    
    let tipTitle: UILabel = {
        let label = UILabel()
        label.text = "Tip !"
        label.font = UIFont.boldBody
        return label
    }()
    
    let tipBody: UILabel = {
        let label = UILabel()
        label.text = "집에서 조용히 걸어다니는 습관이 형성될 수 있도록 적극적으로 아이에게 뱃지 현황을 보여주세요!"
        label.numberOfLines = 4
        return label
    }()
    
    let showStoryButton: BaseButton = {
        let button = BaseButton()
        button.setButton(text: "Step 1 스토리보기 >", color: .clear)
        button.setBackgroundImage(ImageLiteral.primaryButtonBackground, for: .normal)
        button.setButtonTextColor(color: .black)
        button.titleLabel?.font = UIFont.boldTitle3
        return button
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configStack()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func render() {
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        scrollView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(ViewSize.leadingInset)
            make.top.equalToSuperview().inset(ViewSize.titleLabelTopInset)
        }
        
        scrollView.addSubview(topHStackView)
        topHStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(ViewSize.topHStackViewTopInset)
            make.width.equalTo(ViewSize.topHStackViewWidth)
        }
        
        scrollView.addSubview(guideLabel)
        guideLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(topHStackView.snp.bottom).offset(ViewSize.guideLabelTopOffset)
            make.size.equalTo(ViewSize.guideLabelSize)
        }
        
        scrollView.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(guideLabel.snp.bottom)
            make.width.equalToSuperview()
        }
        
        scrollView.addSubview(tipVStackView)
        tipVStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(ViewSize.tipVStackViewSize)
            make.top.equalTo(tableView.snp.bottom).offset(ViewSize.tipVStackViewTopOffset)
        }
        
        tipBody.snp.makeConstraints { make in
            make.height.equalTo(ViewSize.tipBodyHeight)
        }
        
        scrollView.addSubview(showStoryButton)
        showStoryButton.backgroundColor = .yellow
        showStoryButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(tipVStackView.snp.bottom).offset(ViewSize.showStoryButtonTopOffset)
            make.bottom.equalToSuperview().inset(ViewSize.showStoryButtonBottomInset)
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        tableView.snp.makeConstraints { make in
            make.height.equalTo(tableView.contentSize.height)
        }
        
        let newSize = tipBody.sizeThatFits(CGSize(width: UIScreen.main.bounds.width - 2 * ViewSize.leadingInset, height: Double.greatestFiniteMagnitude))
        
        tipBody.snp.makeConstraints { make in
            make.height.equalTo(newSize.height)
        }
        
        reloadInputViews()
    }
    
    override func configUI() {
        view.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func configStack() {
        topHStackView.addArrangedSubview(topLabel)
        topHStackView.addArrangedSubview(topNextButton)
        
        tipVStackView.addArrangedSubview(tipTitle)
        tipVStackView.addArrangedSubview(tipBody)
    }
}

// MARK: UITableViewDelegate, UITableViewDataSource

extension OnBoardingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Guide.GuideList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let guideData = Guide.GuideList[indexPath.row]
        let cell = OnBoardingTableViewCell(stepNo: guideData.stepNo, titleText: guideData.title, content: guideData.content)
        cell.selectionStyle = .none
        cell.isUserInteractionEnabled = false
        return cell
    }
}
