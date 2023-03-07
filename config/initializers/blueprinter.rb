# Blueprinter.configure do |config|
#   config.generator = Oj
#   config.if = ->(field_name, obj, _options) { !obj[field_name].nil? }
#   config.unless = ->(field_name, obj, _options) { obj[field_name].nil? }
# end