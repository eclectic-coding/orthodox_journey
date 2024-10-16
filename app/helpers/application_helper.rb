module ApplicationHelper
  def component(name, *args, **kwargs, &block)
    component = (name + "_component").to_s.camelize.constantize
    render(component.new(*args, **kwargs), &block)
  end
end
