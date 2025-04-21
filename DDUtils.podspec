Pod::Spec.new do |s|
  s.name = 'DDUtils'
  s.swift_version = '5.0'
  s.version = '5.0.14'
  s.license = { :type => "MIT", :file => "LICENSE" }
  s.summary = 'DDUtils is a collection of commonly used features, developed based on Swift, that can be quickly implemented on iOS devices.'
  s.homepage = 'https://dongge.org/blog/1281.html'
  s.authors = { 'DDUtils' => 'dong765@qq.com' }
  s.source = { :git => "https://github.com/DamonHu/DDUtils.git", :tag => s.version }
  s.requires_arc = true
  s.ios.deployment_target = '11.0'
  s.weak_frameworks = 'CryptoKit'

  # subspec for core
  s.subspec 'core' do |cs|
    cs.source_files = "Sources/core/core/*.swift" 
  end

  # subspec for utils
  s.subspec 'utils' do |cs|
    cs.dependency 'DDUtils/core'
    cs.source_files = "Sources/core/utils/*.swift"  # 全小写路径
  end

  # subspec for ui
  s.subspec 'ui' do |cs|
    cs.dependency 'DDUtils/core'
    cs.source_files = "Sources/core/ui/*.swift"  # 全小写路径
  end

  # subspec for permission
  s.subspec 'permission' do |cs|
    cs.dependency 'DDUtils/core'
    cs.source_files = "Sources/core/permission/*.swift"  # 全小写路径
  end

  # subspec for idfa
  s.subspec 'idfa' do |cs|
    cs.dependency 'DDUtils/core'
    cs.dependency 'DDUtils/permission'
    cs.source_files = "Sources/idfa/*.swift"  # 全小写路径
  end

  # Basic subspec including all features
  s.subspec 'basic' do |cs|
    cs.dependency 'DDUtils/core'
    cs.dependency 'DDUtils/utils'
    cs.dependency 'DDUtils/ui'
    cs.dependency 'DDUtils/permission'
    cs.dependency 'DDUtils/idfa'
  end

  # Default subspec
  s.default_subspecs = 'basic'

  s.documentation_url = 'https://dongge.org/blog/1281.html'
end
