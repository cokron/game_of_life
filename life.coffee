(exports ? this).Life ||=class
  constructor: (@matrix)->
        
  iterate: ->
    output = [
        [0,0,0],
        [0,0,0],
        [0,0,0],
      ]

    for row, i in @matrix
      for col, j in row
        output[i][j] = @survives(i,j)
        #output[i][j] = 1 if @comes_to_life(i,j)

    console.log "before: " + @print(@matrix) + "\nafter: " + @print(output)
    @matrix = output    


  survives: (i,j) ->
    return 0 if @matrix[i][j] == 0    
    sum = 
    @m(i-1,j-1) +
    @m(i-1,j)   +
    @m(i-1,j+1) +

    @m(i,j-1)   +
    @m(i,j+1)   +

    @m(i+1,j-1) +
    @m(i+1,j)   +
    @m(i+1,j+1)

    if sum == 2 || sum == 3 then 1 else 0

  m: (i,j) ->
    #console.log @matrix.length
    if i >=0 && j >=0 && i < @matrix.length && j < @matrix[0].length
      @matrix[i][j]
    else
      0


  print: (matrix) ->
    res = "\n"
    for row, i in matrix
      for col, j in row
        res = res + col + " "
      res = res + "\n"  
    res            