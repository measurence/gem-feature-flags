class AltUser < ActiveRecord::Base

  serialize :flags

  manage_features :awesome_feature, :other_feature, field: :flags

end
