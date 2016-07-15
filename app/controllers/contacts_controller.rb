class ContactsController < ApplicationController

  def index
    @contacts = Contact.all.sort_by(&:last_name)
  end

  def new
  end

  def create
    @contact = Contact.new(
      first_name: params[:first_name],
      middle_name: params[:middle_name],
      last_name: params[:last_name],
      email: params[:email],
      phone_number: params[:phone_number],
      bio: params[:bio]
    )
    @contact.save

    redirect_to "/contacts/#{@contact.id}"
  end

  def show
    @contact = Contact.find_by(id: params[:id])
  end

  def edit
    @contact = Contact.find_by(id: params[:id])
  end

  def update
    @contact = Contact.find_by(id: params[:id])
    @contact.update(
      first_name: params[:first_name],
      middle_name: params[:middle_name],
      last_name: params[:last_name],
      email: params[:email],
      phone_number: params[:phone_number],
      bio: params[:bio]
    )
    redirect_to "/contacts/#{@contact.id}"
  end

  def destroy
    @contact = Contact.find_by(id: params[:id])
    @contact.destroy

    redirect_to "/contacts"
  end
end