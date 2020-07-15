Pod::Spec.new do |s|
s.name = 'HDSwiftCommonTools'
s.swift_version = '5.0'
s.version = '1.3.6'
s.license= { :type => "MIT", :file => "LICENSE" }
s.summary = 'HDCommonTools的Swift版本，简单高效的集成常用功能'
s.homepage = 'https://github.com/DamonHu/HDSwiftCommonTools'
s.authors = { 'DamonHu' => 'dong765@qq.com' }
s.source = { :git => "https://github.com/DamonHu/HDSwiftCommonTools.git", :tag => s.version}
s.requires_arc = true
s.ios.deployment_target = '10.0'
s.source_files = "HDSwiftCommonTools/HDSwiftCommonTools/**/*.swift","HDSwiftCommonTools/HDSwiftCommonTools/*.swift"
# s.frameworks = 'UIKit'
s.documentation_url = 'http://blog.hudongdong.com/swift/1079.html'
end