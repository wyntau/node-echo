echo    = require '..'
fs      = require 'fs'
async   = require 'async'

str = 'testStr'
dir = 'testDir'
file = 'test.txt'

describe 'echo()', ->
    describe 'to std*', ->
        it 'one arg', ->
            log = console.log
            console.log = sinon.spy()
            echo str
            console.log.should.have.been.calledOnce
            console.log.should.have.been.calledWith str

            console.log = log

        it 'two arg', ->
            log = console.log
            err = console.error

            console.log = sinon.spy()
            console.error = sinon.spy()

            echo str
            echo str, echo.STDOUT
            echo str, echo.STDERR

            console.log.should.have.been.calledTwice
            console.error.should.have.been.calledOnce

            console.log = log
            console.error = err

        it 'three arg', ->
            err = console.error

            console.error = sinon.spy()

            spy = sinon.spy()

            echo str, echo.STDERR, spy

            console.error.should.have.been.calledOnce
            spy.should.have.been.calledOnce
            spy.should.have.been.calledWith null

            console.error = err

    describe 'to local file', ->
        it 'create new file', (done)->
            async.waterfall [
                (cbk)->
                    echo str, '>', file, cbk
                (cbk)->
                    fs.readFile file,
                        encoding: 'utf8'
                    , cbk
                (data, cbk)->
                    data.should.to.equal str
                    cbk()
                ->
                    fs.unlink file, done
            ]

        it 'append new file', (done)->
            async.waterfall [
                (cbk)->
                    echo str, '>>', file, cbk
                (cbk)->
                    fs.readFile file,
                        encoding: 'utf8'
                    , cbk
                (data, cbk)->
                    data.should.to.equal str
                    cbk()
                ->
                    fs.unlink file, done
            ]

        it 'create then append', (done)->
            async.waterfall [
                (cbk)->
                    echo str, '>', file, cbk
                (cbk)->
                    fs.readFile file,
                        encoding: 'utf8'
                    , cbk
                (data, cbk)->
                    data.should.to.equal str
                    cbk()
                (cbk)->
                    echo str, '>>', file, cbk
                (cbk)->
                    fs.readFile file,
                        encoding: 'utf8'
                    , cbk
                (data, cbk)->
                    data.should.to.equal str + '\n' + str
                    cbk()
                ->
                    fs.unlink file, done
            ]

        it 'append then create', (done)->
            async.waterfall [
                (cbk)->
                    echo str, '>>', file, cbk
                (cbk)->
                    fs.readFile file,
                        encoding: 'utf8'
                    , cbk
                (data, cbk)->
                    data.should.to.equal str
                    cbk()
                (cbk)->
                    echo str, '>', file, cbk
                (cbk)->
                    fs.readFile file,
                        encoding: 'utf8'
                    , cbk
                (data, cbk)->
                    data.should.to.equal str
                    cbk()
                ->
                    fs.unlink file, done
            ]

describe 'echo.sync()', ->
    describe 'to std*', ->
        it 'one arg', ->
            log = console.log
            console.log = sinon.spy()
            echo.sync str
            console.log.should.have.been.calledOnce
            console.log.should.have.been.calledWith str

            console.log = log

        it 'two arg', ->
            log = console.log
            err = console.error

            console.log = sinon.spy()
            console.error = sinon.spy()

            echo.sync str
            echo.sync str, echo.STDOUT
            echo.sync str, echo.STDERR

            console.log.should.have.been.calledTwice
            console.error.should.have.been.calledOnce

            console.log = log
            console.error = err

    describe 'to local file', ->
