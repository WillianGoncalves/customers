require 'rails_helper'

RSpec.describe CustomersController, type: :controller do
  context 'unauthenticated user' do
    describe 'GET #index' do
      before { get :index }
      it { expect(response).to redirect_to user_session_path }
    end
  end

  context 'authenticated user' do
    let(:user) { Fabricate :user }

    before { sign_in user }

    describe 'GET #index' do
      let(:customer) { Fabricate :customer }
      before { get :index }
      it { expect(response.status).to eq 200 }
      it { expect(assigns(:customers)).to eq [customer] }
    end

    describe 'POST #create' do
      context 'with invalid values' do
        context 'like blank required fields' do
          let(:address) { { street: '', city: '', state: '', country: '' } }
          let(:phone) { { number: '' } }
          before { post :create, params: { customer: { first_name: '', last_name: '', avatar: '', gender: :male, address_attributes: address, phones_attributes: [phone] } } }
          it { expect(assigns(:customer).errors.any?).to eq true }
          it { expect(response).to render_template :new }
          it { expect(response.status).to eq 400 }
          it { expect(Customer.count).to eq 0 }
        end

        context 'like blank address' do
          let(:phone) { { number: 'number' } }
          before { post :create, params: { customer: { first_name: 'foo', last_name: 'bar', avatar: 'foo_avatar', gender: :male, phones_attributes: [phone] } } }
          it { expect(assigns(:customer).errors.any?).to eq true }
          it { expect(response).to render_template :new }
          it { expect(response.status).to eq 400 }
          it { expect(Customer.count).to eq 0 }
        end

        context 'like blank phones' do
          let(:address) { { street: 'street', city: 'city', state: 'state', country: 'country' } }
          before { post :create, params: { customer: { first_name: 'foo', last_name: 'bar', avatar: 'foo_avatar', gender: :male, address_attributes: address } } }
          it { expect(assigns(:customer).errors.any?).to eq true }
          it { expect(response).to render_template :new }
          it { expect(response.status).to eq 400 }
          it { expect(Customer.count).to eq 0 }
        end
      end

      context 'with valid values' do
        let(:address) { { street: 'street', city: 'city', state: 'state', country: 'country' } }
        let(:phone) { { number: 'number' } }
        before { post :create, params: { customer: { first_name: 'foo', last_name: 'bar', avatar: 'foo_avatar', gender: :male, address_attributes: address, phones_attributes: [phone] } } }
        it { expect(response).to redirect_to customers_path }
        it { expect(Customer.count).to eq 1 }
      end
    end
  end
end
