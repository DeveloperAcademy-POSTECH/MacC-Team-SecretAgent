//
//  Agent.swift
//  SecretAgent
//
//  Created by JiwKang on 2022/11/26.
//

import UIKit

struct Agent {
    let name: String
    let description: String
    let basicImage: UIImage
    let selectedImage: UIImage
    let disabledImage: UIImage

    static let agentList: [Agent] = [
        Agent(name: "포요",
              description: "언제나 열정을 가지고 멋지게\n임무를 성공해내는 요원 포요!",
              basicImage: ImageLiteral.agentPoyo,
              selectedImage: ImageLiteral.agentPoyoSelected,
              disabledImage: ImageLiteral.agentPoyoDisabled),
        Agent(name: "비요",
              description: "냉철한 분석력으로 밤밤외계인의\n흔적을 단번에 알아내는 요원 비요!",
              basicImage: ImageLiteral.agentBiyo,
              selectedImage: ImageLiteral.agentBiyoSelected,
              disabledImage: ImageLiteral.agentBiyoDisabled),
        Agent(name: "키요",
              description: "언제나 요원들을 든든하게\n지켜내는 힘이 쎈 요원 키요!",
              basicImage: ImageLiteral.agentKiyo,
              selectedImage: ImageLiteral.agentKiyoSelected,
              disabledImage: ImageLiteral.agentKiyoDisabled),
        Agent(name: "마요",
              description: "마요네즈처럼 부드럽고 상냥한\n똑똑한 요원 마요!",
              basicImage: ImageLiteral.agentMayo,
              selectedImage: ImageLiteral.agentMayoSelected,
              disabledImage: ImageLiteral.agentMayoDisabled)
    ]
}
