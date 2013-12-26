## node-echo


A shell like echo for node.js

### Usage:

#### echo to `std*`

1. echo to `stdout`

        var echo = require('node-echo');
        echo({something}[, echo.STDOUT]);

2. echo to `stderr`

        var echo = require('node-echo');
        echo({something}, echo.STDERR);

#### echo to `local file`

1. append to local file like shell's `echo 'content' >> test.txt`

        var echo = require('node-echo');
        echo({something}, '>>', {fileName});

2. replace local file like shell's `echo 'content' > test.txt`

        var echo = require('node-echo');
        echo({something}, '>', {fineName});

### Test:

    npm install
    npm test

### License

The MIT License (MIT)

Copyright (c) 2013 Jeremial jeremial90@gmail.com

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
