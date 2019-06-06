//
//  AvaliadorTests.swift
//  LeilaoTests
//
//  Created by Lucas Valle on 03/06/2019.
//  Copyright © 2019 Alura. All rights reserved.
//

import XCTest
@testable import Leilao

class AvaliadorTests: XCTestCase {

    private var joao: Usuario!
    private var maria: Usuario!
    private var jose: Usuario!
    private var leiloeiro: Avaliador!

    override func setUp() {
        joao = Usuario(nome: "Joao")
        jose = Usuario(nome: "Jose")
        maria = Usuario(nome: "Maria")
        leiloeiro = Avaliador()
    }

    override func tearDown() {
        // Depois de qualquer teste irá passar por aqui no ciclo de vida, desalocar algo por exemplo
    }

    // Apenas um teste para cada classe de equivalência
    func testDeveEntenderLancesEmOrdemCrescente() {
        // Cenario

        //Facilitar cenário de teste, criar um teste data builder
        let leilao = CriadorDeLeilao().para(descricao: "Playstation 4")
                                    .lance(maria, 250.0)
                                    .lance(joao, 300.0)
                                    .lance(jose, 400.0).constroi()

        // Acao

        let leiloeiro = Avaliador()
        leiloeiro.avalia(leilao: leilao)

        // Validacao
        // Boa prática, sempre começar com o valor que espera no teste para facilitar a leitura

        XCTAssertEqual(250.0, leiloeiro.menorLance())
        XCTAssertEqual(400.0, leiloeiro.maiorLance())
    }

    // Um exemplo de outro teste de diferente classe de equivalência
    func testDeveEntenderLeilaoComApenasUmLance() {
        let leilao = Leilao(descricao: "Playstation 4")

        let lance = Lance(joao, 1000.0)
        leilao.propoe(lance: lance)

        let leiloeiro = Avaliador()
        leiloeiro.avalia(leilao: leilao)

        XCTAssertEqual(1000.0, leiloeiro.menorLance())
        XCTAssertEqual(1000.0, leiloeiro.maiorLance())
    }

    func testDeveEncontrarOsTresMaioresLances() {
        let leilao = Leilao(descricao: "Playstation 4")
        leilao.propoe(lance: Lance(joao, 300.0))
        leilao.propoe(lance: Lance(maria, 400.0))
        leilao.propoe(lance: Lance(joao, 500.0))
        leilao.propoe(lance: Lance(maria, 600.0))

        let leiloeiro = Avaliador()
        leiloeiro.avalia(leilao: leilao)

        let listaDeLances = leiloeiro.tresMaiores()

        XCTAssertEqual(3, listaDeLances.count)
        XCTAssertEqual(600.0, listaDeLances.first?.valor)
        XCTAssertEqual(500.0, listaDeLances[1].valor)
        XCTAssertEqual(400.0, listaDeLances[2].valor)
    }
}
