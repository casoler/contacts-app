class Contact < ActiveRecord::Base

  def self.friendly_strftime(adate)
    adate.strftime('%A, %d %b %Y %l:%M %p')
  end

  def full_name
    first_name + " " + (middle_name || "") + " " + last_name
  end

  def japanese_phone_number
    '+81 ' + phone_number
  end
end