module DynamicSitemaps
  class DynamicGenerator < Generator
    # Generates the sitemap(s) and index based on the configuration file specified in DynamicSitemaps.config_path.
    # If you supply a block, that block is evaluated instead of the configuration file.
    def generate(&block)
      if block
        instance_eval &block
      else
        instance_eval open(DynamicSitemaps.config_path).read, DynamicSitemaps.config_path
      end
    end

    def sitemap(*args, &block)
      args << {} unless args.last.is_a?(Hash)
      args.last[:host] ||= host
      args.last[:protocol] ||= protocol
      args.last[:folder] ||= folder
      sitemap = Sitemap.new(*args, &block)

      DynamicSitemapGenerator.new(sitemap).generate
    end
  end
end
