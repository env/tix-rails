require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe TicketTemplatesController do

  # This should return the minimal set of attributes required to create a valid
  # TicketTemplate. As you add validations to TicketTemplate, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {}
  end
  
  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # TicketTemplatesController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all ticket_templates as @ticket_templates" do
      ticket_template = TicketTemplate.create! valid_attributes
      get :index, {}, valid_session
      assigns(:ticket_templates).should eq([ticket_template])
    end
  end

  describe "GET show" do
    it "assigns the requested ticket_template as @ticket_template" do
      ticket_template = TicketTemplate.create! valid_attributes
      get :show, {:id => ticket_template.to_param}, valid_session
      assigns(:ticket_template).should eq(ticket_template)
    end
  end

  describe "GET new" do
    it "assigns a new ticket_template as @ticket_template" do
      get :new, {}, valid_session
      assigns(:ticket_template).should be_a_new(TicketTemplate)
    end
  end

  describe "GET edit" do
    it "assigns the requested ticket_template as @ticket_template" do
      ticket_template = TicketTemplate.create! valid_attributes
      get :edit, {:id => ticket_template.to_param}, valid_session
      assigns(:ticket_template).should eq(ticket_template)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new TicketTemplate" do
        expect {
          post :create, {:ticket_template => valid_attributes}, valid_session
        }.to change(TicketTemplate, :count).by(1)
      end

      it "assigns a newly created ticket_template as @ticket_template" do
        post :create, {:ticket_template => valid_attributes}, valid_session
        assigns(:ticket_template).should be_a(TicketTemplate)
        assigns(:ticket_template).should be_persisted
      end

      it "redirects to the created ticket_template" do
        post :create, {:ticket_template => valid_attributes}, valid_session
        response.should redirect_to(TicketTemplate.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved ticket_template as @ticket_template" do
        # Trigger the behavior that occurs when invalid params are submitted
        TicketTemplate.any_instance.stub(:save).and_return(false)
        post :create, {:ticket_template => {}}, valid_session
        assigns(:ticket_template).should be_a_new(TicketTemplate)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        TicketTemplate.any_instance.stub(:save).and_return(false)
        post :create, {:ticket_template => {}}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested ticket_template" do
        ticket_template = TicketTemplate.create! valid_attributes
        # Assuming there are no other ticket_templates in the database, this
        # specifies that the TicketTemplate created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        TicketTemplate.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => ticket_template.to_param, :ticket_template => {'these' => 'params'}}, valid_session
      end

      it "assigns the requested ticket_template as @ticket_template" do
        ticket_template = TicketTemplate.create! valid_attributes
        put :update, {:id => ticket_template.to_param, :ticket_template => valid_attributes}, valid_session
        assigns(:ticket_template).should eq(ticket_template)
      end

      it "redirects to the ticket_template" do
        ticket_template = TicketTemplate.create! valid_attributes
        put :update, {:id => ticket_template.to_param, :ticket_template => valid_attributes}, valid_session
        response.should redirect_to(ticket_template)
      end
    end

    describe "with invalid params" do
      it "assigns the ticket_template as @ticket_template" do
        ticket_template = TicketTemplate.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        TicketTemplate.any_instance.stub(:save).and_return(false)
        put :update, {:id => ticket_template.to_param, :ticket_template => {}}, valid_session
        assigns(:ticket_template).should eq(ticket_template)
      end

      it "re-renders the 'edit' template" do
        ticket_template = TicketTemplate.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        TicketTemplate.any_instance.stub(:save).and_return(false)
        put :update, {:id => ticket_template.to_param, :ticket_template => {}}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested ticket_template" do
      ticket_template = TicketTemplate.create! valid_attributes
      expect {
        delete :destroy, {:id => ticket_template.to_param}, valid_session
      }.to change(TicketTemplate, :count).by(-1)
    end

    it "redirects to the ticket_templates list" do
      ticket_template = TicketTemplate.create! valid_attributes
      delete :destroy, {:id => ticket_template.to_param}, valid_session
      response.should redirect_to(ticket_templates_url)
    end
  end

end
