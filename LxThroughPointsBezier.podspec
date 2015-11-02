Pod::Spec.new do |s|
  s.name     = 'LxThroughPointsBezier'
  s.version  = '1.0.0'
  s.license  = 'Apache'
  s.summary  = 'Draw a smooth bezier through several points you designated. The curve‘s bend level is adjustable.'
  s.homepage = 'https://github.com/DeveloperLx/LxThroughPointsBezier'
  s.authors  = { 'DeveloperLx' => 'developerlx@yeah.net' }
  s.source   = { :git => 'https://github.com/DeveloperLx/LxThroughPointsBezier.git', :tag => s.version, :submodules => true }
  s.requires_arc = true

  s.ios.deployment_target = '6.0'

  s.public_header_files = 'LxThroughPointsBezier/*.h'
  s.source_files = 'LxThroughPointsBezier/*'

  s.frameworks = 'Foundation', 'CoreGraphics'

end
