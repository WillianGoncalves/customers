require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  context 'unauthenticated user' do
    describe 'Get #index' do
      before { get :index }
      it { expect(response).to redirect_to user_session_path }
    end
  end
end
