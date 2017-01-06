require "erb"

class Msg::TemplatedBase < Msg::Base
  attr_reader :template_locals

  def initialize(args)
    super(args)
    @template_locals = {}
  end

  def respond
    path = Rails.root.join('app', 'views', 'msg',
                           "#{self.class.name.underscore.split('/')[1]}.erb")
    template = File.read(path)
    ERB.new(template).result(
                             OpenStruct.new(template_locals).instance_eval {
                               binding
                             } )
  end

end
