#
# rb_main.rb
# TVRenamer
#
# Created by Bodaniel Jeanes on 3/02/10.
# Copyright Bodaniel Jeanes 2010. All rights reserved.
#

$:.map! { |x| x.sub(/^\/Library\/Frameworks/, NSBundle.mainBundle.privateFrameworksPath) }
$:.unshift NSBundle.mainBundle.resourcePath.fileSystemRepresentation

# Loading the Cocoa framework. If you need to load more frameworks, you can
# do that here too.
framework 'Cocoa'

# Loading all the Ruby project files.
main = File.basename(__FILE__, File.extname(__FILE__))
dir_path = NSBundle.mainBundle.resourcePath.fileSystemRepresentation
Dir.glob(File.join(dir_path, '*.{rb,rbo}')).map { |x| File.basename(x, File.extname(x)) }.uniq.each do |path|
  if path != main
    require(path)
  end
end

# Starting the Cocoa main loop.
NSApplicationMain(0, nil)
