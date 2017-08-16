require 'models'

RSpec.describe "ActiveRecord::Base subclass with #acts_as" do
  before { initialize_schema }
  
  context 'create' do
    let(:user) { create(:user, slug: 'username') }
    context 'without existing actable' do
      it 'creates a new actable object' do
        expect(user.acting_as).to be
        expect(user.acting_as).to be_a(Person)
        expect(user.acting_as.slug).to eq('username')
      end
    end
    context 'with existing actable' do
      before { @person = create(:person, slug: 'username') }
      it 'creates a new actable object' do
        expect(user.acting_as).to be
        expect(user.acting_as).to be_a(Person)
        expect(user.acting_as.slug).to eq('username')
        expect(user.acting_as).not_to eq(@person)
      end
    end
  end
end
