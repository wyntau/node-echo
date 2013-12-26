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
MIT
