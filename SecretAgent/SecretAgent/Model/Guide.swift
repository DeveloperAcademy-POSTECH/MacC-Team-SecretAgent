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
        Guide(stepNo: 3, title: "사이렌 울리기", content: "아이가 뛰어다니거나, 행동 교정이 필요할 때 사이렌을 울려 경고를 해줍니다."),
        Guide(stepNo: 4, title: "행동 교정 성공 or 실패 판단", content: "15분의 타이머가 끝나면, 아이가 그 시간동안 다시 조용히 걸어다녔는지 아닌지를 판단하여 '성공' 혹은 '실패'버튼을 눌러주세요.\n'실패'버튼을 누른다면 일일 5개 코인뱃지 중 1개가 차감됩니다."),
        Guide(stepNo: 5, title: "스타뱃지 5개가 모인 날에는 선물을!", content: "코인뱃지 5개 = 방패뱃지 1개\n방패뱃지 5개 = 스타뱃지 1개\n스타뱃지 5개 = 미션 성공!\n스타뱃지 5개가 모인 날에는 아이에게 칭찬과 선물을 주시는 것이 어떨까요? :)\n이상적으로 사이렌이 한번도 울리지 않았을 시, 아이는 25일째 선물을 받을 수 있어요.")
    ]
}
