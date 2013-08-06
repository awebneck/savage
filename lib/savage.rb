%w[ utils transformable direction path parser ].each do |library|
  require_relative "savage/#{library}"
end
