//
//  Story.swift
//  SecretAgent
//
//  Created by JiwKang on 2022/11/30.
//

import UIKit

struct Story {
    let sceneNo: Int
    let lines: [String]
    let sceneImage: UIImage
    let backgroundSound: SoundLiteral?
    let animation: Any?
    
    static let stories: [Story] = [
        Story(sceneNo: 1,
              lines: [],
              sceneImage: ImageLiteral.scene1,
              backgroundSound: SoundLiteral.scene1,
              animation: nil),
        
        Story(sceneNo: 2,
              lines: ["안녕하신가 이렇게 갑자기 찾아와서 미안하네.",
                      "워낙 급한 일이라서 말이야.",
                      "나는 고요지구연구소의 소장 고요한이라고 해.\n다름이 아니라..",
                      "지구가 위험해!!!!!!!!!"],
              sceneImage: ImageLiteral.scene2,
              backgroundSound: SoundLiteral.scene2,
              animation: nil),
        
        Story(sceneNo: 3,
              lines: ["며칠 전 지구에 ‘웅웅행성' 외계인들이 지구에 왔어!"],
              sceneImage: ImageLiteral.scene3,
              backgroundSound: SoundLiteral.scene3,
              animation: nil),
        
        Story(sceneNo: 4,
              lines: ["그것도 여기.  우리가 살고 있는 한국에 도착했다네"],
              sceneImage: ImageLiteral.scene4,
              backgroundSound: SoundLiteral.scene4,
              animation: nil),
        
        Story(sceneNo: 5,
              lines: ["녀석들은 집에서 뛰면 나는 소리를 먹고 살아.",
                      "쿵. 쾅! 한 번이 녀석들에겐 맛있는 사탕 한 입인거야."],
              sceneImage: ImageLiteral.scene5,
              backgroundSound: SoundLiteral.scene5,
              animation: nil),
        
        Story(sceneNo: 6,
              lines: ["집에서 뛰는 소리가 약간이라도 나면, 아주 큰 귀로 어디서 난 소린지 찾아가.", "녀석들을 가만두면 안돼"],
              sceneImage: ImageLiteral.scene6,
              backgroundSound: SoundLiteral.scene6,
              animation: nil),
        
        Story(sceneNo: 7,
              lines: ["웅웅외계인들은 소리를 먹고 점점 커지고 난폭해지게 돼.",
                      "만약 그렇게 되면 우리 지구가 웅웅외계인에게 정복당하는건 시간 문제야.",
                      "녀석들이 더 커져버리기 전에.. 지구에서 쫓아내야해!"],
              sceneImage: ImageLiteral.scene7,
              backgroundSound: SoundLiteral.scene7,
              animation: nil),
        
        Story(sceneNo: 8,
              lines: ["그래서 자네가 비밀요원단, 꼬요즈가  되어줄 수 있겠나?!",
                      "웅웅외계인으로부터 지구를 지키고 녀석들과 함께 싸워주게나!",
                      "이건 자네밖에 못하는 일이라네 부탁이야."],
              sceneImage: ImageLiteral.scene8,
              backgroundSound: SoundLiteral.scene8to12,
              animation: nil),
        
        Story(sceneNo: 9,
              lines: ["좋아 지금부터 자네의 집은 기지가 되는 거라네.",
                      "진정한 요원이 되기 위한 첫번째 임무를 주겠어.",
                      "바로 웅웅외계인으로부터 기지를 잘 지켜내는 거야.",
                      "집에서 뛰는 소리를 냈다간 웅웅외계인이 금방 기지를 찾아내버리겠지?!"],
              sceneImage: ImageLiteral.scene9,
              backgroundSound: nil,
              animation: nil),
        
        Story(sceneNo: 10,
              lines: ["밖에서는 뛰어도 되지만, 집에서는 사뿐사뿐 걸어야 소리가 나지 않아.",
                      "웅웅외계인이 아무것도 먹을 수 없게 해보자!"],
              sceneImage: ImageLiteral.scene10,
              backgroundSound: nil,
              animation: nil),
        
        Story(sceneNo: 11,
              lines: ["하루를 무사히 보낼 때마다 보상을 주지.",
                      "무사히 스타뱃지 5개를 모아오면 명예요원으로 임명하겠네!"],
              sceneImage: ImageLiteral.scene11,
              backgroundSound: nil,
              animation: nil),
        
        Story(sceneNo: 12,
              lines: ["명예요원이 되는 그날까지! 화이팅!!"],
              sceneImage: ImageLiteral.scene12,
              backgroundSound: nil,
              animation: nil)
    ]
}
