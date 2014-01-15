getType = (obj) ->
    Object::toString.call obj

class module.exports
    @isString: (obj)->
        getType obj is '[object String]'

    @isArray: (obj)->
        getType obj is '[object Array]'

    @isRegExp: (obj)->
        getType obj is '[object RegExp]'

    @isNumber: (obj)->
        getType obj is '[object Number]'

    @isObject: (obj)->
        getType obj is '[object Object]'

    @isFunction: (obj)->
        getType obj is '[object Function]'

    @isBoolean: (obj)->
        getType obj is '[object Boolean]'

    @isUndefined: (obj)->
        getType obj is '[object Undefined]'

    @isNull: (obj)->
        getType obj is '[object Null]'

    @isDate: (obj)->
        getType obj is '[object Date]'

    @isGlobal: (obj)->
        getType obj is '[object global]'

    @type: getType