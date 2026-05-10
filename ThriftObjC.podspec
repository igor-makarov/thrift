Pod::Spec.new do |s|
  s.name          = "ThriftObjC"
  s.version       = "0.11.1"
  s.summary       = "Apache Thrift is a lightweight, language-independent software stack with an associated code generation mechanism for RPC."
  s.description   = <<-DESC
The Apache Thrift software framework, for scalable cross-language services development, combines a software stack with a code generation engine to build services that work efficiently and seamlessly between C++, Java, Python, PHP, Ruby, Erlang, Perl, Haskell, C#, Cocoa, JavaScript, Node.js, Smalltalk, OCaml and Delphi and other languages.
                    DESC
  s.homepage      = "http://thrift.apache.org"
  s.license       = { :type => 'Apache License, Version 2.0', :url => 'https://raw.github.com/apache/thrift/thrift-0.9.0/LICENSE' }
  s.author        = { "The Apache Software Foundation" => "apache@apache.org" }
  s.requires_arc  = true
  s.ios.deployment_target     = '7.0'
  s.osx.deployment_target     = '10.8'
  s.watchos.deployment_target = '2.0'
  s.ios.framework     = 'CFNetwork'
  s.osx.framework     = 'CoreServices'
  s.source        = { :git => "https://github.com/igor-makarov/thrift", :tag => "#{s.version}" }
  s.module_name = "Thrift"
  s.header_dir = "Thrift"

  s.default_subspecs = ['ObjC']
  s.subspec 'ObjC' do |sp|
    sp.source_files = [
      'lib/cocoa/src/**/*.m',
      'lib/cocoa/include/Thrift/**/*.h',
    ]
    sp.public_header_files = 'lib/cocoa/include/Thrift/**/*.h'
    sp.header_mappings_dir = 'lib/cocoa/include/Thrift'
    sp.watchos.exclude_files = [
      'lib/cocoa/src/server/**/*.*',
      'lib/cocoa/include/Thrift/TSocketServer.h',
      'lib/cocoa/src/transport/THTTPTransport.m',
      'lib/cocoa/include/Thrift/THTTPTransport.h',
      'lib/cocoa/src/transport/TNSStreamTransport.m',
      'lib/cocoa/include/Thrift/TNSStreamTransport.h',
      'lib/cocoa/src/transport/TSocketTransport.m',
      'lib/cocoa/include/Thrift/TSocketTransport.h',
      'lib/cocoa/src/transport/TSSLSocketTransport.m',
      'lib/cocoa/include/Thrift/TSSLSocketTransport.h',
    ]
  end
end