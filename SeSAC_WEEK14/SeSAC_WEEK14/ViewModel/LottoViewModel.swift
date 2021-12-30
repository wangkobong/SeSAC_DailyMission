//
//  LottoViewModel.swift
//  SeSAC_WEEK14
//
//  Created by sungyeon kim on 2021/12/28.
//

import Foundation

class LottoViewModel {
    
    var lotto1 = Observabel(3)
    var lotto2 = Observabel(13)
    var lotto3 = Observabel(33)
    var lotto4 = Observabel(32)
    var lotto5 = Observabel(12)
    var lotto6 = Observabel(11)
    var lotto7 = Observabel(30)
    var lottoMoney: Observabel<String> = Observabel("")
//    var lottoDate =
    
    func fetchLottoAPI(_ number: Int) {
        APIService.lotto(number) { lotto, error in
            print(lotto)
            print(error)
            
            guard let lotto = lotto else {
                return
            }
            
            self.lotto1.value = lotto.drwtNo1
            self.lotto2.value = lotto.drwtNo2
            self.lotto3.value = lotto.drwtNo3
            self.lotto4.value = lotto.drwtNo4
            self.lotto5.value = lotto.drwtNo5
            self.lotto6.value = lotto.drwtNo6
            self.lotto7.value = lotto.bnusNo
            self.lottoMoney.value = self.format(for: lotto.firstWinamnt) // 300,000,000
        }
    }
    
    func format(for number: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let result = numberFormatter.string(for: number)!
        return result
    }
}
