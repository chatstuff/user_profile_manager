module UserProfileManager
  class App
    module PhoneHelper
    	def self.ascii_is_numeric? (ascii)
    		ascii >= '0'.ord && ascii <= '9'.ord
    	end

      def self.is_valid?(phone)
      	# TODO: add more validations, try using some gem or something
      	is_valid = true
      	phone.each_byte do |i|
      		break if false == (is_valid = PhoneHelper.ascii_is_numeric? i)
      	end
      	is_valid
      end
    end

    helpers PhoneHelper
  end
end
