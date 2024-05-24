Pod::Spec.new do |s|
s.name = 'DDUtils'
s.swift_version = '5.0'
s.version = '5.0.0'
s.license= { :type => "MIT", :file => "LICENSE" }
s.summary = 'DDUtils. A package library of commonly used functions on the iOS platform, which can realize multiple complex functions in one sentence'
s.homepage = 'https://github.com/DamonHu/DDUtils'
s.authors = { 'DDUtils' => 'dong765@qq.com' }
s.source = { :git => "https://github.com/DamonHu/DDUtils.git", :tag => s.version}
s.requires_arc = true
s.ios.deployment_target = '11.0'
s.weak_frameworks = 'CryptoKit'
s.subspec 'core' do |cs|
    cs.source_files = "pod/extend/*.swift","pod/*.swift"
end
s.subspec 'idfa' do |cs|
    cs.source_files = "pod/subspec/DDUtils+idfa.swift"
    cs.dependency 'DDUtils/core'
end
s.default_subspecs = "core"
s.documentation_url = 'http://blog.hudongdong.com/swift/1079.html'
end
