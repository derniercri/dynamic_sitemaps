module DynamicSitemaps
  class DynamicSitemapGenerator < SitemapGenerator
    attr_reader :buffer

    def generate
      super
      @buffer.string
    end

    def file
      @buffer ||= StringIO.new
    end
  end
end
