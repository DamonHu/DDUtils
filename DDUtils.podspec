Pod::Spec.new do |s|
s.name = 'DDUtils'
s.swift_version = '5.0'
s.version = '5.0.2'
s.license= { :type => "MIT", :file => "LICENSE" }
s.summary = 'DDUtils is a collection of commonly used features, developed based on Swift, that can be quickly implemented on iOS devices.'
s.homepage = 'https://github.com/DamonHu/DDUtils'
s.authors = { 'DDUtils' => 'dong765@qq.com' }
s.source = { :git => "https://github.com/DamonHu/DDUtils.git", :tag => s.version}
s.requires_arc = true
s.ios.deployment_target = '11.0'
s.weak_frameworks = 'CryptoKit'
s.subspec 'core' do |cs|
    cs.source_files = "pod/*.swift"
end
s.subspec 'utils' do |cs|
    cs.dependency 'DDUtils/core'
    cs.source_files = "pod/subspec/utils/*.swift"
end
s.subspec 'ui' do |cs|
    cs.dependency 'DDUtils/core'
    cs.source_files = "pod/subspec/UI/*.swift"
end
s.subspec 'permission' do |cs|
    cs.dependency 'DDUtils/core'
    cs.source_files = "pod/subspec/permission/*.swift"
end
s.subspec 'idfa' do |cs|
    cs.dependency 'DDUtils/core'
    cs.source_files = "pod/subspec/permission/PermissionConfig.swift", "pod/subspec/idfa/*.swift"
end
s.subspec 'basic' do |cs|
    cs.dependency 'DDUtils/core'
    cs.dependency 'DDUtils/utils'
    cs.dependency 'DDUtils/ui'
    cs.dependency 'DDUtils/permission'
end
s.default_subspecs = "basic"
s.documentation_url = 'https://ddceo.com/blog/1281.html'
end
