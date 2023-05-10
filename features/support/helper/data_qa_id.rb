require 'page-object'

## This is a module to add data_qa_id as a custom selector
module PageObject
  module Elements
    class DataQAId < PageObject::Elements::Element
      def self.matches?(obj)
        obj =~ /^data_qa_id=(.+)/
      end

      def initialize(element, platform)
        @element = element
        @platform = platform
      end

      def locator
        @element
      end

      def tag_name
        @platform.tag_name_for(@element)
      end

      def attribute_value(attribute)
        @platform.attribute_value(@element, attribute)
      end
    end

    ::PageObject::Elements.tag_to_class[:data_qa_id] = ::PageObject::Elements::DataQAId
  end
end
