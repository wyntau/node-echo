echo    = require '..'
fs      = require 'fs'
async   = require 'async'

str = 'testStr'
dir = 'testDir'
file = "#{dir}/test.txt"

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
                (cbk)->
                    fs.unlink file, cbk
                ->
                    fs.rmdir dir, done
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
                (cbk)->
                    fs.unlink file, cbk
                ->
                    fs.rmdir dir, done
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
                (cbk)->
                    fs.unlink file, cbk
                ->
                    fs.rmdir dir, done
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
                (cbk)->
                    fs.unlink file, cbk
                ->
                    fs.rmdir dir, done
            ]

        it 'echo Object', (done)->
            obj = {str: true}
            async.waterfall [
                (cbk)->
                    echo obj, '>', file, cbk
                (cbk)->
                    fs.readFile file,
                        encoding: 'utf8'
                    , cbk
                (data, cbk)->
                    JSON.parse(data).should.to.deep.equal obj
                    cbk()
                (cbk)->
                    fs.unlink file, cbk
                ->
                    fs.rmdir dir, done
            ]

        it 'echo Array', (done)->
            arr = [1, 2, 3, 4]
            async.waterfall [
                (cbk)->
                    echo arr, '>', file, cbk
                (cbk)->
                    fs.readFile file,
                        encoding: 'utf8'
                    , cbk
                (data, cbk)->
                    JSON.parse(data).should.to.deep.equal arr
                    cbk()
                (cbk)->
                    fs.unlink file, cbk
                ->
                    fs.rmdir dir, done
            ]

        it 'echo Function', ->
            func = ->
                'func'
            async.waterfall [
                (cbk)->
                    echo func, '>', file, cbk
                (cbk)->
                    fs.readFile file,
                        encoding: 'utf8'
                    , cbk
                (data, cbk)->
                    func2 = eval "(#{data})"
                    func2().should.to.equal 'func'
                    cbk()
                (cbk)->
                    fs.unlink file, cbk
                ->
                    fs.rmdir dir, done
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
        it 'create new file', ->
            echo.sync str, '>', file

            data = fs.readFileSync file,
                encoding: 'utf8'

            data.should.to.equal str

            fs.unlinkSync file
            fs.rmdirSync dir

        it 'append new file', ->
            echo.sync str, '>>', file

            data = fs.readFileSync file,
                encoding: 'utf8'
            data.should.to.equal str

            fs.unlinksync file
            fs.rmdirSync dir

        it 'create then append', ->
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

        it 'append then create', ->
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

        it 'echo Object', ->
            obj = {str: true}

            echo.sync obj, '>', file

            data = fs.readFileSync file,
                encoding: 'utf8'

            JSON.parse(data).should.to.deep.equal obj

            fs.unlinkSync file
            fs.rmdirSync dir

        it 'echo Array', ->
            arr = [1, 2, 3, 4]

            echo.sync arr, '>', file

            data = fs.readFileSync file,
                encoding: 'utf8'

            JSON.parse(data).should.to.deep.equal arr

            fs.unlinkSync file
            fs.rmdirSync dir

        it 'echo Function', ->
            func = ->
                'func'

            echo.sync func, '>', file

            data = fs.readFileSync file,
                encoding: 'utf8'

            func2 = eval "(#{data})"

            func2().should.to.equal 'func'

            fs.unlinkSync file
            fs.rmdirSync dir
