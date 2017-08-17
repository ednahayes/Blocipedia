class ChargesController < ApplicationController
  
 def new
   @stripe_btn_data = {
     key: "#{ Rails.configuration.stripe[:publishable_key] }",
     description: "Blocipedia membership updated to premium- #{current_user.username}",
     amount: 15_00
   }
 end
  
  def create
   
   @user = current_user
   
   # Creates a Stripe Customer object, for associating
   # with the charge
   customer = Stripe::Customer.create(
     email: current_user.email,
     card: params[:stripeToken]
   )
 
   # Where the real magic happens
   charge = Stripe::Charge.create(
     customer: customer.id, # Note -- this is NOT the user_id in your app
     amount: 15_00,
     description: "Upgrade to premium - #{current_user.email}",
     currency: 'usd'
   )

   

   if current_user.save!
    upgrade_user_role
    flash[:notice] = "Thanks for your payment, #{current_user.email}! You are now a premium member."
    redirect_to root_path(current_user) # or wherever
   end
   # Stripe will send back CardErrors, with friendly messages
   # when something goes wrong.
   # This `rescue block` catches and displays those errors.
   rescue Stripe::CardError => e
     flash[:alert] = e.message
     redirect_to new_charge_path
  end
  
  def destroy
  
    subscription = Stripe::Subscription.retrieve("sub_3R3PlB2YlJe84a")
    subscription.delete(:at_period_end => true)
   
    current_user.update_attributes(role: 'standard')
    current_user.wikis.where(private: true).update_all(private: false)
    
    
    flash[:notice] = "You are now a Standard Member."
    redirect_to wikis_path
  end
  
  private

  def upgrade_user_role
    @user.role = 'premium'
  end  
  
end
