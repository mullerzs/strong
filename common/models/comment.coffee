module.exports = (Comment) ->
  Comment.echo2 = (p1, p2, cb) ->
    cb null, (p1 ? '') + ' : ' + (p2 ? '')

  Comment.remoteMethod 'echo2',
    http:
      verb : 'get'
      path : '/echo2'
    accepts: [
      arg  : 'p1'
      type : 'number'
      http : source: 'query'
    ,
      arg  : 'p2'
      type : 'number'
      http : source: 'query'
    ]
    returns:
      arg  : 'result'
      type : 'string' 
      

  Comment.fts = (terms, cb) ->
    # TODO: more sophisticated param handling
    terms = terms.split /\s+/ unless Array.isArray terms
    terms = terms.join ' & '
    console.log 'TERMS: ' + terms
    Comment.dataSource.connector.execute \
      "SELECT * FROM comment WHERE tsv @@ to_tsquery($1)",
      [ terms ],
      cb

  Comment.remoteMethod 'fts',
    http:
      verb : 'get'
      path : '/fts'
    accepts:
      arg  : 'terms'
      type : 'string'
      http : source: 'query'
    returns:
      arg  : 'data'
      type : [ 'Comment' ]
      root : true
