gpio = require("pi-gpio")
express = require("express")
app = express()

class Power
  constructor: (@pin) ->

  write: (value, callback) ->
    gpio.open pin, "output", (err) ->
      gpio.write @pin, value, ->
        gpio.close pin
        callback if callback?

  on: (callback) ->
    @write 0, callback

  off: (callback) ->
    @write 1, callback

  time: (time) ->
    @on =>
      setTimeout =>
        @off
      , time

power = new Power(15)

app.get "/on", (req, res) ->
  res.send('power up')
  Power.on()

app.get "/off", (req, res) ->
  res.send('power down')
  Power.off()

app.listen(8080)
