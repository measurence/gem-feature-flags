
# TODO throw exception when trying to manage unmanaged features instead of
# failing silently.

module FeatureFlags
  extend ActiveSupport::Concern

  included do
  end

  module ClassMethods
    def manage_features(*features, **options)

      features_field = options[:field] || :features

      master_feature = options[:master_feature] || "__master"

      define_method :available_features do
        features
      end

      define_method "set_feature_status!" do |feature, status|
        raise "feature status must be a boolean" unless status.is_a?(TrueClass) || status.is_a?(FalseClass)
        send("#{features_field}=", {}) unless send(features_field).is_a?(Hash)
        (features.include?(feature) || feature == master_feature) &&
        send(features_field)[feature.to_s] = status
      end

      define_method "get_feature_status" do |feature|
        (features.include?(feature) || feature == master_feature) &&
        send(features_field).is_a?(Hash) &&
        send(features_field)[feature.to_s]
      end

      define_method "feature_enabled?" do |feature|
        get_feature_status(feature) == true || master_feature_enabled?
      end

      define_method "enable_feature!" do |feature|
        set_feature_status!(feature, true)
      end

      define_method "disable_feature!" do |feature|
        set_feature_status!(feature, false)
      end

      define_method "master_feature_enabled?" do
        get_feature_status(master_feature) == true
      end

      define_method "enable_master_feature!" do
        set_feature_status!(master_feature, true)
      end

      define_method "disable_master_feature!" do
        set_feature_status!(master_feature, false)
      end

      features.each do |feature|

        define_method "#{feature.to_s.underscore}_enabled?" do
          feature_enabled?(feature)
        end

        define_method "enable_#{feature.to_s.underscore}!" do
          enable_feature!(feature)
        end

        define_method "disable_#{feature.to_s.underscore}!" do
          disable_feature!(feature)
        end

      end

    end
  end
end

ActiveRecord::Base.send :include, FeatureFlags
