## node-echo


A shell like echo for node.js

### Usage:

#### 1. echo to `std*`

1. echo to `stdout`

        var echo = require('node-echo');
        echo(something[, echo.STDOUT]);

2. echo to `stderr`

        var echo = require('node-echo');
        echo(something, echo.STDERR);

#### 2. echo to `local file`

The `{something}` can be an `object`, an `array`, a `function` or a `string`

1. append to local file like shell's `echo 'content' >> test.txt`

        var echo = require('node-echo');
        echo(something, '>>', 'test.txt');

2. replace local file like shell's `echo 'content' > test.txt`

        var echo = require('node-echo');
        echo(something, '>', 'test.txt');

### Test:

    npm install
    npm test

### License
MIT
