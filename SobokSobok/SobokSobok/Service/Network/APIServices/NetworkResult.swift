//
//  NetworkResult.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/01/17.
//

import Foundation

enum NetworkResult<T> {
  case success(T)                    // 서버 통신 성공했을 때,
  case requestErr(T)            // 요청 에러 발생했을 때,
  case pathErr                        // 경로 에러 발생했을 때,
  case serverErr                    // 서버의 내부적 에러가 발생했을 때,
  case networkFail                // 네트워크 연결 실패했을 때
}

