class ContactsController < ApplicationController

  def index
    if current_user
      if params[:group]
        selected_group = Group.find_by(id: params[:group])
        @contacts = selected_group.contacts.where(user_id: current_user.id)
      else 
        @contacts = current_user.contacts
      end
    else
      flash[:warning] = 'Please log in.'
      redirect_to '/login'
    end
  end

  def new
    @contact = Contact.new
  end

  def create
    coordinates = Geocoder.coordinates(params[:address])
    if coordinates
      computed_latitude = coordinates[0]
      computed_longitude = coordinates[1]
    else
      computed_latitude = nil
      computed_longitude = nil
    end

    @contact = Contact.new(
      first_name: params[:first_name],
      middle_name: params[:middle_name],
      last_name: params[:last_name],
      email: params[:email],
      phone_number: params[:phone_number],
      bio: params[:bio],
      latitude: computed_latitude,
      longitude: computed_longitude,
      user_id: current_user.id
    )
    if @contact.save
      flash[:success] = 'Contact successfully created.'
      redirect_to "/contacts/#{@contact.id}"
    else
      render 'new'
    end
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
    coordinates = Geocoder.coordinates(params[:address])
    if coordinates
      computed_latitude = coordinates[0]
      computed_longitude = coordinates[1]
    else
      computed_latitude = nil
      computed_longitude = nil
    end

    @contact = Contact.find_by(id: params[:id])
    if @contact.update(
      first_name: params[:first_name],
      middle_name: params[:middle_name],
      last_name: params[:last_name],
      email: params[:email],
      phone_number: params[:phone_number],
      latitude: computed_latitude,
      longitude: computed_longitude,
      bio: params[:bio]
      )
      flash[:success] = 'Contact successfully saved.'
      redirect_to "/contacts/#{@contact.id}"
    else
      render 'edit'
    end
  end

  def destroy
    @contact = Contact.find_by(id: params[:id])
    @contact.destroy

    redirect_to "/contacts"
  end
end