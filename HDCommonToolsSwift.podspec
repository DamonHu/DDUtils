Pod::Spec.new do |s|
s.name = 'HDCommonToolsSwift'
s.swift_version = '5.0'
s.version = '2.1.0'
s.license= { :type => "MIT", :file => "LICENSE" }
s.summary = 'HDCommonTools的Swift版本，简单高效的集成常用功能'
s.homepage = 'https://github.com/DamonHu/HDCommonToolsSwift'
s.authors = { 'DamonHu' => 'dong765@qq.com' }
s.source = { :git => "https://github.com/DamonHu/HDCommonToolsSwift.git", :tag => s.version}
s.requires_arc = true
s.ios.deployment_target = '10.0'
s.source_files = "HDCommonToolsSwift/HDCommonToolsSwift/extend/*.swift","HDCommonToolsSwift/HDCommonToolsSwift/*.swift"
s.subspec 'idfa' do |cs|
    cs.source_files = "HDCommonToolsSwift/HDCommonToolsSwift/subspec/HDCommonToolsSwift+idfa.swift"
end
s.default_subspecs = :none
s.documentation_url = 'http://blog.hudongdong.com/swift/1079.html'
end