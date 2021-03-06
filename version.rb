module ReactiveExtensions
  def self.gem_version
    Gem::Version.new Version::STRING
  end

  module Version
    MAJOR = '0'
    MINOR = '5'
    PATCH = '2'
    PRE   = ''

    STRING = [MAJOR, MINOR, PATCH, PRE].join('.').chomp('.')
  end
end