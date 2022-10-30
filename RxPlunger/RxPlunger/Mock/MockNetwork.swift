//
//  MockNetwork.swift
//  RxPlunger
//
//  Created by Ellen J on 2022/10/26.
//

import Foundation

import RxSwift

// TODO: NetworkServiceType으로 네트워크 객체를 추상화한 이유는 무엇일까?
protocol NetworkServiceType {
    func request() -> Single<Result<[MockModel], RxPlungerError>>
}

// 모 프로젝트 스포일러가 될 수 있어서 가짜 네트워킹 객체를 만들었습니다.
final class MockNetWork: NetworkServiceType {
    
    private var models: [MockModel] = []
    
    init() {
        self.initiateModels()
    }
    
    func initiateModels() {
        self.models = [
            .init("Nose는 한글로?", description: "- 코다 -"),
            .init("네가 자꾸 쓰러지는 것은\n네가 꼭 이룰 것이 있기 때문이야.", description: "- 비비 -"),
            .init("사람은 둘로 나뉜다 채인놈과 안채인놈", description: "- 언체인 -"),
            .init("할까 말까 할 땐 무조건 해라!", description: "- 재재 -"),
            .init("김치찌개 먹고 싶어요", description: "- 수박 -"),
            .init("삼소가 최고다(feat. 된장찌개)", description: "- 키오 -"),
            .init("클라이밍은 사랑입니다❤️", description: "- 코든 -"),
            .init("일이 잘 안풀릴땐\n내가 귀여운 탓이라고 생각하자", description: "- 언체인 -"),
            .init("이게되네", description: "- 엘렌 -"),
            .init("전수혈?", description: "- 예거 -"),
            .init("모든건 다 내 손가락 문제다", description: "- 에버 -"),
            .init("부동산이 답이다", description: "- 린생 -"),
            .init("코딩도 좋지만 주말에는 쉽시다", description: "- 제임스 -"),
            .init("줄땐 주더라도 받을건 받자", description: "- 웨더 -")
        ]
    }
    
    func request() -> Single<Result<[MockModel], RxPlungerError>> {
        return Single<Result<[MockModel], RxPlungerError>>.create { [weak self] single in
            guard let self = self else {
                single(.success(.failure(RxPlungerError.custom("언래핑 실패"))))
                return Disposables.create()
            }
            
            single(.success(.success(self.models)))
            
            return Disposables.create()
        }
    }
}
