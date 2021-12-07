Pod::Spec.new do |s|
s.name = 'ZXKitUtil'
s.swift_version = '5.0'
s.version = '3.2.3'
s.license= { :type => "Apache-2.0 License", :file => "LICENSE" }
s.summary = 'ZXKitUtil. A package library of commonly used functions on the iOS platform, which can realize multiple complex functions in one sentence'
s.homepage = 'https://github.com/ZXKitCode/ZXKitUtil'
s.authors = { 'ZXKitUtil' => 'dong765@qq.com' }
s.source = { :git => "https://github.com/ZXKitCode/ZXKitUtil.git", :tag => s.version}
s.requires_arc = true
s.ios.deployment_target = '10.0'
s.weak_frameworks = 'CryptoKit'
s.subspec 'core' do |cs|
    cs.source_files = "pod/extend/*.swift","pod/*.swift"
end
s.subspec 'idfa' do |cs|
    cs.source_files = "pod/subspec/ZXKitUtil+idfa.swift"
    cs.dependency 'ZXKitUtil/core'
end
s.default_subspecs = "core"
s.documentation_url = 'http://blog.hudongdong.com/swift/1079.html'
end
