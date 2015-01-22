require "redcarpet"
require_relative '../lib/blog'

describe "Blog post" do
  Blog.new.all.each do |post|
    describe post.slug do
      it "does not say 'sur Paris'" do
        does_not_match?(post, /sur Paris/i)
      end

      it "does not say 'y'a'" do
        does_not_match?(post, /y'a/i)
      end
    end

    def does_not_match?(post, pattern)
      lines = post.send(:file_content).split("\n")
      lines.each_with_index do |line, index|
        expect(line).not_to match(pattern), "Line #{index + 1}"
      end
    end
  end
end