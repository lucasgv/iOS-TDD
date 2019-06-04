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

    override func setUp() {
        // Antes de qualquer teste irá passar por aqui no ciclo de vida, pré inicializar algo por exemplo
    }

    override func tearDown() {
        // Depois de qualquer teste irá passar por aqui no ciclo de vida, desalocar algo por exemplo
    }

    // Apenas um teste para cada classe de equivalência
    func testDeveEntenderLancesEmOrdemCrescente() {
        // Cenario

        let joao = Usuario(nome: "Joao")
        let jose = Usuario(nome: "Jose")
        let maria = Usuario(nome: "Maria")

        let leilao = Leilao(descricao: "Playstation 4")
        leilao.propoe(lance: Lance(maria, 250.0))
        leilao.propoe(lance: Lance(joao, 300.0))
        leilao.propoe(lance: Lance(jose, 400.0))

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
        let joao = Usuario(nome: "joao")

        let leilao = Leilao(descricao: "Playstation 4")

        let lance = Lance(joao, 1000.0)
        leilao.propoe(lance: lance)

        let leiloeiro = Avaliador()
        leiloeiro.avalia(leilao: leilao)

        XCTAssertEqual(1000.0, leiloeiro.menorLance())
        XCTAssertEqual(1000.0, leiloeiro.maiorLance())
    }

    func testDeveEncontrarOsTresMaioresLances() {
        let joao = Usuario(nome: "joao")
        let maria = Usuario(nome: "Maria")

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
