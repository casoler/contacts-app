class Contact < ActiveRecord::Base
  belongs_to :user
  has_many :contact_groups
  has_many :groups, through: :contact_groups


  def self.friendly_strftime(adate)
    adate.strftime('%A, %d %b %Y %l:%M %p')
  end

  def full_name
    first_name + " " + (middle_name || "") + " " + last_name
  end

  def japanese_phone_number
    '+81 ' + phone_number
  end

  def self.find_all_johns
    Contact.where(first_name: 'John')  #find all
  end
end