//
//  +Preview.swift
//  DesignSystem
//
//  Created by 리아 on 2022/10/16.
//  Copyright © 2022 zesty. All rights reserved.
//  https://github.com/DeveloperAcademy-POSTECH/MacC-TEAM-ZESTY/blob/06240dd8d9367eff7cc89545363359347aaae577/Projects/DesignSystem/Sources/Utility/%2BPreview.swift
//

import SwiftUI

extension UIViewController {
    private struct Preview: UIViewControllerRepresentable {
        let viewController: UIViewController

        func makeUIViewController(context: Context) -> UIViewController {
            return viewController
        }

        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
    }

    /// preview를 제공하는 함수
    ///
    /// ```swift
    /// struct ExViewControllerPreview: PreviewProvider {
    ///
    ///     static var previews: some View {
    ///         ExViewController().toPreview()
    ///     }
    ///
    /// }
    /// ```

    func toPreview() -> some View {
        Preview(viewController: self)
    }
}

extension UIView {
    private struct Preview: UIViewRepresentable {
        let view: UIView

        func makeUIView(context: Context) -> some UIView {
            return view
        }

        func updateUIView(_ uiView: UIViewType, context: Context) {}
    }

    /// preview를 제공하는 함수
    ///
    /// ```swift
    /// struct ExViewPreview: PreviewProvider {
    ///
    ///     static var previews: some View {
    ///         ExView().toPreview()
    ///     }
    ///
    /// }
    /// ```

    func toPreview() -> some View {
        Preview(view: self)
    }
}
