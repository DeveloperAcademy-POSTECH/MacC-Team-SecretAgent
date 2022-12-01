//
//  Guide.swift
//  SecretAgent
//
//  Created by JiwKang on 2022/11/30.
//

struct Guide {
    let stepNo: Int
    let title: String
    let content: String

    static let GuideList: [Guide] = [
        Guide(stepNo: 1, title: "아이와 함께 스토리 시청", content: "비밀요원 놀이를 이해하기 위하여 함께 스토리를 시청합니다."),
        Guide(stepNo: 2, title: "발급된 요원증과 뱃지 획득 현황 확인", content: "아이를 놀이에 몰입시키기 위해 '보드'탭에서 요원증을 보여주세요. 끝까지 뱃지를 모았을 때 보상이 있다는 것을 미리 얘기해주시면 좋아요!"),
        Guide(stepNo: 3, title: "사이렌 울리기", content: "일상생활을 하다가 아이가 시끄럽게 뛰어다닌다면 사이렌을 울려주세요. 사이렌은 부모님만 접근하실 수 있도록 잠금해제 구구단 문제를 푸셔야 해요! 15분 동안 다시 조심히 걷는 습관을 키울 기회를 아이에게 줄 수 있어요."),
        Guide(stepNo: 4, title: "행동 교정 성공 or 실패 판단", content: "15분의 타이머가 끝나면, 아이가 그 시간 동안 다시 조용히 걸어다녔는지 아닌지를 판단하여 ‘성공’ 혹은 ‘실패’ 버튼을 눌러주세요. 이는 뱃지 갯수에 영향을 미칩니다."),
        Guide(stepNo: 5, title: "스타뱃지 5개가 모인 날에는 선물을!", content: "코인뱃지 5개 = 방패뱃지 1개\n방패뱃지 5개 = 스타뱃지 1개\n스타뱃지 5개 = 미션 성공!\n스타뱃지 5개가 모인 날에는 아이에게 칭찬과 선물을 부탁드려요 : )\n이상적으로 사이렌이 한번도 울리지 않았을 시, 아이는 25일째 선물을 받을 수 있어요.")
    ]
}
