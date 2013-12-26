fs     = require 'fs'
mkdirp = require 'mkdirp'
util   = require './util'

echo = (content, flag = '__stdout__', file = '')->
    if flag is '__stdout__' and file is '' # echo to stdout
        console.log content
    else if flag is '__stderr__' and file is '' # echo to stderr
        console.error content
    else if (flag is '>' or flag is '>>') and file isnt '' # create new file or append to file
        # 判断content类型
        switch util.type(content)
            when '[object Object]', '[object Array]'
                content = JSON.stringify content
            else
                content = String content

        if file.indexOf('/') is -1 # no dirname specific
            if flag is '>'
                fs.writeFileSync file, content
            else if flag is '>>'
                if !fs.existsSync(file) or fs.readFileSync(file).toString() is '' # readFileSync not exists
                    fs.appendFileSync file, content
                else
                    fs.appendFileSync file, "\n#{content}"
        else # has dirname specific
            dirname = file.substr 0, file.lastIndexOf('/')
            mkdirp.sync dirname # 生成目录
            if flag is '>'
                fs.writeFileSync file, content
            else if flag is '>>'
                if !fs.existsSync(file) or fs.readFileSync(file).toString() is ''
                    fs.appendFileSync file, content
                else
                    fs.appendFileSync file, "\n#{content}"

echo.STDOUT = '__stdout__'
echo.STDERR = '__stderr__'

module.exports = echo
