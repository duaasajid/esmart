module RemovableFile
  extend ActiveSupport::Concern

  included do

    def self.has_removable_file(*attr_names)
      attr_names.each do |attr_name|
        accessor_name = "remove_#{attr_name}".to_sym
        remove_method_name = "handle_remove_#{attr_name}".to_sym
        remove_predicate_name = "remove_#{attr_name}?".to_sym

        attr_accessor accessor_name

        before_save remove_method_name

        define_method remove_method_name do
          self.send(attr_name).purge if send(remove_predicate_name)
        end

        define_method remove_predicate_name do
          ActiveModel::Type::Boolean.new.cast(send(accessor_name) || '0')
        end
      end

    end

  end

end