require "sprockets-helpers"
require_relative "./deep_symbolize"

class Blog
  class Post
    JEKYLL_HEADER_PATTERN = /---(.*)---/m
    JEKYLL_EXCERPT_SEPARATOR = /===/
    BLOG_IMAGE_PATH_PATTERN = /\(blog_image_path ([^\)]*)\)/

    include Sprockets::Helpers

    def initialize(file)
      @file = file
    end

    def slug
      @slug ||= (Pathname.new(@file).basename.to_s[/\d{4}-\d{2}-\d{2}-(.*)\.md/, 1])
    end

    def date
      @date ||= Date.parse(Pathname.new(@file).basename.to_s[/(\d{4}-\d{2}-\d{2})-.*\.md/, 1])
    end

    def excerpt
      @excerpt ||= markdown.render(article_content.split(JEKYLL_EXCERPT_SEPARATOR).first)
    end

    def excerpt?
      article_content.include? "==="
    end

    def content
      @content ||= markdown.render(article_content.gsub("===", ""))
    end

    def metadata
      @metadata ||= (
        yaml_content = JEKYLL_HEADER_PATTERN.match(file_content).captures[0]
        metadata = yaml_content ? YAML.load(yaml_content) : {}
        metadata.extend DeepSymbolizable
        metadata.deep_symbolize { |key| key }
      )
    end

    def title
      metadata[:title]
    end

    def thumbnail
      metadata[:thumbnail]
    end

    def pushed?
      metadata[:pushed] || false
    end

    private

    def file_content
      @file_content ||= File.read(@file)
    end

    def article_content
      @article_content ||= (
        content = file_content.gsub(JEKYLL_HEADER_PATTERN, '')
        content = content.gsub(BLOG_IMAGE_PATH_PATTERN) do
          "(#{image_path "blog/#{$1}"})"
        end
      )
    end

    def markdown
      @markdown ||= (
        Redcarpet::Markdown.new(PygmentizeHTML, fenced_code_blocks: true )
      )
    end

    class PygmentizeHTML < Redcarpet::Render::HTML
      def initialize(extensions = {})
        super extensions.merge(link_attributes: { target: "_blank" })
      end

      def block_code(code, language)
        language = :javascript if language == "json"
        language = :bash unless language
        require 'pygmentize'
        Pygmentize.process(code, language)
      end
    end
  end

  def all
    files.reverse.map do |file|
      Post.new(file)
    end
  end

  def pushed_posts
    all.select &:pushed?
  end

  def post(slug)
    slug.gsub!(".html", '')
    files.each do |file|
      return Post.new(file) if file.include?(slug)
    end
    nil
  end

  private

  def files
    Dir["#{File.dirname(__FILE__)}/../posts/*.md"].sort
  end
end