//
//  OpenSourceViewController.swift
//  SecretAgent
//
//  Created by DaeSeong on 2022/11/30.
//

import UIKit

import SnapKit

class OpenSourceViewController: BaseViewController {
    // MARK: - Properties

    lazy var textView: UITextView = {
        // Create a TextView.
        let textView = UITextView()
        textView.backgroundColor = .white
        textView.text = """
        원스토어 모바일 POP체 \n
        - https://www.gg-onestore.com/Font \n
        사운드 오픈소스 라이선스 \n
        - Sound Effect from <a href=“https://pixabay.com/sound-effects/?utm_source=link-attribution&amp;utm_medium=referral&amp;utm_campaign=music&amp;utm_content=25217”>Pixabay</a> \n- Sound Effect from <a href=“https://pixabay.com/sound-effects/?utm_source=link-attribution&amp;utm_medium=referral&amp;utm_campaign=music&amp;utm_content=6382”>Pixabay</a> \n- Sound Effect from <a href=“https://pixabay.com/sound-effects/?utm_source=link-attribution&amp;utm_medium=referral&amp;utm_campaign=music&amp;utm_content=25400”>Pixabay</a> \n- Sound Effect by <a href=“https://pixabay.com/ko/users/chetrarucraducu-23144124/?utm_source=link-attribution&amp;utm_medium=referral&amp;utm_campaign=music&amp;utm_content=11483”>chetrarucraducu</a> from <a href=“https://pixabay.com//?utm_source=link-attribution&amp;utm_medium=referral&amp;utm_campaign=music&amp;utm_content=11483”>Pixabay</a>\n Sound Effect from <a href=“https://pixabay.com/?utm_source=link-attribution&amp;utm_medium=referral&amp;utm_campaign=music&amp;utm_content=99752”>Pixabay</a> \n- Sound Effect from <a href=“https://pixabay.com/sound-effects/?utm_source=link-attribution&amp;utm_medium=referral&amp;utm_campaign=music&amp;utm_content=58832”>Pixabay</a> \n- Sound Effect from <a href=“https://pixabay.com/?utm_source=link-attribution&amp;utm_medium=referral&amp;utm_campaign=music&amp;utm_content=103467”>Pixabay</a> <a href=“https://pixabay.com/music/?utm_source=link-attribution&amp;utm_medium=referral&amp;utm_campaign=music&amp;utm_content=70”>Pixabay</a>의 음악 \n- Sound Effect by <a href=“https://pixabay.com/ko/users/irinairinafomicheva-25140203/?utm_source=link-attribution&amp;utm_medium=referral&amp;utm_campaign=music&amp;utm_content=13692”>irinairinafomicheva</a> from <a href=“https://pixabay.com//?utm_source=link-attribution&amp;utm_medium=referral&amp;utm_campaign=music&amp;utm_content=13692”>Pixabay</a> \n- Sound Effect from <a href=“https://pixabay.com/?utm_source=link-attribution&amp;utm_medium=referral&amp;utm_campaign=music&amp;utm_content=96243”>Pixabay</a> \n- Sound Effect from <a href=“https://pixabay.com/?utm_source=link-attribution&amp;utm_medium=referral&amp;utm_campaign=music&amp;utm_content=6185”>Pixabay</a> \n- Sound Effect from <a href=“https://pixabay.com/?utm_source=link-attribution&amp;utm_medium=referral&amp;utm_campaign=music&amp;utm_content=99029”>Pixabay</a> \n- Sound Effect from <a href=“https://pixabay.com/sound-effects/?utm_source=link-attribution&amp;utm_medium=referral&amp;utm_campaign=music&amp;utm_content=6081”>Pixabay</a> \n- Sound Effect by <a href=“https://pixabay.com/ko/users/studioalivioglobal-28281460/?utm_source=link-attribution&amp;utm_medium=referral&amp;utm_campaign=music&amp;utm_content=126515”>StudioAlivioGlobal</a> from <a href=“https://pixabay.com/sound-effects//?utm_source=link-attribution&amp;utm_medium=referral&amp;utm_campaign=music&amp;utm_content=126515”>Pixabay</a> \n- Sound Effect from <a href=“https://pixabay.com/sound-effects/?utm_source=link-attribution&amp;utm_medium=referral&amp;utm_campaign=music&amp;utm_content=6313”>Pixabay</a> \n- Sound Effect by <a href=“https://pixabay.com/ko/users/sergequadrado-24990007/?utm_source=link-attribution&amp;utm_medium=referral&amp;utm_campaign=music&amp;utm_content=21090”>SergeQuadrado</a> from <a href=“https://pixabay.com/sound-effects//?utm_source=link-attribution&amp;utm_medium=referral&amp;utm_campaign=music&amp;utm_content=21090”>Pixabay</a>
        """
        textView.layer.masksToBounds = true
        textView.font = UIFont.systemFont(ofSize: 13)
        textView.textColor = UIColor.black
        textView.textAlignment = NSTextAlignment.left
        textView.dataDetectorTypes = UIDataDetectorTypes.all
        textView.isEditable = false
        return textView
    }()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func render() {
        view.addSubview(textView)
        textView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(20)
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }

    override func configUI() {
        super.configUI()
        navigationItem.title = "오픈소스 라이선스"
        navigationController?.navigationBar.tintColor = .black
    }

    // MARK: - Func
}
