def render(text, options = {}, base = nil, &block)
  scope  = options.delete(:scope)  || Object.new
  locals = options.delete(:locals) || {}
  engine = HamlCustomTags::Engine.new(text, options)
  return engine.to_html(base) if base
  engine.to_html(scope, locals, &block)
end
