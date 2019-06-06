//
//  Avaliador.swift
//  Leilao
//
//  Created by Alura Laranja on 04/05/18.
//  Copyright © 2018 Alura. All rights reserved.
//

import Foundation

enum erroAvaliador: Error {
    case LeilaoSemLance(String)
}

class Avaliador {
    
    private var maiorDeTodos = Double.leastNonzeroMagnitude
    private var menorDeTodos = Double.greatestFiniteMagnitude
    private var maiores: [Lance] = []

    // configuramos o método avalia() para disparar uma exceção, caso não tenha lance em um leilão. Agora, precisamos escrever um teste para validar se isso realmente acontece.
    func avalia(leilao: Leilao) throws {

        if leilao.lances?.count == 0 {
            throw erroAvaliador.LeilaoSemLance("Não é possível avaliar um leilao sem lances.")
        }

        guard let lances = leilao.lances else { return }
        
        for lance in lances {
            if lance.valor > maiorDeTodos {
                maiorDeTodos = lance.valor
            }
            if lance.valor < menorDeTodos {
                menorDeTodos = lance.valor
            }
        }
        pegaOsMaioresLancesNoLeilao(leilao)
    }

    private func pegaOsMaioresLancesNoLeilao(_ leilao: Leilao) {
        guard let lances = leilao.lances else { return }

        maiores = lances.sorted(by: { (lista1, lista2) -> Bool in
            return lista1.valor > lista2.valor
        })

        let maioresLances = maiores.prefix(3)

        maiores = Array(maioresLances)
    }
    
    func maiorLance() -> Double {
        return maiorDeTodos
    }
    
    func menorLance() -> Double {
        return menorDeTodos
    }

    func tresMaiores() -> [Lance] {
        return maiores
    }
    
}
