class ContactsController < ApplicationController

  def all_contacts
    @contacts = Contact.all
    render :contacts
  end

  def first_contact
    @contact = Contact.first
    render :contact
  end
end
