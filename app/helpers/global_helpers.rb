module Merb

  module GlobalHelpers

    @@views = {
      :jquery => [
        "core",
        "form",
        "metadata",
        "tablesorter",
        "dimensions",
        "corners",
        "bgiframe",
        "ui",
        "templating",
        "autocomplete"
      ],
      :app => [
        "master",
        "dashboard"
      ]
    }

    def javascripts_for(view)
      @@views[view].collect do |file|
        "<script type=\"text/javascript\" src=\"/javascripts/#{view}/#{file}.js\"></script>"
      end.join("\n")
    end

    def templates_for(*namespaces)
      namespaces.to_a.collect do |namespace|
        Dir["#{Merb.root}/app/views/#{namespace}/*.jqt"].map { |file| File.read(file) }.join("\n")
      end.join("\n")
    end
  end

end
