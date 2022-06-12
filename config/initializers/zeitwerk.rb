Rails.autoloaders.each do |autoloader|
  autoloader.ignore(Dir[Rails.root.join('app', '**', '*{_spec.rb}')])
end
