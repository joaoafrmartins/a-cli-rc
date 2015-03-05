{ existsSync, writeFileSync, readFileSync } = require 'fs'

class ACliRC

  constructor: (@options={}) ->

    value = null

    Object.defineProperty @, "value",

      get: () ->

        return value

      ,

      set: (obj) ->

        if typeof obj isnt "object" or Array.isArray(obj)

          throw new Error "invalid rc value #{obj}"

        value = obj

    @options.rcfile ?= ".aclirc"

    @rcfile = @options.rcfile

  read: () ->

    if existsSync @rcfile

      return @value = JSON.parse readFileSync(@rcfile).toString()

    return @value = {}

  save: () ->

    writeFileSync @rcfile, JSON.stringify @value, null, 2

  put: (k, v) ->

    if not @value then @read()

    if k then @value[k] = v

  del: (k) ->

    if not @value then @read()

    delete @value[k]

  get: (k) ->

    if not @value then @read()

    if not k then return @value

    return @value[k]

module.exports = ACliRC
