class BaseController 

  def view(template, hash={})
    ch = ContextHelper.new(hash)
    path = File.expand_path("../../views/#{template}.html.erb", __FILE__)
    nested = ERB.new(File.read(path)).result(ch.get_binding)

    Rack::Response.new(
      ERB.new(
        File.read(
          File.expand_path("../../views/application.html.erb", __FILE__)
        )
      ).result(binding)
    )
  end

  def redirect_to(target)
    Rack::Response.new do |response|
      response.redirect(target)
    end
  end
end