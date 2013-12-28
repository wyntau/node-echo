class module.exports
    @isString: (obj)->
        Object::toString.call obj is '[object String]'

    @isArray: (obj)->
        Object::toString.call obj is '[object Array]'

    @isRegExp: (obj)->
        Object::toString.call obj is '[object RegExp]'

    @isNumber: (obj)->
        Object::toString.call obj is '[object Number]'

    @isObject: (obj)->
        Object::toString.call obj is '[object Object]'

    @isFunction: (obj)->
        Object::toString.call obj is '[object Function]'

    @isBoolean: (obj)->
        Object::toString.call obj is '[object Boolean]'

    @isUndefined: (obj)->
        Object::toString.call obj is '[object Undefined]'

    @isNull: (obj)->
        Object::toString.call obj is '[object Null]'

    @isDate: (obj)->
        Object::toString.call obj is '[object Date]'

    @isGlobal: (obj)->
        Object::toString.call obj is '[object global]'

    @type: (obj)->
        Object::toString.call obj