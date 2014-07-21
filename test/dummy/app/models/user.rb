class User < ActiveRecord::Base

  serialize :features

  manage_features :awesome_feature, :other_feature

end
