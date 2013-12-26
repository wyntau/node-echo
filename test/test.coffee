echo = require '..'
fs = require 'fs'
testStr = 'testStr'
dir = 'testdir'

describe 'echo', ->

    describe 'echo to current dir file', ->
        file = 'test.txt'
        it 'create', ->
            echo testStr, '>', file
            fs.readFileSync(file).toString().should.to.equal testStr

            fs.unlinkSync file

        it 'append', ->
            echo testStr, '>>', file
            fs.readFileSync(file).toString().should.to.equal testStr

            fs.unlinkSync file

        it 'createThenAppend', ->
            echo testStr, '>', file
            fs.readFileSync(file).toString().should.to.equal testStr

            echo testStr, '>>', file
            fs.readFileSync(file).toString().should.to.equal testStr + '\n' + testStr

            fs.unlinkSync file

        it 'appendThenCreate', ->
            echo testStr, '>>', file
            fs.readFileSync(file).toString().should.to.equal testStr

            echo testStr, '>', file
            fs.readFileSync(file).toString().should.to.equal testStr

            fs.unlinkSync file

        it 'createObject', ->
            obj = {str: true}
            echo obj, '>', file
            str = fs.readFileSync(file).toString()
            JSON.parse(str).should.to.deep.equal obj

            fs.unlinkSync file

        it 'createArray', ->
            arr = [1, 2, 3, 4]
            echo arr, '>', file
            str = fs.readFileSync(file).toString()
            JSON.parse(str).should.to.deep.equal arr

            fs.unlinkSync file

        it 'createFunction', ->
            func = ->
                'func'
            echo func, '>', file
            str = fs.readFileSync(file).toString()

            func2 = eval "(#{str})"

            func2().should.to.equal 'func'

            fs.unlinkSync file

        it 'appendObject', ->
            obj =
                str: true
            echo obj, '>>', file
            str = fs.readFileSync(file).toString()
            JSON.parse(str).should.to.deep.equal obj

            fs.unlinkSync file

        it 'createArray', ->
            arr = [1, 2, 3, 4]
            echo arr, '>>', file
            str = fs.readFileSync(file).toString()
            JSON.parse(str).should.to.deep.equal arr

            fs.unlinkSync file

        it 'appendFunction', ->
            func = ->
                'func'
            echo func, '>>', file
            str = fs.readFileSync(file).toString()

            func2 = eval "(#{str})"

            func2().should.to.equal 'func'

            fs.unlinkSync file

        it 'createAppendObject', ->
            obj =
                str: true
            echo '{', '>', file
            echo '"str":true}', '>>', file

            str = fs.readFileSync(file).toString()
            JSON.parse(str).should.to.deep.equal obj

            fs.unlinkSync file

    describe 'echo to subdir file', ->
        file = "#{dir}/test.txt"

        after ->
            fs.rmdirSync dir

        it 'create', ->
            echo testStr, '>', file
            fs.readFileSync(file).toString().should.to.equal testStr

            fs.unlinkSync file

        it 'append', ->
            echo testStr, '>>', file
            fs.readFileSync(file).toString().should.to.equal testStr

            fs.unlinkSync file

        it 'createThenAppend', ->
            echo testStr, '>', file
            fs.readFileSync(file).toString().should.to.equal testStr

            echo testStr, '>>', file
            fs.readFileSync(file).toString().should.to.equal testStr + '\n' + testStr

            fs.unlinkSync file

        it 'appendThenCreate', ->
            echo testStr, '>>', file
            fs.readFileSync(file).toString().should.to.equal testStr

            echo testStr, '>', file
            fs.readFileSync(file).toString().should.to.equal testStr

            fs.unlinkSync file

        it 'createObject', ->
            obj = {str: true}
            echo obj, '>', file
            str = fs.readFileSync(file).toString()
            JSON.parse(str).should.to.deep.equal obj

            fs.unlinkSync file

        it 'createArray', ->
            arr = [1, 2, 3, 4]
            echo arr, '>', file
            str = fs.readFileSync(file).toString()
            JSON.parse(str).should.to.deep.equal arr

            fs.unlinkSync file

        it 'createFunction', ->
            func = ->
                'func'
            echo func, '>', file
            str = fs.readFileSync(file).toString()

            func2 = eval "(#{str})"

            func2().should.to.equal 'func'

            fs.unlinkSync file

        it 'appendObject', ->
            obj =
                str: true
            echo obj, '>>', file
            str = fs.readFileSync(file).toString()
            JSON.parse(str).should.to.deep.equal obj

            fs.unlinkSync file

        it 'appendArray', ->
            arr = [1, 2, 3, 4]
            echo arr, '>>', file
            str = fs.readFileSync(file).toString()
            JSON.parse(str).should.to.deep.equal arr

            fs.unlinkSync file

        it 'appendFunction', ->
            func = ->
                'func'
            echo func, '>>', file
            str = fs.readFileSync(file).toString()

            func2 = eval "(#{str})"

            func2().should.to.equal 'func'

            fs.unlinkSync file

        it 'createAppendObject', ->
            obj =
                str: true
            echo '{', '>', file
            echo '"str":true}', '>>', file

            str = fs.readFileSync(file).toString()
            JSON.parse(str).should.to.deep.equal obj

            fs.unlinkSync file

    describe 'echo to std*', ->

        it 'echo to stdout', ->
            log = console.log
            console.log = sinon.spy()

            echo testStr

            console.log.should.have.been.callOnce
            console.log.should.have.been.calledWith testStr

            echo testStr, echo.STDOUT
            console.log.should.have.been.callTwice

            console.log = log

        it 'echo to stderr', ->
            err = console.error
            console.error = sinon.spy()

            echo testStr, echo.STDERR

            console.error.should.have.been.calledWith testStr

            console.error = err
