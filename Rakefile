require "bundler/gem_tasks"

task default: :spec

desc "compile SASS stylesheets"
task :compile_sass do
  `sass assets/sass/style.scss --style compressed > assets/css/style.css`
end

# copied from rack-mini-profiler
desc "update asset version file"
task update_asset_version: :compile_sass do
  require 'digest/md5'
  h = []
  Dir.glob('assets/**/*.{js,css}').each do |f|
    h << Digest::MD5.hexdigest(::File.read(f))
  end

  File.open('lib/rack/faraday_inspector/asset_version.rb','w') do |f|
    f.write \
"module Rack
  module FaradayInspector
    ASSET_VERSION = '#{Digest::MD5.hexdigest(h.sort.join(''))}'.freeze
  end
end"
  end
end
