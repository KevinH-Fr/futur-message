# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"

pin "jquery", to: "jquery.min.js", preload: false
pin "jquery_ujs", to: "jquery_ujs.js", preload: false
pin "local-time", to: "https://ga.jspm.io/npm:local-time@2.1.0/app/assets/javascripts/local-time.js"

pin "scroll_timeline", to: "scroll_timeline.js", preload: true # Set preload to true for priority loading

pin_all_from "app/javascript/controllers", under: "controllers"
pin "trix"
pin "@rails/actiontext", to: "actiontext.esm.js"
