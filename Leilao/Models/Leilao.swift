//
//  Leilao.swift
//  Leilao
//
//  Created by Ândriu Coelho on 27/04/18.
//  Copyright © 2018 Alura. All rights reserved.
//

import Foundation

class Leilao {
    
    let descricao:String
    let imagem:String?
    var lances:[Lance]?
    
    init(descricao:String, imagem:String? = nil, lances:[Lance] = []) {
        self.descricao = descricao
        self.imagem = imagem
        self.lances = lances
    }
    
    func propoe(lance:Lance) {

        guard let listaDeLances = lances else { return }

        if listaDeLances.count == 0 || podeDarLance(lance.usuario, listaDeLances){
            lances?.append(lance)
        }
    }

    private func ultimoLance(_ lances: [Lance]) -> Lance? {
        return lances.last
    }

    private func podeDarLance(_ usuario: Usuario, _ lances: [Lance]) -> Bool {
        return ultimoLance(lances)?.usuario != usuario && quantidadeDeLancesDoUsuario(usuario) < 5
    }

    private func quantidadeDeLancesDoUsuario(_ usuario: Usuario) -> Int {
        guard let listaDeLances = lances else { return 0 }
        var total = 0
        for lanceAtual in listaDeLances {
            if lanceAtual.usuario == usuario {
                total = total.advanced(by: 1)
            }
        }
        return total
    }
}
