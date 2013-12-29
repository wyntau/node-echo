echo    = require '..'
fs      = require 'fs'

str = 'testStr'
dir = 'testDir'
file = "#{dir}/test.txt"

describe 'echo.sync()', ->
    it 'sync onearg', ->
        log = console.log
        console.log = sinon.spy()
        echo.sync str
        console.log.should.have.been.calledOnce
        console.log.should.have.been.calledWith str

        console.log = log

    it 'sync twoarg', ->
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

    it 'sync create new file', ->
        echo.sync str, '>', file

        data = fs.readFileSync file,
            encoding: 'utf8'

        data.should.to.equal str

        fs.unlinkSync file
        fs.rmdirSync dir

    it 'sync append new file', ->
        echo.sync str, '>>', file

        data = fs.readFileSync file,
            encoding: 'utf8'
        data.should.to.equal str

        fs.unlinkSync file
        fs.rmdirSync dir

    it 'sync create then append', ->
        echo.sync str, '>', file

        data = fs.readFileSync file,
            encoding: 'utf8'

        data.should.to.equal str

        echo.sync str, '>>', file

        data = fs.readFileSync file,
            encoding: 'utf8'

        data.should.to.equal str + '\n' + str

        fs.unlinkSync file
        fs.rmdirSync dir

    it 'sync append then create', ->
        echo.sync str, '>>', file
        data = fs.readFileSync file,
            encoding: 'utf8'

        data.should.to.equal str

        echo.sync str, '>', file

        data = fs.readFileSync file,
            encoding: 'utf8'

        data.should.to.equal str

        fs.unlinkSync file
        fs.rmdirSync dir

    it 'sync echo Object', ->
        obj = {str: true}

        echo.sync obj, '>', file

        data = fs.readFileSync file,
            encoding: 'utf8'

        JSON.parse(data).should.to.deep.equal obj

        fs.unlinkSync file
        fs.rmdirSync dir

    it 'sync echo Array', ->
        arr = [1, 2, 3, 4]

        echo.sync arr, '>', file

        data = fs.readFileSync file,
            encoding: 'utf8'

        JSON.parse(data).should.to.deep.equal arr

        fs.unlinkSync file
        fs.rmdirSync dir

    it 'sync echo Function', ->
        func = ->
            'func'

        echo.sync func, '>', file

        data = fs.readFileSync file,
            encoding: 'utf8'

        func2 = eval "(#{data})"

        func2().should.to.equal 'func'

        fs.unlinkSync file
        fs.rmdirSync dir