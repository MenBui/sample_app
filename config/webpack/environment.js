const { environment } = require('@rails/webpacker')

const webpacker = require("webpacker")
environment.plugins.prepend("Provide"),
  new webpacker.ProvidePlugin({
    $: "jquery/src/jquery",
    jQuery: "jquery/src/jquery"
  })

module.exports = environment
