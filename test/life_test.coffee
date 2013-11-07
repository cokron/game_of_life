chai = require 'chai'
chai.should() 

Life = require("#{__dirname}/../life").Life

expect = chai.expect
describe "Life", ->
  describe "constructor", ->
    it "should create a new game of life", ->
      matrix = [
        [0,0,0],
        [0,0,0],
        [0,0,0],
      ]
      life = new Life(matrix)
      matrix.should.equal life.matrix

    it "Lebende Zellen ohne lebenden Nachbarn sterben in der Folgegeneration", ->
      matrix = [
        [0,0,0],
        [0,1,0],
        [0,0,0],
      ]
      expected_matrix = [
        [0,0,0],
        [0,0,0],
        [0,0,0],
      ]

      life = new Life(matrix)
      life.iterate()
      expected_matrix.should.eql life.matrix

    it "Lebende Zellen mit nur einer Nachbarzelle sterben in der Folgegeneration", ->
      matrix = [
        [0,0,0],
        [0,1,1],
        [0,0,0],
      ]
      expected_matrix = [
        [0,0,0],
        [0,0,0],
        [0,0,0],
      ]

      life = new Life(matrix)
      life.iterate()
      expected_matrix.should.eql life.matrix

    it "Eine lebende Zelle mit zwei oder drei lebenden Nachbarn bleibt in der Folgegeneration lebend.", ->
      matrix = [
        [0,0,1],
        [0,1,0],
        [1,0,1],
      ]
      expected_matrix = [
        [0,0,0],
        [0,1,0],
        [0,0,0],
      ]

      life = new Life(matrix)
      life.iterate()
      life.matrix[1][1].should.eql 1


    it "Eine tote Zelle mit genau drei lebenden Nachbarn wird in der Folgegeneration neu geboren.", ->
      matrix = [
        [0,0,0],
        [0,0,0],
        [1,1,1],
      ]

      life = new Life(matrix)
      life.iterate()
      life.matrix[1][1].should.eql 1

    it "should allow matrices > 3x3", ->
      matrix = [
        [0,0,0,0],
        [0,0,0,0],
        [1,1,1,0],
        [1,1,1,0],
      ]
      life = new Life(matrix)
      life.iterate()

      life.matrix.length.should.eql matrix.length
      life.matrix[0].length.should.eql matrix[0].length
  