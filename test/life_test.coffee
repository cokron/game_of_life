chai = require 'chai'
chai.should() 

Life = require("#{__dirname}/../life").Life

expect = chai.expect
describe "Life", ->
  describe "constructor", ->
    it "should create a new game of life", ->
      matrix = [
        [0,0,0,0,0],
        [0,0,0,0,0],
        [0,0,0,0,0],
        [0,0,0,0,0],
        [0,0,0,0,0],
      ]
      life = new Life(matrix)
      matrix.should.equal life.matrix

    it "Lebende Zellen ohne lebenden Nachbarn sterben in der Folgegeneration", ->
      matrix = [
        [0,0,0,0,0],
        [0,1,0,0,0],
        [0,0,0,0,0],
        [0,0,0,0,0],
        [0,0,0,0,0],
      ]
      iterated_matrix = [
        [0,0,0,0,0],
        [0,0,0,0,0],
        [0,0,0,0,0],
        [0,0,0,0,0],
        [0,0,0,0,0],
      ]

      life = new Life(matrix)
      life.iterate()
      iterated_matrix.should.deep.equal life.matrix

