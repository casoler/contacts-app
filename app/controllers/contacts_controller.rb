class ContactsController < ApplicationController

  def index
    if current_user
      @contacts = Contact.where(user_id: current_user.id).sort_by(&:last_name)
    else
      flash[:warning] = 'Please log in.'
      redirect_to '/login'
    end
  end

  def new
  end

  def create
    coordinates = Geocoder.coordinates(params[:address])
    p coordinates
    @contact = Contact.new(
      first_name: params[:first_name],
      middle_name: params[:middle_name],
      last_name: params[:last_name],
      email: params[:email],
      phone_number: params[:phone_number],
      bio: params[:bio],
      latitude: coordinates[0],
      longitude: coordinates[1],
      user_id: current_user.id
    )
    @contact.save

    redirect_to "/contacts/#{@contact.id}"
  end

  def show
    if current_user
      @contact = Contact.find_by(id: params[:id], user_id: current_user.id)
      unless @contact
        flash[:warning] = 'You are unauthorized to view this record.'
        redirect_to '/contacts'
      end
    else
      flash[:warning] = 'Please log in.'
      redirect_to '/login'
    end
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