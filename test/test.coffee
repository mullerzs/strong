app = require '../server/server.js'
supertest = require "supertest"
should = require "should"

server = supertest.agent "http://localhost:3000"

describe "CommentController", ->
  before -> app.listen()
   
  it "should return 200 ok for /api/comments/fts", ->
    server.get("/api/comments/fts")
      .expect(200)
