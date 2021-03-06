module ReactiveExtensions
  def self.files
    Files::FILES
  end

  module Files
    LIB_FILES = Dir.glob('./lib/**/*.rb').sort
    SPEC_FILES = Dir.glob('./spec/**/*.rb').sort
    BASE_FILES = %w(files.rb Gemfile LICENSE reactive_extensions.gemspec README.md version.rb)

    FILES = [LIB_FILES, SPEC_FILES, BASE_FILES].flatten
  end
end